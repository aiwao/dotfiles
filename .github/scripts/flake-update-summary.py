#!/usr/bin/env python3
import argparse
import json
from pathlib import Path


MAX_PACKAGE_REBUILDS = 20


def locked(node):
    return (node or {}).get("locked")


def source(node):
    data = locked(node) or {}
    owner = data.get("owner")
    repo = data.get("repo")
    if data.get("type") == "github" and owner and repo:
        return f"[{owner}/{repo}](https://github.com/{owner}/{repo})"
    if data.get("url"):
        return f"`{data['url']}`"
    if owner and repo:
        return f"`{owner}/{repo}`"
    if data.get("type"):
        return f"`{data['type']}`"
    return ""


def short_rev(rev):
    return rev[:12]


def value(node):
    data = locked(node) or {}
    rev = data.get("rev")
    owner = data.get("owner")
    repo = data.get("repo")
    if rev and data.get("type") == "github" and owner and repo:
        return f"[`{short_rev(rev)}`](https://github.com/{owner}/{repo}/commit/{rev})"
    if rev:
        return f"`{short_rev(rev)}`"
    if "lastModified" in data:
        return f"`{data['lastModified']}`"
    if "narHash" in data:
        return f"`{data['narHash'][:18]}...`"
    return "`missing`"


def compare(old_node, new_node):
    old = locked(old_node) or {}
    new = locked(new_node) or {}
    old_rev = old.get("rev")
    new_rev = new.get("rev")
    owner = new.get("owner") or old.get("owner")
    repo = new.get("repo") or old.get("repo")
    lock_type = new.get("type") or old.get("type")
    if lock_type == "github" and owner and repo and old_rev and new_rev:
        url = f"https://github.com/{owner}/{repo}/compare/{old_rev}...{new_rev}"
        return f"[compare]({url})"
    return ""


def load_json(path):
    return json.loads(path.read_text())


def root_input_node(lock, input_name):
    nodes = lock.get("nodes", {})
    root_name = lock.get("root", "root")
    root_node = nodes.get(root_name, {})
    target = root_node.get("inputs", {}).get(input_name)
    return target if isinstance(target, str) else None


def root_input_changed(before, after, input_name):
    old_node = root_input_node(before, input_name)
    new_node = root_input_node(after, input_name)
    if not old_node or not new_node:
        return False
    return locked(before.get("nodes", {}).get(old_node)) != locked(
        after.get("nodes", {}).get(new_node)
    )


def display_version(package):
    return package.get("version") or package.get("drvName") or "unknown"


def package_map(packages):
    return {package["name"]: package for package in packages}


def normalize_manifests(data):
    if isinstance(data, list):
        return data
    if "targets" in data:
        return data["targets"]
    return [data]


def compare_package_manifests(before_manifest, after_manifest):
    old_targets = {
        target["system"]: target
        for target in normalize_manifests(before_manifest)
    }
    new_targets = {
        target["system"]: target
        for target in normalize_manifests(after_manifest)
    }

    version_updates = []
    rebuilds = []
    added = []
    removed = []

    for system in sorted(set(old_targets) | set(new_targets)):
        old_packages = package_map(old_targets.get(system, {}).get("packages", []))
        new_packages = package_map(new_targets.get(system, {}).get("packages", []))
        package_names = sorted(set(old_packages) | set(new_packages))

        for name in package_names:
            old_package = old_packages.get(name)
            new_package = new_packages.get(name)
            if old_package is None:
                added.append((system, name, display_version(new_package)))
                continue
            if new_package is None:
                removed.append((system, name, display_version(old_package)))
                continue

            old_version = display_version(old_package)
            new_version = display_version(new_package)
            if old_version != new_version:
                version_updates.append((system, name, old_version, new_version))
            elif old_package.get("drvPath") != new_package.get("drvPath"):
                rebuilds.append((system, name, old_version))

    return version_updates, rebuilds, added, removed


def format_systems(systems):
    return ", ".join(f"`{system}`" for system in systems)


def group_version_updates(version_updates):
    groups = {}
    for system, name, old_version, new_version in version_updates:
        key = (name, old_version, new_version)
        groups.setdefault(key, set()).add(system)

    return sorted(
        [
            (sorted(systems), name, old_version, new_version)
            for (name, old_version, new_version), systems in groups.items()
        ],
        key=lambda item: (item[1], item[2], item[3], item[0]),
    )


def print_package_summary(package_manifest_before, package_manifest_after):
    version_updates, rebuilds, added, removed = compare_package_manifests(
        package_manifest_before,
        package_manifest_after,
    )

    print("## Package updates")
    print()
    print("Evaluated Home Manager `config.home.packages` for selected systems.")
    print()

    if version_updates:
        print("| Systems | Package | Before | After |")
        print("| --- | --- | --- | --- |")
        for systems, name, old_version, new_version in group_version_updates(
            version_updates
        ):
            print(
                f"| {format_systems(systems)} | `{name}` | "
                f"`{old_version}` | `{new_version}` |"
            )
    else:
        print("No direct package version changes detected.")

    if added:
        print()
        print("Added packages:")
        for system, name, version in added:
            print(f"- `{system}`: `{name}` `{version}`")

    if removed:
        print()
        print("Removed packages:")
        for system, name, version in removed:
            print(f"- `{system}`: `{name}` `{version}`")

    if rebuilds:
        shown = rebuilds[:MAX_PACKAGE_REBUILDS]
        rebuild_list = ", ".join(f"`{system}/{name}`" for system, name, _ in shown)
        remaining = len(rebuilds) - len(shown)
        suffix = f", and {remaining} more" if remaining else ""
        print()
        print(f"Rebuilt without version changes: {rebuild_list}{suffix}.")


def print_summary(
    before_path,
    after_path,
    package_manifest_before_path=None,
    package_manifest_after_path=None,
):
    before = load_json(before_path)
    after = load_json(after_path)

    old_nodes = before.get("nodes", {})
    new_nodes = after.get("nodes", {})
    names = sorted(set(old_nodes) | set(new_nodes))
    updates = [
        name
        for name in names
        if locked(old_nodes.get(name)) != locked(new_nodes.get(name))
    ]

    print("# Automated flake.lock update")
    print()

    if updates:
        print("## Updated inputs")
        print()
        print("| Input | Source | Before | After | Diff |")
        print("| --- | --- | --- | --- | --- |")
        for name in updates:
            old_node = old_nodes.get(name)
            new_node = new_nodes.get(name)
            print(
                f"| `{name}` | {source(new_node or old_node)} | "
                f"{value(old_node)} | {value(new_node)} | "
                f"{compare(old_node, new_node)} |"
            )
    else:
        print("No flake input changes detected.")

    if (
        package_manifest_before_path
        and package_manifest_after_path
        and root_input_changed(before, after, "nixpkgs")
    ):
        print()
        print_package_summary(
            load_json(package_manifest_before_path),
            load_json(package_manifest_after_path),
        )


def parse_args():
    parser = argparse.ArgumentParser(
        description="Print a Markdown summary for flake.lock changes.",
    )
    parser.add_argument("before", type=Path, help="Path to the previous flake.lock")
    parser.add_argument("after", type=Path, help="Path to the updated flake.lock")
    parser.add_argument(
        "--package-manifest-before",
        type=Path,
        help="Path to package manifest JSON from the previous flake.lock",
    )
    parser.add_argument(
        "--package-manifest-after",
        type=Path,
        help="Path to package manifest JSON from the updated flake.lock",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    print_summary(
        args.before,
        args.after,
        args.package_manifest_before,
        args.package_manifest_after,
    )


if __name__ == "__main__":
    main()

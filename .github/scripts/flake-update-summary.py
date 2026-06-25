#!/usr/bin/env python3
import argparse
import json
from pathlib import Path


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


def print_summary(before_path, after_path):
    before = json.loads(before_path.read_text())
    after = json.loads(after_path.read_text())

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


def parse_args():
    parser = argparse.ArgumentParser(
        description="Print a Markdown summary for flake.lock changes.",
    )
    parser.add_argument("before", type=Path, help="Path to the previous flake.lock")
    parser.add_argument("after", type=Path, help="Path to the updated flake.lock")
    return parser.parse_args()


def main():
    args = parse_args()
    print_summary(args.before, args.after)


if __name__ == "__main__":
    main()

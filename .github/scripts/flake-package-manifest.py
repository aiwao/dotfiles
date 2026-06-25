#!/usr/bin/env python3
import argparse
import json
import re
import subprocess
import sys


DEFAULT_SYSTEMS = [
    "aarch64-darwin",
    "x86_64-linux",
    "aarch64-linux",
]


def nix_expr(system):
    return (
        'import ./.github/scripts/flake-package-manifest.nix '
        f'{{ system = "{system}"; }}'
    )


def collect_manifest(system):
    result = subprocess.run(
        [
            "nix",
            "eval",
            "--json",
            "--impure",
            "--expr",
            nix_expr(system),
        ],
        check=True,
        stdout=subprocess.PIPE,
        text=True,
    )
    return json.loads(result.stdout)


def parse_args():
    parser = argparse.ArgumentParser(
        description="Collect package versions from evaluated Home Manager configs.",
    )
    parser.add_argument(
        "--system",
        action="append",
        dest="systems",
        help="System to evaluate. May be passed more than once.",
    )
    return parser.parse_args()


def validate_systems(systems):
    for system in systems:
        if not re.fullmatch(r"[A-Za-z0-9_+-]+", system):
            raise ValueError(f"invalid system value: {system}")


def main():
    args = parse_args()
    systems = args.systems or DEFAULT_SYSTEMS
    validate_systems(systems)

    json.dump(
        {"targets": [collect_manifest(system) for system in systems]},
        sys.stdout,
        indent=2,
    )
    print()


if __name__ == "__main__":
    main()

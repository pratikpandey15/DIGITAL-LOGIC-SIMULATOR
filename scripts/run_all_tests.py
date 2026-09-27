#!/usr/bin/env python3
"""Run the repository test suite for the configured categories."""

import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

CATEGORIES = ["gates", "combinational", "arithmetic", "sequential", "fsm", "memory"]


def main():
    print("========================================")
    print("DIGITAL LOGIC SIMULATOR TEST SUITE")
    print("========================================")

    for category in CATEGORIES:
        script = ROOT / "scripts" / "run_simulation.py"
        print(f"\nRunning {category} tests...")
        proc = subprocess.run([sys.executable, str(script), "--category", category], cwd=str(ROOT))
        if proc.returncode != 0:
            print(f"{category} tests failed with exit code {proc.returncode}")
            return proc.returncode

    print("\nAll configured tests completed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

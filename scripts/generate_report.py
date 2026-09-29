#!/usr/bin/env python3
"""Summarize PASS/FAIL simulation results stored in the results folder."""

from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RESULTS_DIR = ROOT / "results"


def load_results():
    records = []
    for path in sorted(RESULTS_DIR.glob("*.txt")):
        lines = path.read_text(encoding="utf-8").splitlines()
        status = "UNKNOWN"
        for line in lines:
            if "STATUS" in line.upper() or "PASS" in line.upper() or "FAIL" in line.upper():
                status = line.strip().split(":", 1)[-1].strip() if ":" in line else line.strip()
                break
        records.append((path.stem, status))
    return records


def main():
    records = load_results()
    if not records:
        print("No simulation results found in results/.")
        return 0

    print("========================================")
    print("DIGITAL LOGIC SIMULATOR REPORT")
    print("========================================")
    print("Category\tStatus")
    for name, status in records:
        print(f"{name}\t{status}")

    passed = sum(1 for _, status in records if status.upper() == "PASS")
    failed = sum(1 for _, status in records if status.upper() == "FAIL")
    print("========================================")
    print(f"Passed: {passed}")
    print(f"Failed: {failed}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""Run selected HDL simulations using Icarus Verilog if available."""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BUILD_DIR = ROOT / "build"
SIM_DIR = ROOT / "simulations"
WAVE_DIR = ROOT / "waveforms"
RESULTS_DIR = ROOT / "results"

CATEGORY_FILES = {
    "gates": [
        ROOT / "src/gates/and_gate.v",
        ROOT / "src/gates/or_gate.v",
        ROOT / "src/gates/not_gate.v",
        ROOT / "src/gates/nand_gate.v",
        ROOT / "src/gates/nor_gate.v",
        ROOT / "src/gates/xor_gate.v",
        ROOT / "src/gates/xnor_gate.v",
        ROOT / "src/gates/buffer.v",
        ROOT / "testbench/gates/gates_tb.v",
    ],
    "combinational": [
        ROOT / "src/combinational/half_adder.v",
        ROOT / "src/combinational/full_adder.v",
        ROOT / "src/combinational/half_subtractor.v",
        ROOT / "src/combinational/full_subtractor.v",
        ROOT / "src/combinational/mux_2to1.v",
        ROOT / "src/combinational/mux_4to1.v",
        ROOT / "src/combinational/decoder_2to4.v",
        ROOT / "src/combinational/decoder_3to8.v",
        ROOT / "src/combinational/priority_encoder.v",
        ROOT / "src/combinational/comparator_4bit.v",
        ROOT / "testbench/combinational/full_adder_tb.v",
        ROOT / "testbench/combinational/decoder_tb.v",
        ROOT / "testbench/combinational/comparator_tb.v",
    ],
    "arithmetic": [
        ROOT / "src/arithmetic/ripple_carry_adder.v",
        ROOT / "src/arithmetic/adder_subtractor.v",
        ROOT / "src/arithmetic/alu.v",
        ROOT / "testbench/arithmetic/ripple_adder_tb.v",
    ],
    "sequential": [
        ROOT / "src/sequential/d_ff.v",
        ROOT / "src/sequential/register.v",
        ROOT / "src/sequential/shift_register.v",
        ROOT / "testbench/sequential/d_ff_tb.v",
    ],
    "fsm": [
        ROOT / "src/fsm/traffic_light_controller.v",
        ROOT / "testbench/fsm/traffic_light_tb.v",
    ],
    "memory": [
        ROOT / "src/memory/ram.v",
        ROOT / "testbench/memory/ram_tb.v",
    ],
}


def ensure_dirs():
    BUILD_DIR.mkdir(exist_ok=True)
    SIM_DIR.mkdir(exist_ok=True)
    WAVE_DIR.mkdir(exist_ok=True)
    RESULTS_DIR.mkdir(exist_ok=True)


def find_iverilog():
    candidates = [
        shutil.which("iverilog"),
        os.environ.get("IVERILOG_PATH"),
    ]
    for cand in candidates:
        if cand:
            return cand
    return None


def run_category(category: str):
    if category not in CATEGORY_FILES:
        raise ValueError(f"Unknown category: {category}")

    ensure_dirs()
    iverilog = find_iverilog()
    if not iverilog:
        print("iverilog is not installed or not on PATH. Unable to run simulation.")
        return 1

    files = CATEGORY_FILES[category]
    if not files:
        print(f"No simulation files configured for category: {category}")
        return 0

    output_name = f"{category}_sim"
    out_path = BUILD_DIR / output_name
    cmd = [iverilog, "-g2012", "-o", str(out_path)] + [str(p) for p in files]
    print("Running:", " ".join(cmd))
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(result.stderr)
        return result.returncode

    run_cmd = [str(out_path)]
    print("Executing:", " ".join(run_cmd))
    exec_result = subprocess.run(run_cmd, capture_output=True, text=True, cwd=str(ROOT))
    if exec_result.stdout:
        print(exec_result.stdout)
    if exec_result.stderr:
        print(exec_result.stderr)

    summary = f"{category}: {'PASS' if exec_result.returncode == 0 else 'FAIL'}\n"
    (RESULTS_DIR / f"{category}_summary.txt").write_text(summary, encoding="utf-8")
    return exec_result.returncode


def main():
    parser = argparse.ArgumentParser(description="Digital logic simulation runner")
    parser.add_argument("--category", choices=sorted(CATEGORY_FILES.keys()), help="Simulation category to run")
    args = parser.parse_args()

    if args.category:
        return run_category(args.category)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

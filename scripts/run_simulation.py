
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
        ROOT / "src/combinational/demux_1to2.v",
        ROOT / "src/combinational/decoder_2to4.v",
        ROOT / "src/combinational/decoder_3to8.v",
        ROOT / "src/combinational/encoder_4to2.v",
        ROOT / "src/combinational/priority_encoder.v",
        ROOT / "src/combinational/comparator_4bit.v",
        ROOT / "testbench/combinational/full_adder_tb.v",
        ROOT / "testbench/combinational/decoder_tb.v",
        ROOT / "testbench/combinational/comparator_tb.v",
        ROOT / "testbench/combinational/demux_tb.v",
        ROOT / "testbench/combinational/encoder_tb.v",
    ],
    "arithmetic": [
        ROOT / "src/arithmetic/ripple_carry_adder.v",
        ROOT / "src/arithmetic/adder_subtractor.v",
        ROOT / "src/arithmetic/alu.v",
        ROOT / "src/arithmetic/incrementer.v",
        ROOT / "src/arithmetic/decrementer.v",
        ROOT / "testbench/arithmetic/ripple_adder_tb.v",
    ],
    "sequential": [
        ROOT / "src/sequential/d_ff.v",
        ROOT / "src/sequential/sr_ff.v",
        ROOT / "src/sequential/jk_ff.v",
        ROOT / "src/sequential/t_ff.v",
        ROOT / "src/sequential/register.v",
        ROOT / "src/sequential/shift_register.v",
        ROOT / "src/sequential/counter_up.v",
        ROOT / "src/sequential/counter_down.v",
        ROOT / "src/sequential/counter_up_down.v",
        ROOT / "src/sequential/ring_counter.v",
        ROOT / "src/sequential/johnson_counter.v",
        ROOT / "testbench/sequential/d_ff_tb.v",
    ],
    "fsm": [
        ROOT / "src/fsm/traffic_light_controller.v",
        ROOT / "src/fsm/sequence_detector.v",
        ROOT / "src/fsm/vending_machine.v",
        ROOT / "src/fsm/pedestrian_controller.v",
        ROOT / "testbench/fsm/traffic_light_tb.v",
    ],
    "memory": [
        ROOT / "src/memory/ram.v",
        ROOT / "src/memory/rom.v",
        ROOT / "src/memory/register_file.v",
        ROOT / "src/memory/synchronous_fifo.v",
        ROOT / "testbench/memory/ram_tb.v",
    ],
}


def ensure_dirs():
    BUILD_DIR.mkdir(parents=True, exist_ok=True)
    SIM_DIR.mkdir(parents=True, exist_ok=True)
    WAVE_DIR.mkdir(parents=True, exist_ok=True)
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)


def find_iverilog():
    candidates = [
        shutil.which("iverilog"),
        os.environ.get("IVERILOG_PATH"),
    ]

    for candidate in candidates:
        if candidate:
            return candidate

    return None


def find_vvp():
    candidates = [
        shutil.which("vvp"),
        os.environ.get("VVP_PATH"),
    ]

    for candidate in candidates:
        if candidate:
            return candidate

    return None


def run_category(category: str):
    if category not in CATEGORY_FILES:
        raise ValueError(f"Unknown category: {category}")

    ensure_dirs()

    iverilog = find_iverilog()

    if not iverilog:
        print(
            "ERROR: iverilog is not installed or not on PATH. "
            "Unable to compile simulation."
        )
        return 1

    vvp = find_vvp()

    if not vvp:
        print(
            "ERROR: vvp is not installed or not on PATH. "
            "Install Icarus Verilog or configure VVP_PATH."
        )
        return 1

    files = CATEGORY_FILES[category]

    if not files:
        print(f"No simulation files configured for category: {category}")
        return 0

    # Check that every configured source/testbench file exists.
    missing_files = [str(path) for path in files if not path.is_file()]

    if missing_files:
        print("ERROR: The following simulation files were not found:")

        for path in missing_files:
            print(f"  - {path}")

        return 1

    output_name = f"{category}_sim"
    out_path = BUILD_DIR / output_name

    # Step 1: Compile Verilog source files.
    compile_cmd = [
        iverilog,
        "-g2012",
        "-s",
        {
            "gates": "gates_tb",
            "combinational": "full_adder_tb",
            "arithmetic": "ripple_adder_tb",
            "sequential": "d_ff_tb",
            "fsm": "traffic_light_tb",
            "memory": "ram_tb",
        }[category],
        "-o",
        str(out_path),
    ] + [str(path) for path in files]

    print(f"\n[{category.upper()}] Compiling simulation...")
    print("Running:", " ".join(compile_cmd))

    try:
        compile_result = subprocess.run(
            compile_cmd,
            capture_output=True,
            text=True,
            cwd=str(ROOT),
            check=False,
        )
    except OSError as error:
        print(f"ERROR: Could not start Icarus Verilog: {error}")
        return 1

    if compile_result.stdout:
        print(compile_result.stdout)

    if compile_result.stderr:
        print(compile_result.stderr)

    if compile_result.returncode != 0:
        print(f"COMPILATION FAILED: {category}")
        return compile_result.returncode

    # Step 2: Run the compiled simulation using VVP.
    run_cmd = [vvp, str(out_path)]

    print(f"\n[{category.upper()}] Executing simulation...")
    print("Running:", " ".join(run_cmd))

    try:
        exec_result = subprocess.run(
            run_cmd,
            capture_output=True,
            text=True,
            cwd=str(ROOT),
            check=False,
        )
    except OSError as error:
        print(f"ERROR: Could not start VVP: {error}")
        return 1

    if exec_result.stdout:
        print(exec_result.stdout)

    if exec_result.stderr:
        print(exec_result.stderr)

    # Step 3: Save the process result.
    if exec_result.returncode == 0:
        status = "PASS"
        print(f"\n[{category.upper()}] Simulation process completed.")
    else:
        status = "FAIL"
        print(f"\n[{category.upper()}] Simulation process failed.")

    summary = f"{category}: {status}\n"

    (RESULTS_DIR / f"{category}_summary.txt").write_text(
        summary,
        encoding="utf-8",
    )

    return exec_result.returncode


def main():
    parser = argparse.ArgumentParser(
        description="Digital logic simulation runner"
    )

    parser.add_argument(
        "--category",
        choices=sorted(CATEGORY_FILES.keys()),
        help="Simulation category to run",
    )

    args = parser.parse_args()

    if args.category:
        return run_category(args.category)

    parser.error("Please specify a category using --category.")


if __name__ == "__main__":
    raise SystemExit(main())

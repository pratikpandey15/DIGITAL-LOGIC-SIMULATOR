# Architecture Overview

The repository follows a modular digital design architecture that mirrors common HDL workflows used in university and industrial projects.

## Core Layers

1. Logic primitives: gates and simple building blocks
2. Functional blocks: arithmetic and combinational logic
3. Sequential logic: registers, flip-flops, counters, and state logic
4. System-level logic: FSM, memory, and controller examples
5. Verification layer: testbenches and waveform generation
6. Automation layer: Python scripts to trigger simulation runs

## Design Flow

Digital specification
      ↓
RTL / HDL implementation
      ↓
Testbench verification
      ↓
Simulation and waveform analysis
      ↓
Design review and debugging

## Why This Structure Helps

- Modules remain small and testable.
- Designers can trace a circuit from gate-level implementation to system-level behavior.
- Testbenches remain aligned with the corresponding DUT modules.
- The simulator and automation scripts are separate from the hardware logic, making verification cleaner.

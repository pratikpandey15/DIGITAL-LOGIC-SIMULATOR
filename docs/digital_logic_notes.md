# Digital Logic Notes

## Boolean Algebra

Boolean algebra is the mathematical foundation for digital logic. The core operations are:

- AND: multiplication-like operation
- OR: addition-like operation
- NOT: inversion
- XOR: exclusive OR

These operations describe how digital signals combine to form logic. In hardware, bits are represented as 0 or 1, and logic gates physically implement these functions.

## Truth Tables

Every digital logic block can be described by a truth table. Truth tables are useful because they show the complete mapping between inputs and outputs, which makes the design easier to validate and verify.

For example, the AND gate truth table is simple:

| A | B | Y |
| --- | --- | --- |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

## Combinational vs Sequential Circuits

Combinational circuits depend only on the current inputs. Their outputs are computed immediately and do not depend on past input values.

Sequential circuits depend on both current inputs and previous state. They use feedback, memory elements, or clocked behavior to store state.

Examples:

- Combinational: half adder, comparator, multiplexer
- Sequential: register, counter, shift register

## Flip-Flops and Memory Elements

A flip-flop is a bistable memory element that stores a single bit. It changes state only at defined times, typically on clock edges.

Common types include:

- SR flip-flop
- D flip-flop
- JK flip-flop
- T flip-flop

These elements form the basis for registers, counters, and finite-state machines.

## Registers and Counters

A register stores a word of digital data. A counter is a specialized register that increments or decrements on each clock event. Registers and counters are widely used in digital systems for timing, indexing, and state control.

## FSMs

A finite-state machine is a digital system whose behavior is described by states, transitions, and outputs. Each state corresponds to a machine condition, and the next state depends on inputs and the current state.

Traffic lights and vending machine controllers are classic FSM examples.

## Timing and Clocking

Clock signals determine when sequential logic updates its state. To ensure predictable behavior, designers must consider setup time, hold time, propagation delay, and reset timing.

A digital system must handle timing constraints carefully to avoid metastability and race conditions.

## RTL

Register-transfer level (RTL) design describes how data moves between registers and how logic transforms it. RTL is a common abstraction level used in digital design and verification.

Examples of RTL operations include:

- assigning values to registers
- conditional updates on clock edges
- arithmetic datapath operations

## Testbench and Simulation

A testbench provides stimulus for the design under test (DUT), applies inputs, checks outputs, and reports whether expected behavior matches the design intent.

Good testbenches should:

- apply a representative set of input values
- include reset and clock activity where needed
- compare results with expected values
- print clear PASS/FAIL indicators
- generate waveform output for debugging

## Waveforms

Waveforms visualize logic transitions over time. By inspecting a VCD waveform in GTKWave, designers can confirm whether signals rise and fall at the correct times and whether the logic follows the specified state transitions.

Waveform analysis is one of the most useful verification techniques in digital design because it exposes timing issues that static code inspection may miss.

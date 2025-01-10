## String Detector (1011) Module

### Overview

This repository contains the Verilog implementation of a **String Detector** module, which is designed to detect the binary sequence `1011` in an input bitstream. The design utilizes a finite state machine (FSM) approach, supporting both **Mealy** and **Moore** configurations, allowing flexibility in output timing behavior. The type of FSM can be selected using the parameter `FSM_MEALY`. 

The module is accompanied by a comprehensive testbench that provides automated validation of the module’s functionality, ensuring the correctness of the `match` signal. This makes the project suitable for learning FSM design concepts, implementing state-based logic, and understanding verification techniques in hardware design.

---

### Features

#### 1. **Configurable FSM Type**

The `string_detector` module can be configured to behave as either a **Mealy FSM** or a **Moore FSM**, depending on the parameter `FSM_MEALY`:
- **Mealy FSM (`FSM_MEALY = 1`)**:
  - The output `match` depends on both the current state and the input (`din`).
  - Provides faster response by asserting `match` during the transition from `S101` when `din` is `1`.

- **Moore FSM (`FSM_MEALY = 0`)**:
  - The output `match` depends solely on the current state.
  - Ensures a consistent output by asserting `match` only in the `S1011` state.

This flexibility allows users to explore and compare the behavior of both FSM types in a single design.

#### 2. **Efficient State Encoding**

The module employs a state encoding scheme optimized for detecting the `1011` sequence:
- **States**:
  - `IDLE`: Waiting for the first `1` in the sequence.
  - `S1`: Detected the first `1`.
  - `S10`: Detected the sequence `10`.
  - `S101`: Detected the sequence `101`.
  - `S1011`: Detected the complete sequence `1011`.

These states ensure that the detector can handle overlapping sequences, enabling detection even if the input continues to provide additional `1` bits after the initial detection.

#### 3. **Output Logic**

The module generates a `match` signal to indicate the detection of the `1011` sequence:
- **In Mealy FSM**:
  - The `match` signal is asserted during the `S101` state if the input `din` is `1`, indicating that the sequence `1011` is completed as part of the transition.

- **In Moore FSM**:
  - The `match` signal is asserted only in the `S1011` state, ensuring that the sequence `1011` has been fully processed.

This differentiation highlights the practical use cases of Mealy and Moore FSMs, showcasing their trade-offs between response time and output stability.

#### 4. **Simulation-Ready Testbench**

The included testbench (`test_bench.v`) is designed to rigorously test the functionality of the `string_detector` module:
- **Automated Verification**:
  - A `verify` task is used to compare the actual `match` output against the expected value.
  - Pass/fail results are displayed along with timestamps, providing clear feedback for debugging.

- **Input Stream Simulation**:
  - The testbench feeds a predefined binary stream (`101011011001011`) into the detector, including overlapping sequences.
  - This ensures that the detector can handle both sequential and non-sequential patterns.

- **Waveform Generation**:
  - The testbench generates a `.vcd` file for visualizing signal transitions and FSM behavior in tools like GTKWave.

---

### Applications

This module can serve as a foundational block in digital systems where specific patterns need to be detected in a continuous bitstream. Some potential applications include:
- Packet header recognition in communication systems.
- Event detection in signal processing.
- Trigger generation in control systems.

---

### Benefits of the Design

- **Educational Value**:
  - The design demonstrates FSM principles in a hardware description language (HDL), making it ideal for students and beginners.
  
- **Flexibility**:
  - Supports both Mealy and Moore FSMs, offering insights into their differences and use cases.

- **Reusable Component**:
  - The module can be easily integrated into larger designs that require pattern detection.

- **Comprehensive Validation**:
  - The testbench ensures robust testing of the design, reducing the likelihood of undetected bugs.

---

### Summary of Features

| Feature               | Description                                                                                     |
|-----------------------|-------------------------------------------------------------------------------------------------|
| Configurable FSM Type | Supports Mealy and Moore FSMs, controlled by the `FSM_MEALY` parameter.                         |
| State Encoding        | Five states (`IDLE`, `S1`, `S10`, `S101`, `S1011`) optimized for detecting the `1011` sequence. |
| Output Logic          | Generates a `match` signal to indicate detection, with behavior differing for Mealy and Moore.  |
| Automated Testbench   | Provides a detailed verification framework with pass/fail results and timestamps.               |

---


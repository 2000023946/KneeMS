# 🦵 KneeMS – Secure Domain State Machine

This repository contains the **domain-level Finite State Machine (FSM)** used by the KneeMS mobile app.

The FSM is **type-safe, proof-driven, and correct-by-construction**.  
Illegal state transitions are **unrepresentable at compile time**.

This design is optimized for:
- Hardware-backed workflows (BLE)
- Long-term maintainability
- Future contributors who do not know the full system context

---

## 🛡️ Core Idea

The domain is modeled as a **directed graph**:

- **States = Nodes**
- **Proofs = Edges**
- **Certificates = Capabilities that unlock edges**

You do not “check” if a transition is valid.  
If the code compiles, the transition is valid.

---

## 🧱 Architecture Summary

| Concept | Meaning |
|------|-------|
| **State (Node)** | Immutable, fully valid domain snapshot |
| **Proof (Edge)** | Witness that a legal transition occurred |
| **Certificate** | Capability required to move to another state |
| **Manager** | Trusted issuer of Certificates |

---

## 🚦 Transition Rules

### State Creation
- State constructors are **private**
- States can only be created via **Proof-producing transitions**

### Transitions
There are two kinds:

1. **Inter-State Transitions**
   - Move from one state to another
   - Require a **Certificate**
   - Implemented as static factory methods
   - Return a **Proof**

2. **In-State Updates (Self-Loops)**
   - Update data without changing state
   - Implemented as instance methods
   - Still return **Proofs** for auditability

---

## ✅ Why This Matters

- **Compile-time correctness** → logic errors become build errors
- **Zero null checks** → the Proof implies completion
- **Safe persistence** → only Proofs may be saved
- **Race-condition resistant** → Proofs are immutable snapshots
- **Onboarding-friendly** → the graph explains the flow

This acts as a **Logic Firewall** between:
- UI
- Hardware
- Persistence  
and the pure domain model.

---

## 🛠️ Minimal Example

```dart
class FullInitialSelectionState {
  FullInitialSelectionState._({
    required this.selectedLeg,
    required this.connectedDevice,
  });

  final LegChoice selectedLeg;
  final BLEDeviceAddress connectedDevice;

  static FullInitialStateCreatedProof fromComponents(
    LegChoice leg,
    BLEDeviceAddress address,
    InitialStateCertificate cert,
  ) {
    return FullInitialStateCreatedProof(
      FullInitialSelectionState._(
        selectedLeg: leg,
        connectedDevice: address,
      ),
    );
  }
}```

flowchart TD
    %% States (Nodes)
    S0[StartingState]
    S1[LegSelectedState]
    S2[DeviceConnectedState]
    S3[ExerciseActiveState]
    S4[RoundCompletedState]

    %% Certificates (Capabilities)
    C1{{LegSelectionCertificate}}
    C2{{DeviceConnectionCertificate}}
    C3{{ExerciseStartCertificate}}
    C4{{RoundCompletionCertificate}}

    %% Inter-State Transitions (Edges via Certificates)
    S0 -->|Proof: LegSelected| C1 --> S1
    S1 -->|Proof: DeviceConnected| C2 --> S2
    S2 -->|Proof: ExerciseStarted| C3 --> S3
    S3 -->|Proof: RoundCompleted| C4 --> S4

    %% Self-Loops (Instance Methods)
    S3 -->|addRep() Proof| S3
    S3 -->|updateTimer() Proof| S3
    S4 -->|adjustMetadata() Proof| S4

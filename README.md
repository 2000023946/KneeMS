# 🦵 KneeMS App – Figma AI Prompt & Screen Flow

This repository contains the **updated prompt for Figma AI** to design the **KneeMS mobile app**, a knee extension tracking app. The app focuses on **manual tracking of knee extensions** for accurate data collection while providing **light gamification** to motivate users.

---

## 📝 Figma AI Prompt

> Design a **mobile app UI wireframe** for **KneeMS**.
> The app helps patients **track knee extension exercises manually** and **collect accurate data for instructors**.
> Focus on **manual repetition tracking** — do **not show “recording”** or automatic tracking.

### Screens & Key Features

1. **Splash / Welcome Screen**
   - App name: **KneeMS**
   - Tagline: “Track your knee health”
   - Large **Get Started** button

2. **Home / Dashboard**
   - AppBar: “KneeMS”
   - Motivation text: “Do your knee extensions today!”
   - **Start Exercise** button
   - Optional: daily streak / simple progress indicator

3. **Exercise Setup**
   - Question: “Which leg?” → Left / Right (radio buttons or toggle)
   - Instruction: “Connect your KneeMS gadget via Bluetooth” → placeholder button
   - **Start Round** button

4. **Exercise Round / Tracking**
   - GIF or small animation showing proper knee extension
   - **Manual rep counter**: “Reps: 0” (user taps `+1` per extension)
   - Motivational text: “Keep going!”
   - **No automatic recording**
   - Button: **Finish Round**

5. **Confirm / Save Round**
   - Summary:
     - Leg: Left / Right
     - Total repetitions completed
   - Buttons:
     - **Redo** → go back to Exercise Round
     - **Save** → save the round
   - Ensure **high-quality data**

6. **Pain Feedback**
   - Ask: “Rate your knee pain after this round”
   - Input: 1–5 stars
   - Optional comment box

7. **Confirmation / Motivation**
   - Text: “Round saved! Great job!”
   - Optional: update streak / points
   - Button: **Back to Home**

---

## 🎨 Style Guidelines

- Minimal, clean mobile UI
- **One action per screen**
- Subtle gamification: points / streak
- Motivational visuals
- Focus on **manual tracking**, not automatic recording

---

## 🧩 Screen Flow Diagram

```mermaid
flowchart TD
    A[Splash / Welcome] --> B[Home / Dashboard]
    B --> C[Exercise Setup]
    C --> D[Exercise Round / Tracking]
    D --> E[Confirm / Save Round]
    E --> F[Pain Feedback]
    F --> G[Confirmation / Motivation]
    G --> B
    E -->|Redo| D
# Secure Domain State Machine (FSM)

This module implements a **Type-Safe Finite State Machine (FSM)** for a Flutter/Dart domain.  
It uses **Witness / Proof patterns** and **Capabilities-based security** to ensure that **only valid state transitions are representable at compile time**.

The goal is to make *illegal states unrepresentable*, not just unlikely.

---

## 🛡️ Design Overview

This FSM models the domain as a **directed graph**:

- **States are Nodes**
- **Transitions are Edges**
- **Proofs act as witnesses that a transition occurred legally**
- **Certificates act as capabilities required to construct the next state**

This prevents:
- Skipped states
- Partial construction
- Invalid persistence
- “Teleportation” between unrelated states

---

## 🏗️ Core Architecture

The system is built on three core concepts:

| Component | Role | Description |
|--------|------|------------|
| **States (Nodes)** | The *Where* | Immutable, fully valid snapshots of domain data |
| **Proofs (Edges)** | The *How* | Witness objects proving a legal transition occurred |
| **Certificates** | The *Key* | Capabilities issued by managers to authorize transitions |

---

## 🚀 Graph Logic

### 1. States (Nodes)

Each state represents a **100% valid domain configuration**.

- State constructors are **private**
- A state **cannot be instantiated directly**
- All states must be assembled through domain logic

This guarantees that *every state object is valid by construction*.

---

### 2. Transitions (Edges / Proofs)

Transitions are represented as **Proof objects**.

There are two types:

#### Static Transitions
Move from one state to another (e.g. `StartingState → LegSelectionState`).

- Require the source state
- Require a valid Certificate
- Produce a Proof containing the new state

#### Self-Loops
Update data while remaining in the same state.

- Implemented as instance methods
- Still return Proofs to preserve auditability

---

### 3. Certificates (The Gatekeeper)

Certificates prevent invalid transitions.

- Issued only by trusted Managers
- Prove that the caller is currently in the correct state
- Required to unlock the next state constructor

This prevents **“teleportation bugs”** — jumping directly from Node A to Node D without walking the graph.

---

## 🛠️ Implementation Example

```dart
// A State (Node)
class FullInitialSelectionState {
  FullInitialSelectionState._({
    required this.selectedLeg,
    required this.connectedDevice,
  });

  final LegChoice selectedLeg;
  final BLEDeviceAddress connectedDevice;

  // A Transition (Edge)
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
}

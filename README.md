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

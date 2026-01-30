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

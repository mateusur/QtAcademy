# Desktop Application Launcher with Animated Windows

This project demonstrates a desktop-style application launcher built using **Qt Quick/QML**, complete with animated application icons and stateful application windows. The project is structured into two stages: a **Basic** implementation and an **Extended** version with additional interactive and animated features.

---

## 🟢 Part 1: Basic Version

### 🔹 Overview
The basic version emulates a desktop environment where a row of app icons is displayed along one edge of the screen. Clicking an icon launches a window that can be opened, maximized, and closed with smooth animations.

### 📋 Features

#### 💻 Desktop Launcher
- A large desktop window with a custom background (solid color or image).
- A linear arrangement of application icons along a single screen edge (top, bottom, left, or right).
- Each icon:
  - Includes a label with the app name.
  - Enlarge on hover with a smooth, wave-like animation using `Behavior`.
- Elegant hover animation using selected easing curves and durations.

#### 🪟 Application Windows
- Each app icon launches an independent application window.
- Windows include:
  - Reference to their respective icon or name.
  - A header, content area, and footer using `Qt Quick Controls Page`.
- Three defined window states:
  - `closed`
  - `open`
  - `maximized`
- State transitions are animated using `Transitions` and `AnchorChanges`:
  - Animate properties such as size, position, opacity, and scale.
  - Support reversible transitions for seamless animations.

---
<!--
## 🚀 Part 2: Extended Version

### 🧩 Additional Features

#### 🔄 Enhanced Icon Behavior
- Bounce animation when an icon opens a new window.
- Replace `NumberAnimation` elements with more performance-optimized `Animator` elements for smoother rendering.

#### 🗨️ Dialog Integration
- `Qt Quick Controls Dialog` that appears on critical actions (e.g., confirming window closure).
- Dialog shows animated transitions when appearing or disappearing.

#### 🔀 Advanced Window Animations
- Use `ParentAnimation` to morph an icon into its associated window:
  - Smooth transition of position and size from icon to full app window.
- Fullscreen mode:
  - App window header hides.
  - Introduces a `Drawer` from the top edge that slides down on swipe.
  - Drawer contains the same UI elements as the window header.
  - Re-usable component for header/drawer switch logic.

#### 💡 Experimental Animation Effects
- Use `RotationAnimation` for novel open/close window effects.
- Implement an "exploded view":
  - Display all open windows non-overlapping and animated outward like a task switcher or mission control.

#### 🔁 Smart Window Management
- Avoid multiple instances of the same window:
  - If already open, bring the existing instance to focus.
  - Gracefully handle destroyed windows and clean-up logic.

---

## 📦 Requirements
- Qt 6.x with QML/Qt Quick modules
- Basic understanding of `State`, `Transition`, `Behavior`, and `Animation` elements in QML

---

## 🛠️ How to Run
1. Clone the repository.
2. Open the `.pro` or `.qmlproject` file in Qt Creator.
3. Build and run on your desktop environment.

---

<!-- ## 📸 Preview
![Launcher Screenshot](path/to/screenshot.png) --> 

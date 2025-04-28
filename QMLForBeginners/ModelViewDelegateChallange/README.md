# 🎶✨ Qt Quick Graphics Equalizer

This project implements a simple, dynamic **Graphics Equalizer** using **Qt Quick**, featuring LED bars that change color and activate based on randomly generated volume data. Designed for efficiency, the layout supports hundreds of LED elements while maintaining smooth visual updates.

---

## 🧱 Base Version

The base version of the Graphics Equalizer includes:

### 🔵 LED Element

- A small, **LED-style visual unit** designed for efficient rendering.
- Each LED has:
  - A **threshold** at which it turns **on** or **off** based on the input level.
  - The ability to **change color** as the volume level increases.
- LEDs are intentionally simple to allow **mass instancing** without performance issues.

### 🟥 LED Bar

- A container aggregating multiple LED elements.
- Features:
  - Configurable **orientation**: vertical or horizontal.
  - **Customizable number** of LEDs per bar.
  - Automatic arrangement using a **Repeater** and **Layout** system.
  - Each bar represents **one frequency band's level**.
- **Delegate pattern**: One LED is used as a delegate, repeated through a view.

### 🟢 Graphic Equalizer Display

- **Model**:
  - Generates **randomized volume data** at each `Timer` interval.
  - Stores volume levels for each frequency band.
- **View**:
  - Creates **LED Bar delegates** dynamically based on the model.
  - Each LED bar reflects the corresponding frequency band’s level.
- **Layout**:
  - Fills the window area, arranging bars neatly side-by-side or stacked.
- **Normalization**:
  - All volume levels and thresholds are kept between **0 and 1** for simpler binding and control.

---

## Base Version

![Base Version](/readmeAssets/base1.png)
![Base Version](/readmeAssets/base2.png)




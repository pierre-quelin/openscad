# Parametric Coin Cell Battery Storage Box (5 Columns)

A compact, sturdy, and **100% customizable OpenSCAD box** designed to organize and protect your most common coin cell batteries. Thanks to its slotted lid with engraved labels, you can check battery types and remaining stock at a single glance.

---

## ✨ Key Features

* **Instant Visibility:** 5 longitudinal viewing slots on the lid let you check your stock levels without opening the box.
* **Individual Retention:** Each battery sits in its own cylindrical cradle and is held in place from above by the lid's top partitions—batteries stay neatly separated even if the box is shaken or dropped.
* **Easy Identification:** Battery codes are engraved directly on top of the lid (can be toggled on or off).
* **Ergonomic Grip:** Contoured side finger notches make removing the lid effortless.
* **Support-Free Printing:** Designed to print completely flat with zero supports (the lid prints top-face down on the build plate).

---

## 🔋 Compatible Batteries & Default Capacity

The 5 columns group batteries by standard IEC diameter (with built-in printing clearance):

| Column | Nominal Diameter | Default Capacity | Compatible Battery Codes |
| :--- | :--- | :--- | :--- |
| **1** | 24.5 mm | 10 cells | **CR2450** |
| **2** | 20.0 mm | 16 cells | **CR2032**, **CR2025**, **CR2016** |
| **3** | 16.0 mm | 16 cells | **CR1632**, **CR1620** |
| **4 (Front)** | 12.5 mm | 8 cells | **CR1225** *(thin cells)* |
| **4 (Back)** | 11.6 mm | 5 cells | **LR44** (AG13), **LR43** (AG12) *(thick cells)* |
| **5** | 7.9 / 6.8 mm | 14 cells | **LR41** (AG3), **LR626** (AG4 / 377) |

*(Note: The exact capacity of each column automatically adjusts to match the overall length set by the longest column).*

---

## 🛠️ Customization (OpenSCAD Customizer)

Open the `.scad` file in **OpenSCAD** and use the **Customizer** panel (*Window > Customizer*) to tailor the box to your needs without editing any code:

1. **Capacity (`Desired Max Capacity`):** Set your desired battery count per column (`max_batteries_1` to `max_batteries_5`). The overall length of the box scales automatically.
2. **Printer Tolerances (`3D Printer Precision & Tolerances`):**
   * `fit_clearance` (`0.25 mm` default): Adjusts how snugly the lid fits onto the base.
   * `battery_diameter_clearance` (`0.40 mm` default): Radial clearance around the batteries.
3. **Display Modes (`Display Modes`):**
   * `print_test_mode = true`: Generates a **16 mm test slice** (base + lid) so you can quickly test your printer's tolerances in under 20 minutes before committing to a full print.
   * `assembled_preview_mode = true`: Displays a closed cross-section view to inspect internal clearances.
4. **Engraving (`show_labels`):** Toggles the engraved battery labels on the lid.

---

## 🖨️ 3D Printing Recommendations

* **Supports:** None (**0%**).
* **Orientation:** Print both parts side-by-side as generated (base flat on the bottom, lid upside down with the engraved face on the build plate).
* **Layer Height:** `0.20 mm` recommended (for crisp text engraving and accurate lid fit).
* **Infill:** `15%` to `20%` (Gyroid or Grid).
* **Material:** PLA, PETG, or ASA.

---

## 📄 License

This work is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)** License.

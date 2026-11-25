**:gb: English** · [:fr: Français](README.fr.md)

# Parametric Double-Sided Morse Code Keychain (OpenSCAD)

A slim, durable, and **100% customizable single-piece Morse code keychain** designed in OpenSCAD. It combines both a visual decoding tree and a complete encoding reference table on a compact tag (`68 × 43 × 1.8 mm` by default) that prints completely flat without supports.

---

## ✨ Key Features

* **Top Face — Visual Decoder Chart (Raised Relief):** Follow the tree from `START` (branch left for dots `•`, right for dashes `▬`) to decode incoming signals quickly. The raised geometry allows an easy single-layer color swap for high contrast.
* **Bottom Face — Encoding Table & Timing Rules (Engraved):** Features the full alphabet (`A–Z`), numbers (`0–9`), and international spacing rules (`• = 1`, `▬ = 3`, `Letter gap = 3`, `Word gap = 7`) recessed directly into the bottom face.
* **Nozzle-Aware Line Scaling:** Automatically enforces a minimum printable line width (`1.15 × nozzle_diameter`) across all tree branches, dots, and dashes so no details are dropped by your slicer.
* **Slim & Sturdy Profile:** `1.40 mm` base plate with `0.40 mm` bottom engraving (leaving a solid `1.00 mm` core) and `0.40 mm` top relief, plus a reinforced keyring eyelet.
* **Support-Free Printing:** Prints flat on the build plate in one piece with zero supports.

---

## 🛠️ Customization (OpenSCAD Customizer)

Open the `.scad` file in **OpenSCAD** and use the **Customizer** panel (*Window > Customizer*) to adjust the keychain to your preferences:

* **Card Dimensions:** `card_width` (`68.0 mm` default), `card_height` (`43.0 mm` default), and `corner_radius` (`4.0 mm`).
* **Thickness & Relief:** `base_thick` (`1.40 mm`), `top_relief_h` (`0.40 mm`), and `bottom_engrave_d` (`0.40 mm`).
* **Printer Nozzle (`nozzle_diameter`):** Set to `0.40 mm` by default (can be lowered to `0.20 mm` if you scale the tag down below `55 mm` wide).
* **Keyring Hole:** Toggle `add_keyring_hole` (`true`/`false`) or adjust `hole_diameter` (`4.2 mm`) and `hole_margin` (`4.5 mm`).

---

## 🖨️ 3D Printing Recommendations (0.4 mm Nozzle)

* **Supports:** None (**0%**).
* **Orientation:** Flat on the build plate (`MORSE CODE` face down, `DECODER CHART` face up).
* **Layer Height:** `0.20 mm` (yields 2 engraved bottom layers, 5 solid core layers, and 2 raised top layers).
* **Slicer Fine-Detail Settings:**
  * **UltiMaker Cura 5+:** Uses the **Arachne** variable-width engine automatically by default (no setting to toggle). Simply enable **Print Thin Walls** (*Walls* section) and set **Minimum Wall Line Width** to `0.30 mm` if needed for tiny letter tips.
  * **PrusaSlicer / OrcaSlicer / Bambu Studio:** Ensure **Wall / Perimeter Generator** is set to **Arachne** (default).
* **Two-Color Filament Swap (`M600` / Pause):** Add a filament change at **`Z = 1.60 mm`** (the first raised layer of the decoder chart) to make the top graphics pop in a contrasting color.
* **Elephant Foot / Initial Layer Expansion:** Set **Initial Layer Horizontal Expansion** to `-0.10 mm` (Cura) or **Elephant Foot Compensation** to `0.10 – 0.15 mm` (PrusaSlicer / OrcaSlicer) so the bottom engraved characters remain sharp and un-squished.

---

## 📄 License

This work is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)** License.

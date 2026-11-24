# Fiche Technique / Technical Datasheet : Bague & Manchon Twist-Off (Cotes Mesurées)

* **Référence normative / Reference Standard :** CETIE GME 20.03 / ISO 9100-5 (*Vacuum lug finish — Bague à crans sous vide*)
* **Configuration identifiée / Identified Format :** Bague verre à filetage profond (type passata / sauce tomate) — **TO 48 tolérance basse** (*Low-tolerance TO 48 / ~45.5 mm lug finish*)
* **Application CAO / CAD Application :** Manchon fileté ouvert imprimé en 3D (*Open-ended 3D-printed threaded sleeve*)

---

## 1. Schéma des cotes mesurées / Measured Dimensional Drawing

```text

          |<------ Ø T (45.5–46.0 mm) ----->|
          |   |<--- Ø E (~43.0 mm) ---->|   |
          |   |   |<-- Ø I (37.5) -->|  |   |
          |   |   |                  |  |   |
      --- +---+---+                  +--+---+ ---
       ^      |   |                  |  |      ^

       |     /    |                  |   \     |  Filet verre / Glass lug (4x @ 90°)
    H  |    |     |                  |    |    |  Pente / Pitch: ~3.5°
  (~9.2|     \    |                  |   /     |
   mm) |      |   |                  |  |      |
       v  +---+   |                  |  +---+  v
      --- |       |                  |      | ---

          |       |                  |      |     Bourrelet / Transfer bead
          +-------+                  +------+

          |<------- Ø S (~48.0 mm) -------->|
```

---

## 2. Tableau des cotes de référence / Reference Dimensions

| Repère / Symbol | Terme Français | English Term | Valeur Mesurée / Measured | Note Technique / Technical Note |
| :--- | :--- | :--- | :--- | :--- |
| **I** | Diamètre intérieur d'ouverture | Bore / Inside opening diameter | **37,5 mm** | Passage libre du goulot / *Clear neck opening* |
| **E** | Diamètre extérieur fond de filet | Wall / Neck root diameter | **~43,0 mm** | Cylindre lisse entre les filets / *Smooth neck wall* |
| **T** | Diamètre extérieur sur filets | Thread / Lug major diameter | **45,5 – 46,0 mm** | Largeur hors-tout sur crans / *Overall lug width* |
| **H** | Hauteur de bague | Finish height | **~9,0 – 9,5 mm** | Hauteur utile du filetage / *Usable thread height* |
| **Ø Cap** | Diamètre intérieur capsule métal | Metal cap inner skirt diameter | **46,2 mm** | Mesuré hors ergots / *Measured without lugs* |

---

## 3. Géométrie des crans / Lug Geometry

| Paramètre / Parameter | Spécification / Specification |
| :--- | :--- |
| **Nombre de crans / Number of lugs** | 4 crans espacés à 90° (*4 lugs spaced at 90°*) |
| **Saillie du filet / Lug protrusion `(T - E) / 2`** | ~1,3 – 1,5 mm par côté (*per side*) |
| **Angle d'inclinaison / Helix pitch angle** | ~3,5° (serrage par quart de tour / *quarter-turn lock*) |
| **Longueur d'arc du cran / Lug arc length** | ~55° – 60° |
| **Espace libre entre crans / Lug clearance gap** | ~30° – 35° |

---

## 4. Paramètres finaux OpenSCAD / Final OpenSCAD Parameters

| Paramètre / Parameter | Terme Français | English Term | Valeur / Value | Justification / Rationale |
| :--- | :--- | :--- | :--- | :--- |
| **`DIA_INNER`** | Diamètre intérieur tube | Inner sleeve diameter | **46.4 mm** | 46,2 mm mesurés + 0,2 mm de retrait FDM (*shrinkage offset*) |
| **`total_height`** | Hauteur totale du manchon | Total sleeve height | **22.0 mm** | Hauteur d'origine doublée (2 × 11 mm) / *Doubled height* |
| **`THICKNESS`** | Épaisseur de paroi | Wall thickness | **2.0 mm** | Diamètre extérieur total : 50,4 mm (*Outer Ø: 50.4 mm*) |
| **`TAB_COUNT`** | Nombre d'ergots | Number of cap lugs | **4** | Espacés à 90° (*Spaced at 90°*) |
| **`TAB_DEPTH`** | Profondeur d'ergot | Inward lug protrusion | **1.5 mm** | Diamètre de passage libre : 43,4 mm (*Clear pass: 43.4 mm*) |
| **`TAB_THICKNESS`** | Épaisseur verticale ergot | Lug vertical thickness | **1.8 mm** | Positionnés à l'extrémité `Z = 0` (*Placed at bottom edge*) |

---

## 5. Lexique technique / Technical Glossary

* **Bague (verre) / Glass finish :** Partie supérieure filetée du col du bocal recevant le bouchon.
* **Buvant / Sealing surface (Rim) :** Face supérieure plate du col sur laquelle repose le joint d'étanchéité.
* **Bourrelet de transfert / Transfer bead (Z-ring) :** Anneau en relief sous le filetage servant à la manutention industrielle.
* **Cran (sur le verre) / Glass lug (Thread) :** Protubérance hélicoïdale moulée sur le col du bocal.
* **Ergot (sur la capsule) / Cap lug (Tab) :** Repli intérieur du bouchon venant se verrouiller sous le cran du verre.
* **Jupe / Cap skirt :** Paroi cylindrique verticale du bouchon ou du manchon.
* **Retrait d'impression / FDM shrinkage compensation :** Majoration de +0,2 mm appliquée aux alésages intérieurs pour compenser l'écrasement du filament fondu.


[:gb: English](README.md) · **:fr: Français**

# Porte-clés code Morse double-face paramétrique (OpenSCAD)

Un porte-clés code Morse **fin, robuste et 100 % personnalisable sous OpenSCAD**, conçu en une seule pièce. Il réunit sur un format compact (`68 × 43 × 1,8 mm` par défaut) un arbre visuel de décodage sur le dessus et la table complète d'encodage gravée dessous, le tout imprimable à plat sans aucun support.

---

## ✨ Points forts du modèle

* **Face supérieure — Arbre de décodage (`DECODER CHART` en relief) :** Suivez simplement les branches depuis `START` (à gauche pour un point `•`, à droite pour un tiret `▬`) pour décoder un message instantanément. Le relief permet un changement de filament facile en fin d'impression pour un contraste maximal.
* **Face inférieure — Table d'encodage et règles d'espacement (`MORSE CODE` en creux) :** Comprend l'alphabet complet (`A–Z`), les chiffres (`0–9`) ainsi que les règles internationales de rythme et d'espacement (`• = 1`, `▬ = 3`, `Letter gap = 3`, `Word gap = 7`) gravés directement sous la carte.
* **Épaisseur adaptée à la buse :** Le script impose automatiquement une largeur minimale imprimable (`1,15 × nozzle_diameter`) sur toutes les liaisons, points et tirets afin qu'aucun détail ne soit ignoré par votre trancheur.
* **Profil fin et rigide :** Base de `1,40 mm` avec gravure inférieure de `0,40 mm` (laissant une âme pleine de `1,00 mm`) et relief supérieur de `0,40 mm`, complété par un œillet renforcé pour anneau.
* **Impression sans supports :** S'imprime d'un seul tenant à plat sur le plateau sans aucun support.

---

## 🛠️ Personnalisation (OpenSCAD Customizer)

Ouvrez le fichier `.scad` dans **OpenSCAD** et utilisez le panneau **Customizer** (*Fenêtre > Customizer*) pour adapter le porte-clés à vos besoins :

* **Dimensions de la carte :** `card_width` (`68.0 mm` par défaut), `card_height` (`43.0 mm` par défaut) et `corner_radius` (`4.0 mm`).
* **Épaisseur et relief :** `base_thick` (`1.40 mm`), `top_relief_h` (`0.40 mm`) et `bottom_engrave_d` (`0.40 mm`).
* **Diamètre de buse (`nozzle_diameter`) :** Réglé sur `0.40 mm` par défaut (peut être abaissé à `0.20 mm` si vous réduisez la largeur de la carte sous `55 mm`).
* **Œillet porte-clés :** Activez ou désactivez `add_keyring_hole` (`true`/`false`), ou ajustez `hole_diameter` (`4.2 mm`) et `hole_margin` (`4.5 mm`).

---

## 🖨️ Conseils d'impression 3D (buse de 0,4 mm)

* **Supports :** Aucun (**0 %**).
* **Orientation :** À plat sur le plateau (face `MORSE CODE` contre le plateau, face `DECODER CHART` vers le haut).
* **Hauteur de couche :** `0,20 mm` (donne exactement 2 couches gravées en bas, 5 couches pleines au centre et 2 couches en relief sur le dessus).
* **Réglages des détails fins selon le trancheur :**
  * **UltiMaker Cura 5+ :** Intègre nativement le moteur **Arachne** en permanence (aucune case à cocher). Activez simplement **Imprimer les parois fines** (*Print Thin Walls*, section *Parois*) et réglez la **Largeur minimale des parois** (*Minimum Wall Line Width*) à `0,30 mm` si besoin pour les pointes fines des lettres.
  * **PrusaSlicer / OrcaSlicer / Bambu Studio :** Vérifiez que le **Générateur de périmètres / parois** est bien sur **Arachne** (valeur par défaut).
* **Changement de filament bicolore (`M600` / Pause) :** Programmez un changement de couleur à **`Z = 1,60 mm`** (première couche en relief de l'arbre de décodage) pour faire ressortir les symboles sur le dessus.
* **Compensation d'effet pied d'éléphant :** Réglez l'**Expansion horizontale de la couche initiale** sur `-0,10 mm` (Cura) ou la **Compensation d'effet pied d'éléphant** sur `0,10 – 0,15 mm` (PrusaSlicer / OrcaSlicer) pour éviter que la première couche ne vienne boucher les caractères gravés dessous.

---

## 📄 Licence

Ce modèle est distribué sous licence **Creative Commons Attribution - Pas d'Utilisation Commerciale - Partage dans les Mêmes Conditions 3.0 Unported (CC BY-NC-SA 3.0)**.

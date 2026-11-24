/**
 * Adaptation de « Parametric twist-off cap for bottles, jars etc. »
 * par Philipp Reichmuth (2020).
 * Source : https://www.printables.com/model/28894-customizable-parametric-twist-off-cap-or-lid-for-b
 * Original sous CC BY-SA 4.0 :
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * Modifications apportées :
 * Adaptation du modèle pour permettre de fixer un entonnoir sur le pot,
 * afin qu’il reste en place sans être tenu à la main.
 * Adaptation et modifications : Pierre Quélin, 2026-11-24
 * Partagée sous CC BY-SA 4.0 :
 * https://creativecommons.org/licenses/by-sa/4.0/
 */

/* [Cotes Nominales Mesurées / Nominal Measurements] */
// Diamètre intérieur mesuré du bouchon métal (sans les ergots)
NOMINAL_CAP_DIA_INNER = 46.2; // [30:0.1:120]
// Diamètre extérieur du col en verre entre les filets (cote E)
NOMINAL_GLASS_NECK_E  = 43.0; // [25:0.1:115]
// Hauteur de base jusqu'au haut des ergots
BASE_HEIGHT_INNER     = 9.0;  // [3:0.5:30]
// Marge de base d'origine (total d'origine = 11 mm)
BASE_TOP_OFFSET       = 2.0;  // [0:0.5:10]
// Multiplicateur de hauteur (2 = hauteur doublée à 22 mm)
HEIGHT_MULTIPLIER     = 2;    // [1:0.5:5]
// Épaisseur nominale de la paroi du tube
WALL_THICKNESS        = 2.0;  // [1:0.2:5]

/* [Tolérances & Précision Impression 3D / 3D Printing Tolerances] */
// Compensation de retrait / écrasement de buse sur les diamètres intérieurs (+0.2 à +0.4 mm)
PRINTER_XY_TOLERANCE  = 0.2;  // [0:0.05:1.0]
// Jeu fonctionnel supplémentaire pour faciliter le glissement et le vissage
FIT_CLEARANCE         = 0.2;  // [0:0.05:1.0]
// Résolution des courbes ($fn : 100 = standard, 180 = haute précision)
CURVE_RESOLUTION      = 120;  // [60:10:240]

/* [Géométrie des Ergots / Lugs] */
TAB_COUNT             = 4;    // [4, 6]
// Saillie radiale nominale d'un ergot (calculée pour mordre sous le filet sans toucher le col)
TAB_RADIAL_DEPTH      = 1.5;  // [0.5:0.1:3.0]
// Épaisseur verticale de chaque ergot
TAB_THICKNESS         = 1.8;  // [1.0:0.1:4.0]
// Chanfrein d'attaque sur le dessus des ergots (facilite l'engagement sur le verre)
TAB_CHAMFER           = 0.4;  // [0:0.1:1.0]

/* [Stries de Préhension / Grip Ridges] */
RIDGE_DEPTH           = 0.5;  // [0:0.1:2.0]
RIDGE_SPACING         = 2.0;  // [1.0:0.5:10.0]
RIDGE_OFFSET          = 1.0;  // [0:0.5:5.0]

/* [Hidden] */
// --- CALCULS DES COTES EFFECTIVES AVEC JEUX D'IMPRESSION ---
// Diamètre intérieur réel modélisé (46.2 + 0.2 + 0.2 = 46.6 mm)
effective_dia_inner = NOMINAL_CAP_DIA_INNER + PRINTER_XY_TOLERANCE + FIT_CLEARANCE;

// Profondeur d'ergot ajustée pour conserver le jeu radial face au col en verre
effective_tab_depth = max(0.1, TAB_RADIAL_DEPTH - (FIT_CLEARANCE / 2));

// Diamètre de passage libre résultant entre deux ergots opposés
clear_lug_passage   = effective_dia_inner - (2 * effective_tab_depth);

// Hauteurs
base_height         = BASE_HEIGHT_INNER + BASE_TOP_OFFSET;
total_height        = base_height * HEIGHT_MULTIPLIER;

// Paramètres angulaires
tab_angle           = 360 / TAB_COUNT;
outer_dia           = effective_dia_inner + (2 * WALL_THICKNESS);
ridge_count         = ceil(PI * outer_dia / RIDGE_SPACING);
ridge_angle         = 360 / ridge_count;
ridge_height        = total_height - (2 * RIDGE_OFFSET);

// --- CONTRÔLE DANS LA CONSOLE OPENSCAD ---
echo(str("=== BILAN DIMENSIONNEL (IMPRESSION 3D) ==="));
echo(str("Diamètre intérieur modélisé (effet retrait inclus) : ", effective_dia_inner, " mm"));
echo(str("Diamètre passage libre entre ergots : ", clear_lug_passage, " mm (Col verre E = ", NOMINAL_GLASS_NECK_E, " mm)"));
echo(str("Hauteur totale du manchon : ", total_height, " mm"));

// --- GÉNÉRATION DE LA GÉOMÉTRIE ---
union() {
    // 1. Corps du tube ouvert (sans fond/dessus)
    difference() {
        cylinder(d = outer_dia, h = total_height, $fn = CURVE_RESOLUTION);
        translate([0, 0, -0.1])
            cylinder(d = effective_dia_inner, h = total_height + 0.2, $fn = CURVE_RESOLUTION);
    }

    // 2. Ergots internes positionnés à l'extrémité inférieure (Z = 0)
    intersection() {
        // Bague de confinement soudée à l'intérieur de la paroi (chevauchement de 0.4 mm pour un maillage STL sain)
        difference() {
            cylinder(d = effective_dia_inner + 0.8, h = TAB_THICKNESS, $fn = CURVE_RESOLUTION);
            translate([0, 0, -0.1])
                cylinder(d = clear_lug_passage, h = TAB_THICKNESS + 0.2, $fn = CURVE_RESOLUTION);
        }

        // Découpe des N ergots avec profil chanfreiné supérieur
        for (i = [0 : TAB_COUNT - 1]) {
            rotate([0, 0, i * tab_angle])
                translate([effective_dia_inner - effective_tab_depth, 0, 0])
                    union() {
                        // Base droite de l'ergot
                        cylinder(
                            d = effective_dia_inner,
                            h = max(0.1, TAB_THICKNESS - TAB_CHAMFER),
                            $fn = CURVE_RESOLUTION
                        );
                        // Chanfrein supérieur pour guider l'entrée sur le filet verre
                        if (TAB_CHAMFER > 0) {
                            translate([0, 0, TAB_THICKNESS - TAB_CHAMFER])
                                cylinder(
                                    d1 = effective_dia_inner,
                                    d2 = effective_dia_inner + (2 * TAB_CHAMFER),
                                    h = TAB_CHAMFER,
                                    $fn = CURVE_RESOLUTION
                                );
                        }
                    }
        }
    }

    // 3. Stries extérieures de préhension
    if (RIDGE_DEPTH > 0) {
        for (i = [0 : ridge_count - 1]) {
            rotate([0, 0, i * ridge_angle])
                translate([outer_dia / 2, 0, RIDGE_OFFSET])
                    rotate([0, 0, 45])
                        cube([RIDGE_DEPTH, RIDGE_DEPTH, ridge_height]);
        }
    }
}

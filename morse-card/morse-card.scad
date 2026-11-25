/**
 * Single-Piece Double-Sided Morse Code Keychain (Slim & CR-10S 0.4mm Nozzle Optimized)
 * - Top face: DECODER CHART (raised relief)
 * - Bottom face: MORSE CODE table + timing rules (engraved / debossed)
 *
 * Copyright (c) 2026 Pierre Quélin
 * Contact: pierre.quelin.1972@gmail.com
 *
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0) License.
 * See: https://creativecommons.org
 */

$fn = 60;

/* [Keychain Dimensions (mm)] */
card_width       = 68.0; // [55:1:90] Original card: 85.5 mm
card_height      = 43.0; // [35:1:60] Original card: 54.0 mm
base_thick       = 1.40; // Slim base thickness (leaves 1.00mm solid core above 0.40mm engraving)
top_relief_h     = 0.40; // Top raised height (2 layers at 0.20mm)
bottom_engrave_d = 0.40; // Bottom engraved depth (2 layers at 0.20mm)
corner_radius    = 4.0;

/* [3D Printer Nozzle Settings (CR-10S)] */
nozzle_diameter  = 0.40; // [0.20:0.05:0.60] Ensures minimum printable line width

/* [Keyring Hole] */
add_keyring_hole = true;
hole_diameter    = 4.2;
hole_margin      = 4.5; // Center distance from top-left edges

// Scale factor relative to 85.5 x 54 mm reference card
sx = card_width / 85.5;
sy = card_height / 54.0;
s  = min(sx, sy);

// Guaranteed minimum printable line width for CR-10S nozzle
min_line_w = nozzle_diameter * 1.15;

// Morse tables separated into characters and codes
chars_col1 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M"];
codes_col1 = [".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--"];

chars_col2 = ["N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
codes_col2 = ["-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."];

chars_col3 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
codes_col3 = ["-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----."];

// 2D Rounded rectangle helper
module rounded_rect_2d(w, h, r) {
    offset(r = r)
        square(concat(w - 2 * r, h - 2 * r), center = true);
}

// Keyring hole cutout (top-left corner)
module keyring_cutout(z_h) {
    if (add_keyring_hole) {
        translate(concat(-card_width / 2 + hole_margin, card_height / 2 - hole_margin, -1))
            cylinder(d = hole_diameter, h = z_h + 2);
    }
}

// 2D Morse code sequence renderer (dots & dashes)
module morse_symbols_2d(code, dot_d, dash_w, dash_h, gap) {
    n = len(code);
    for (i = [0 : n - 1]) {
        x_off = (i == 0) ? 0 : sum_widths(code, i - 1, dot_d, dash_w, gap);
        ch = code[ i ];
        if (ch == ".") {
            translate(concat(x_off + dot_d / 2, 0))
                circle(d = dot_d);
        } else if (ch == "-") {
            translate(concat(x_off + dash_w / 2, 0))
                square(concat(dash_w, dash_h), center = true);
        }
    }
}

function sum_widths(code, idx, dot_d, dash_w, gap) =
    (idx < 0) ? 0 :
    ((code[ idx ] == "." ? dot_d : dash_w) + gap + sum_widths(code, idx - 1, dot_d, dash_w, gap));

// ============================================================================
// BOTTOM FACE (ENGRAVED): MORSE CODE REFERENCE TABLE & TIMING RULES (2D)
// ============================================================================
module face_morse_2d() {
    title_y = card_height / 2 - 7.5 * sy;
    start_y = card_height / 2 - 14.5 * sy;
    row_dy  = 2.85 * sy;

    dot_d   = max(nozzle_diameter * 2.4, 1.20 * s);
    dash_w  = max(nozzle_diameter * 5.5, 2.85 * s);
    dash_h  = max(nozzle_diameter * 2.1, 1.05 * s);
    sym_gap = max(nozzle_diameter * 1.8, 0.95 * s);
    txt_sz  = 2.15 * s;

    // Header
    translate(concat(add_keyring_hole ? 3.2 * sx : 0, title_y))
        text("MORSE CODE", size = 4.5 * s, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // Shifted left for equal left & right outer margins
    col_x1 = -card_width / 2 + 5.8 * sx;
    col_x2 = -5.8 * sx;
    col_x3 = card_width / 2 - 24.5 * sx;

    // Column 1 (A-M)
    for (r = [0 : len(chars_col1) - 1]) {
        y = start_y - r * row_dy;
        translate(concat(col_x1, y))
            text(chars_col1[ r ], size = txt_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        translate(concat(col_x1 + 2.5 * sx, y))
            morse_symbols_2d(codes_col1[ r ], dot_d, dash_w, dash_h, sym_gap);
    }

    // Column 2 (N-Z)
    for (r = [0 : len(chars_col2) - 1]) {
        y = start_y - r * row_dy;
        translate(concat(col_x2, y))
            text(chars_col2[ r ], size = txt_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        translate(concat(col_x2 + 2.5 * sx, y))
            morse_symbols_2d(codes_col2[ r ], dot_d, dash_w, dash_h, sym_gap);
    }

    // Column 3 (0-9)
    for (r = [0 : len(chars_col3) - 1]) {
        y = start_y - r * row_dy;
        translate(concat(col_x3, y))
            text(chars_col3[ r ], size = txt_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
        translate(concat(col_x3 + 2.5 * sx, y))
            morse_symbols_2d(codes_col3[ r ], dot_d, dash_w, dash_h, sym_gap);
    }

    // Timing & spacing rules below '9' (aligned with rows 10, 11, 12)
    rule_sz = 1.90 * s;
    rule_x  = col_x3 - 1.0 * sx;

    // Row 10: Dot = 1  Dash = 3 (using actual geometric dot & dash)
    y_r1 = start_y - 10 * row_dy;
    translate(concat(rule_x + dot_d / 2, y_r1)) circle(d = dot_d);
    translate(concat(rule_x + dot_d + 1.2 * sx, y_r1))
        text("= 1", size = rule_sz, font = "Liberation Sans:style=Bold", halign = "left", valign = "center");
    translate(concat(rule_x + 9.2 * sx + dash_w / 2, y_r1))
        square(concat(dash_w, dash_h), center = true);
    translate(concat(rule_x + 9.2 * sx + dash_w + 1.2 * sx, y_r1))
        text("= 3", size = rule_sz, font = "Liberation Sans:style=Bold", halign = "left", valign = "center");

    // Row 11: Letter gap = 3
    y_r2 = start_y - 11 * row_dy;
    translate(concat(rule_x, y_r2))
        text("Letter gap = 3", size = rule_sz, font = "Liberation Sans:style=Bold", halign = "left", valign = "center");

    // Row 12: Word gap = 7
    y_r3 = start_y - 12 * row_dy;
    translate(concat(rule_x, y_r3))
        text("Word gap = 7", size = rule_sz, font = "Liberation Sans:style=Bold", halign = "left", valign = "center");
}
// ============================================================================
// TOP FACE (RAISED): DECODER CHART VISUAL TREE (2D) - CR-10S & HOLE CLEAR
// ============================================================================
module face_decoder_2d() {
    title_y = card_height / 2 - 6.4 * sy;
    top_y   = card_height / 2 - 14.8 * sy; // Lowered to keep H clear of keyring boss
    bot_y   = -card_height / 2 + 4.4 * sy;
    span_y  = top_y - bot_y;

    // Minimum printable dimensions for 0.4mm nozzle
    line_w  = max(min_line_w, 0.65 * s);
    dot_d   = max(nozzle_diameter * 3.8, 1.75 * s);
    dash_l  = max(nozzle_diameter * 7.0, 3.25 * s);
    dash_w  = max(nozzle_diameter * 3.4, 1.55 * s);
    l_sz    = 2.35 * s;

    // Header (shifted right to clear top-left keyring hole)
    translate(concat(add_keyring_hole ? 3.2 * sx : 0, title_y))
        text("DECODER CHART", size = 4.25 * s, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // [START] Box (positioned so left branch H clears keyring boss cleanly)
    start_x = 0.5 * sx;
    box_w   = 12.0 * sx;
    box_h   = 4.0 * sy;
    box_rim = max(min_line_w, 0.60 * s);
    translate(concat(start_x, top_y)) {
        difference() {
            square(concat(box_w, box_h), center = true);
            square(concat(box_w - 2 * box_rim, box_h - 2 * box_rim), center = true);
        }
        text("START", size = 2.05 * s, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    }

    // Left vertical row spacing (3 equal steps from top_y to bot_y)
    dy_l = span_y / 3;
    y2   = top_y - dy_l;
    y3   = top_y - 2 * dy_l;
    y4   = bot_y;

    // ========================================================================
    // LEFT SIDE (DOTS BRANCH: E -> I -> S -> H)
    // ========================================================================
    x_e = start_x - 10.5 * sx;
    x_i = x_e - 7.4 * sx;
    x_s = x_i - 7.4 * sx;
    x_h = x_s - 7.4 * sx;

    // Main horizontal line from START to H
    translate(concat((start_x - box_w / 2 + x_h) / 2, top_y))
        square(concat((start_x - box_w / 2) - x_h, line_w), center = true);

    left_x   = concat(x_e, x_i, x_s, x_h);
    left_lbl = ["E", "I", "S", "H"];
    for (i = [0 : 3]) {
        translate(concat(left_x[ i ], top_y)) circle(d = dot_d);
        translate(concat(left_x[ i ], top_y + 2.6 * sy))
            text(left_lbl[ i ], size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    }

    // S -> V (...-)
    translate(concat(x_s, (top_y + y2) / 2)) square(concat(line_w, dy_l), center = true);
    translate(concat(x_s, y2)) square(concat(dash_w, dash_l), center = true);
    translate(concat(x_s - 2.4 * sx, y2))
        text("V", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // I -> U (..-) -> F (..-.)
    translate(concat(x_i, (top_y + y3) / 2)) square(concat(line_w, 2 * dy_l), center = true);
    translate(concat(x_i, y2)) square(concat(dash_w, dash_l), center = true);
    translate(concat(x_i - 2.4 * sx, y2))
        text("U", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    translate(concat(x_i, y3)) circle(d = dot_d);
    translate(concat(x_i - 2.4 * sx, y3))
        text("F", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // E -> A (.-) -> W (.--) -> J (.---)
    translate(concat(x_e, (top_y + y4) / 2)) square(concat(line_w, span_y), center = true);

    // Node A + side branch R (.-.) -> L (.-..)
    translate(concat(x_e, y2)) square(concat(dash_w, dash_l), center = true);
    translate(concat(x_e - 2.4 * sx, y2))
        text("A", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    x_r = x_e + 4.6 * sx;
    x_l = x_r + 4.6 * sx;
    translate(concat((x_e + x_l) / 2, y2)) square(concat(x_l - x_e, line_w), center = true);
    translate(concat(x_r, y2)) circle(d = dot_d);
    translate(concat(x_r, y2 + 2.5 * sy))
        text("R", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    translate(concat(x_l, y2)) circle(d = dot_d);
    translate(concat(x_l, y2 + 2.5 * sy))
        text("L", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // Node W + side branch P (.--.)
    translate(concat(x_e, y3)) square(concat(dash_w, dash_l), center = true);
    translate(concat(x_e - 2.4 * sx, y3))
        text("W", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    x_p = x_e + 4.6 * sx;
    translate(concat((x_e + x_p) / 2, y3)) square(concat(x_p - x_e, line_w), center = true);
    translate(concat(x_p, y3)) circle(d = dot_d);
    translate(concat(x_p, y3 + 2.5 * sy))
        text("P", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // Node J
    translate(concat(x_e, y4)) square(concat(dash_w, dash_l), center = true);
    translate(concat(x_e - 2.4 * sx, y4))
        text("J", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // ========================================================================
    // RIGHT SIDE (DASHES BRANCH: T -> M -> O)
    // ========================================================================
    x_t = start_x + 10.8 * sx;
    x_m = x_t + 9.8 * sx;
    x_o = x_m + 10.5 * sx;

    // Main horizontal line from START to O
    translate(concat((start_x + box_w / 2 + x_o) / 2, top_y))
        square(concat(x_o - (start_x + box_w / 2), line_w), center = true);

    right_x   = concat(x_t, x_m, x_o);
    right_lbl = ["T", "M", "O"];
    for (i = [0 : 2]) {
        translate(concat(right_x[ i ], top_y)) square(concat(dash_l, dash_w), center = true);
        translate(concat(right_x[ i ], top_y + 2.6 * sy))
            text(right_lbl[ i ], size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    }

    // M -> G (--.) with left Z (--..) and right Q (--.-)
    y_g = top_y - span_y * 0.28;
    translate(concat(x_m, (top_y + y_g) / 2)) square(concat(line_w, top_y - y_g), center = true);
    translate(concat(x_m, y_g)) circle(d = dot_d);
    translate(concat(x_m, y_g - 2.5 * sy))
        text("G", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    x_z = x_m - 4.6 * sx;
    x_q = x_m + 5.4 * sx;
    translate(concat((x_z + x_q) / 2, y_g)) square(concat(x_q - x_z, line_w), center = true);
    translate(concat(x_z, y_g)) circle(d = dot_d);
    translate(concat(x_z, y_g + 2.4 * sy))
        text("Z", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    translate(concat(x_q, y_g)) square(concat(dash_l, dash_w), center = true);
    translate(concat(x_q, y_g + 2.4 * sy))
        text("Q", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // T -> N (-.) -> D (-..) -> B (-...)
    y_n = top_y - span_y * 0.58;
    y_d = top_y - span_y * 0.80;
    y_b = bot_y;

    translate(concat(x_t, (top_y + y_b) / 2)) square(concat(line_w, top_y - y_b), center = true);

    // Node N + right branch K (-.-) -> Y (-.--), down C (-.-.)
    translate(concat(x_t, y_n)) circle(d = dot_d);
    translate(concat(x_t - 2.4 * sx, y_n))
        text("N", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    x_k = x_m + 1.8 * sx;
    x_y = x_o + 1.2 * sx;
    translate(concat((x_t + x_y) / 2, y_n)) square(concat(x_y - x_t, line_w), center = true);
    translate(concat(x_k, y_n)) square(concat(dash_l, dash_w), center = true);
    translate(concat(x_k, y_n + 2.5 * sy))
        text("K", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
    translate(concat(x_y, y_n)) square(concat(dash_l, dash_w), center = true);
    translate(concat(x_y, y_n + 2.5 * sy))
        text("Y", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // K down to C
    translate(concat(x_k, (y_n + y_b) / 2)) square(concat(line_w, y_n - y_b), center = true);
    translate(concat(x_k, y_b)) circle(d = dot_d);
    translate(concat(x_k - 2.4 * sx, y_b))
        text("C", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // Node D + left branch X (-..-)
    translate(concat(x_t, y_d)) circle(d = dot_d);
    translate(concat(x_t + 2.4 * sx, y_d))
        text("D", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    x_x = x_t - 9.5 * sx;
    translate(concat((x_x + x_t) / 2, y_d)) square(concat(x_t - x_x, line_w), center = true);
    translate(concat(x_x, y_d)) square(concat(dash_l, dash_w), center = true);
    translate(concat(x_x, y_d + 2.5 * sy))
        text("X", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");

    // Node B (bottom)
    translate(concat(x_t, y_b)) circle(d = dot_d);
    translate(concat(x_t - 2.4 * sx, y_b))
        text("B", size = l_sz, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
}
// ============================================================================
// 3D SINGLE-CARD ASSEMBLY
// - Top (Z = base_thick): DECODER CHART (raised)
// - Bottom (Z = 0): MORSE CODE (engraved / recessed)
// ============================================================================
difference() {
    union() {
        // 1. Main card body resting flat on Z=0
        color("DimGray")
            linear_extrude(height = base_thick)
                rounded_rect_2d(card_width, card_height, corner_radius);

        // 2. Keyring hole reinforcement boss
        if (add_keyring_hole) {
            color("DimGray")
                translate(concat(-card_width / 2 + hole_margin, card_height / 2 - hole_margin, 0))
                    cylinder(d = hole_diameter + 3.2, h = base_thick + top_relief_h);
        }

        // 3. TOP FACE: DECODER CHART (raised relief)
        color("White")
            translate(concat(0, 0, base_thick))
                linear_extrude(height = top_relief_h)
                    face_decoder_2d();
    }

    // 4. BOTTOM FACE: MORSE CODE (engraved into Z=0, mirrored on X so it reads correctly when flipped)
    color("White")
        translate(concat(0, 0, -0.05))
            linear_extrude(height = bottom_engrave_d + 0.05)
                mirror(concat(1, 0, 0))
                    face_morse_2d();

    // 5. Keyring hole through-cut
    keyring_cutout(base_thick + top_relief_h);
}

/**
 * Universal Coin Cell Battery Box (5 COLUMNS: 24.5 to 7.9 mm)
 *
 * Copyright (c) [2026] [Pierre Quélin]
 * Contact: [pierre.quelin.1972@gmail.com]
 *
 * This work is licensed under the Creative Commons
 * Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0) License.
 * See: https://creativecommons.org
 */

// Curve resolution ($fn: 100 = standard, 180 = high precision)
$fn = 120;

/* [Display Modes] */
assembled_preview_mode = false; // true = closed cross-section view (clearance check)
print_test_mode        = false; // true = 16 mm test slice (fast calibration)

/* [Desired Max Capacity per Column (defines box length)] */
max_batteries_1  = 10; // [1:1:50] Column 1 (CR2450)
max_batteries_2  = 12; // [1:1:50] Column 2 (CR2032/2025/2016)
max_batteries_3  = 12; // [1:1:50] Column 3 (CR1632/1620)
max_batteries_4a = 8;  // [1:1:40] Column 4 Front (CR1225 - thin 2.5 mm)
max_batteries_4b = 5;  // [1:1:40] Column 4 Back (LR44/43 - thick 5.4 mm)
max_batteries_5  = 12; // [1:1:50] Column 5 (LR41/LR626)

/* [3D Printer Precision & Tolerances] */
battery_diameter_clearance  = 0.40; // Clearance added to actual battery Ø (CR-10S if tight: 0.50)
battery_thickness_clearance = 0.40; // Clearance added to max thickness (CR-10S if tight: 0.45)
battery_vertical_clearance  = 0.25; // Exact vertical clearance at the top of the arch (mm)
fit_clearance               = 0.25; // Radial clearance per side between lip and lid (CR-10S: 0.35)
xy_compensation             = 0.00; // Horizontal over-extrusion compensation (CR-10S Bowden: 0.08)

/* [Top Lid Partitions ("Mickey Ears")] */
enable_top_partitions   = true; // Adds the 2 small transverse partitions between each battery
top_partition_clearance = 0.15; // Clearance between top of battery and inner arch of ears (mm)

/* [Global Dimensions & Nominal IEC Batteries] */
corner_radius   = 5.0;
base_chamfer    = 1.2;
wall_thickness  = 3.5;

/* [ACTUAL (Nominal IEC) Battery Diameters per Column] */
d1_nom = 24.5; d2_nom = 20.0; d3_nom = 16.0; d4_nom = 12.5; d5_nom = 7.9;
/* [ACTUAL (Nominal IEC) Max Thicknesses per Column] */
t1_nom = 5.0;  t2_nom = 3.2;  t3_nom = 3.2;  t4a_nom = 2.5; t4b_nom = 5.4; t5_nom = 3.6;

/* [Horizontally Engraved Labels at Start/End of Column] */
lbl1_a = "CR2450"; lbl1_b = "";
lbl2_a = "CR2032"; lbl2_b = "2025/2016";
lbl3_a = "CR1632"; lbl3_b = "CR1620";
lbl4_a = "CR1225"; lbl4_b = "LR44/43"; // lbl4_a on CR1225 side, lbl4_b on LR44/43 side
lbl5_a = "LR41";   lbl5_b = "LR626";

/* [Partitions, Heights, Notches & Engraving] */
partition_thickness       = 1.0;  // Thickness of dividers between batteries (CR-10S: 1.2)
partition_axis_protrusion = 0.8;  // Height of partitions above battery center axis (mm)
top_battery_retention     = 0.25; // [0.10:0.05:0.45] Fraction of top of each battery capped by lid
column_spacing            = 1.8;  min_bottom = 2.2;
lip_height                = 3.0;  lip_thickness = 1.6; ceiling_thickness = 2.6;
notch_length              = 42.0; notch_radius = 2.2; notch_depth = 1.4;
notch_joint_offset        = 2.8;  // Symmetrical distance above and below the parting line
show_labels               = true; engraving_depth = 0.6; part_spacing = 10.0;

// Automatic calculation of dimensions with clearances
d1 = d1_nom + battery_diameter_clearance + 2 * xy_compensation;
d2 = d2_nom + battery_diameter_clearance + 2 * xy_compensation;
d3 = d3_nom + battery_diameter_clearance + 2 * xy_compensation;
d4 = d4_nom + battery_diameter_clearance + 2 * xy_compensation;
d5 = d5_nom + battery_diameter_clearance + 2 * xy_compensation;

t1  = t1_nom  + battery_thickness_clearance + 2 * xy_compensation;
t2  = t2_nom  + battery_thickness_clearance + 2 * xy_compensation;
t3  = t3_nom  + battery_thickness_clearance + 2 * xy_compensation;
t4a = t4a_nom + battery_thickness_clearance + 2 * xy_compensation;
t4b = t4b_nom + battery_thickness_clearance + 2 * xy_compensation;
t5  = t5_nom  + battery_thickness_clearance + 2 * xy_compensation;

// 1. Usable length driven by the most constraining column (sum CR1225 + LR44 for col. 4)
l_req1 = max_batteries_1 * t1 + (max_batteries_1 - 1) * partition_thickness;
l_req2 = max_batteries_2 * t2 + (max_batteries_2 - 1) * partition_thickness;
l_req3 = max_batteries_3 * t3 + (max_batteries_3 - 1) * partition_thickness;
l_req4 = max_batteries_4a * t4a + max_batteries_4b * t4b + (max_batteries_4a + max_batteries_4b - 1) * partition_thickness;
l_req5 = max_batteries_5 * t5 + (max_batteries_5 - 1) * partition_thickness;

usable_length = max(l_req1, max(l_req2, max(l_req3, max(l_req4, l_req5))));
box_length    = usable_length + 2 * wall_thickness;

n1 = floor((usable_length + partition_thickness + 0.001) / (t1 + partition_thickness));
n2 = floor((usable_length + partition_thickness + 0.001) / (t2 + partition_thickness));
n3 = floor((usable_length + partition_thickness + 0.001) / (t3 + partition_thickness));
n5 = floor((usable_length + partition_thickness + 0.001) / (t5 + partition_thickness));

// Exact distribution of usable length on column 4 (CR1225 + LR44)
surplus_l4 = max(0, usable_length - l_req4);
n4a = max_batteries_4a + floor((surplus_l4 * 0.5 + 0.001) / (t4a + partition_thickness));
l_rem_4b = usable_length - (n4a * t4a + n4a * partition_thickness);
n4b = max(1, floor((l_rem_4b + partition_thickness + 0.001) / (t4b + partition_thickness)));

pitch_4a       = t4a + partition_thickness;
zone_length_4a = n4a * pitch_4a - partition_thickness / 2;
zone_length_4b = usable_length - zone_length_4a - partition_thickness / 2;
pitch_4b       = (zone_length_4b + partition_thickness) / n4b;

// 2. Alignment of battery centers and tangency of partitions above the base
d_max     = max(d1, max(d2, max(d3, max(d4, d5))));
d_max_nom = max(d1_nom, max(d2_nom, max(d3_nom, max(d4_nom, d5_nom))));
z_common_axis = min_bottom + d_max / 2;

bottom_1 = z_common_axis - d1 / 2;
bottom_2 = z_common_axis - d2 / 2;
bottom_3 = z_common_axis - d3 / 2;
bottom_4 = z_common_axis - d4 / 2;
bottom_5 = z_common_axis - d5 / 2;

z_partition_top = z_common_axis + partition_axis_protrusion;
base_height     = z_partition_top;

total_assembly_clearance = fit_clearance + 2 * xy_compensation;
tot_w_channels = d1 + d2 + d3 + d4 + d5 + 4 * column_spacing;
usable_width   = tot_w_channels + 1.0;
box_width      = usable_width + 2 * wall_thickness;

max_battery_top    = min_bottom + d_max_nom;
total_inner_height = max_battery_top + max(battery_vertical_clearance, (d_max - d_max_nom) / 2);
lid_height         = total_inner_height - (base_height - lip_height) + ceiling_thickness;
z_lid_offset       = total_inner_height + ceiling_thickness;

x1 = -tot_w_channels / 2 + d1 / 2;
x2 = x1 + d1 / 2 + column_spacing + d2 / 2;
x3 = x2 + d2 / 2 + column_spacing + d3 / 2;
x4 = x3 + d3 / 2 + column_spacing + d4 / 2;
x5 = x4 + d4 / 2 + column_spacing + d5 / 2;
module centered_rect(w, l) { translate(concat(-w / 2, -l / 2)) square(size = w == l ? w : concat(w, l)); }
module centered_box(w, l, h) { translate(concat(-w / 2, -l / 2, -h / 2)) cube(size = concat(w, l, h)); }

module fit_profile(radial_clearance) {
    r_lip = max(1, corner_radius - (wall_thickness - lip_thickness));
    offset(r = r_lip + radial_clearance) centered_rect(box_width - 2 * corner_radius, box_length - 2 * corner_radius);
}

module box_body(w, l, h, r, ch) {
    hull() {
        linear_extrude(0.01) offset(r = r - ch) centered_rect(w - 2 * r, l - 2 * r);
        translate(concat(0, 0, ch)) linear_extrude(h - ch) offset(r = r) centered_rect(w - 2 * r, l - 2 * r);
    }
}

module single_notch(x_pos, z_pos) {
    eff_notch_l = min(notch_length, box_length - 2 * corner_radius - 4);
    dy = max(0, eff_notch_l / 2 - notch_radius);
    translate(concat(x_pos, 0, z_pos)) hull() {
        translate(concat(0, -dy, 0)) sphere(r = notch_radius);
        translate(concat(0,  dy, 0)) sphere(r = notch_radius);
    }
}

module side_notches(w, z_pos) {
    dx = w / 2 - notch_depth + notch_radius;
    single_notch(-dx, z_pos); single_notch(dx, z_pos);
}

module battery_channel(x_pos, z_axis, diam, length) {
    translate(concat(x_pos, 0, z_axis)) rotate(concat(90, 0, 0)) cylinder(h = length, d = diam, center = true);
}

module lid_slot(x_pos, y_center, slot_width, slot_length, height) {
    r_f = slot_width / 2; dy = max(0, slot_length / 2 - r_f);
    translate(concat(x_pos, y_center, -0.1)) linear_extrude(height) hull() {
        translate(concat(0, -dy)) circle(r = r_f);
        translate(concat(0,  dy)) circle(r = r_f);
    }
}

module channel_cutout(x_pos, z_bottom, diam) {
    battery_channel(x_pos, z_bottom + diam / 2, diam, usable_length);
    translate(concat(x_pos, 0, z_bottom + diam / 2 + 15)) centered_box(diam, usable_length, 30);
}

module partitions_rec(x_pos, z_bottom, diam, pitch, y_start, j, max_j) {
    if (j <= max_j) {
        h_part = z_partition_top - z_bottom;
        translate(concat(x_pos, y_start + j * pitch, z_bottom + h_part / 2))
            centered_box(diam, partition_thickness, h_part);
        partitions_rec(x_pos, z_bottom, diam, pitch, y_start, j + 1, max_j);
    }
}

module channel_partitions(x_pos, z_bottom, diam, count) {
    pitch = (usable_length + partition_thickness) / count; y_start = -usable_length / 2 - partition_thickness / 2;
    intersection() {
        channel_cutout(x_pos, z_bottom, diam);
        partitions_rec(x_pos, z_bottom, diam, pitch, y_start, 1, count - 1);
    }
}

module mixed_channel_partitions(x_pos, z_bottom, diam) {
    y_start_a = -usable_length / 2 - partition_thickness / 2;
    y_start_b = -usable_length / 2 + zone_length_4a;
    intersection() {
        channel_cutout(x_pos, z_bottom, diam);
        union() {
            partitions_rec(x_pos, z_bottom, diam, pitch_4a, y_start_a, 1, n4a);
            partitions_rec(x_pos, z_bottom, diam, pitch_4b, y_start_b, 1, n4b - 1);
        }
    }
}

module base() {
    z_lip_base = base_height - lip_height;
    difference() {
        box_body(box_width, box_length, base_height, corner_radius, base_chamfer);
        translate(concat(0, 0, z_lip_base)) difference() {
            linear_extrude(lip_height + 0.1) centered_rect(box_width + 2, box_length + 2);
            linear_extrude(lip_height + 0.1) fit_profile(0);
        }
        channel_cutout(x1, bottom_1, d1);
        channel_cutout(x2, bottom_2, d2);
        channel_cutout(x3, bottom_3, d3);
        channel_cutout(x4, bottom_4, d4);
        channel_cutout(x5, bottom_5, d5);
        side_notches(box_width, z_lip_base - notch_joint_offset);
    }
    channel_partitions(x1, bottom_1, d1, n1);
    channel_partitions(x2, bottom_2, d2, n2);
    channel_partitions(x3, bottom_3, d3, n3);
    mixed_channel_partitions(x4, bottom_4, d4);
    channel_partitions(x5, bottom_5, d5, n5);
}
module retention_boss(x_pos, z_bottom, diam, d_nom) {
    arch_depth = d_nom * top_battery_retention;
    col_battery_top = z_bottom + d_nom;
    h_boss = max(0, total_inner_height - (col_battery_top + battery_vertical_clearance) + arch_depth);
    landing_width = diam + column_spacing + 0.02;
    if (h_boss > 0.1) translate(concat(x_pos, 0, ceiling_thickness + h_boss / 2 - 0.05))
        centered_box(landing_width, usable_length - 1.2, h_boss + 0.05);
}

module ear_partitions_rec(x_pos, z_arch_axis, diam, d_nom, z_landing, pitch, y_start, j, max_j) {
    if (j <= max_j) {
        y_part = -(y_start + j * pitch);
        r_arch = diam / 2;
        r_ref  = d_nom / 2 + top_partition_clearance;

        sin_a1 = max(-1, min(1, (r_arch * 0.50) / r_ref));
        a1 = asin(sin_a1);
        cos_a2 = max(-1, min(1, (z_arch_axis - z_landing) / r_ref));
        a2 = acos(cos_a2);

        a_mid = (a1 + a2) / 2;
        dx_c  = r_ref * sin(a_mid);
        z_c   = z_arch_axis - r_ref * cos(a_mid);
        r_ear = 2 * r_ref * sin(abs(a2 - a1) / 4);

        for (s = [-1, 1]) {
            translate(concat(x_pos + s * dx_c, y_part, z_c))
            rotate(concat(90, 0, 0))
            cylinder(h = partition_thickness, r = r_ear, center = true);
        }
        ear_partitions_rec(x_pos, z_arch_axis, diam, d_nom, z_landing, pitch, y_start, j + 1, max_j);
    }
}

module channel_ear_partitions(x_pos, z_bottom, diam, d_nom, count, is_mixed) {
    if (enable_top_partitions) {
        arch_depth = d_nom * top_battery_retention;
        col_battery_top = z_bottom + d_nom;
        h_boss = max(0, total_inner_height - (col_battery_top + battery_vertical_clearance) + arch_depth);
        z_landing = min(lid_height, ceiling_thickness + h_boss);

        z_assembled_arch_top = col_battery_top + battery_vertical_clearance;
        z_lid_arch_axis = z_lid_offset - (z_assembled_arch_top - diam / 2);

        intersection() {
            if (is_mixed) {
                y_start_a = -usable_length / 2 - partition_thickness / 2;
                y_start_b = -usable_length / 2 + zone_length_4a;
                union() {
                    ear_partitions_rec(x_pos, z_lid_arch_axis, diam, d_nom, z_landing, pitch_4a, y_start_a, 1, n4a);
                    ear_partitions_rec(x_pos, z_lid_arch_axis, diam, d_nom, z_landing, pitch_4b, y_start_b, 1, n4b - 1);
                }
            } else {
                pitch = (usable_length + partition_thickness) / count;
                y_start = -usable_length / 2 - partition_thickness / 2;
                ear_partitions_rec(x_pos, z_lid_arch_axis, diam, d_nom, z_landing, pitch, y_start, 1, count - 1);
            }
            translate(concat(x_pos, 0, ceiling_thickness + 15))
                centered_box(diam + column_spacing, usable_length - 1.2, 30);
        }
    }
}

module line_engraving(x_pos, y_pos, txt, font_size) {
    translate(concat(x_pos, y_pos, -0.05)) mirror(concat(1, 0, 0)) linear_extrude(engraving_depth + 0.05)
        text(txt, size = font_size, font = "Liberation Sans:style=Bold", halign = "center", valign = "center");
}

module lid_detail(x_pos, z_bottom, diam, d_nom, txt_a, txt_b, slot_len, y_slot_center, y_txt_front, y_txt_back, is_mixed) {
    arch_depth = d_nom * top_battery_retention;
    col_battery_top = z_bottom + d_nom;
    h_boss = max(0, total_inner_height - (col_battery_top + battery_vertical_clearance) + arch_depth);
    z_assembled_arch_top = col_battery_top + battery_vertical_clearance;
    z_lid_arch_axis = z_lid_offset - (z_assembled_arch_top - diam / 2);
    hull() {
        battery_channel(x_pos, z_lid_arch_axis, diam, usable_length + 0.4);
        battery_channel(x_pos, z_lid_arch_axis + 4.0, diam, usable_length + 0.4);
    }
    lid_slot(x_pos, y_slot_center, diam * 0.50, slot_len, ceiling_thickness + h_boss + 2);
    if (show_labels) {
        font_size = min(2.6, max(1.45, ((diam + column_spacing * 0.5) / max(1, max(len(txt_a), len(txt_b)))) * 1.35));
        if (is_mixed) {
            // Y-inverted on the lid so CR1225 and LR44/43 align directly above their compartments when flipped
            line_engraving(x_pos, y_txt_back, txt_a, font_size);
            line_engraving(x_pos, y_txt_front, txt_b, font_size);
        } else {
            if (txt_b == "") line_engraving(x_pos, y_txt_front, txt_a, font_size);
            else { line_engraving(x_pos, y_txt_front + font_size * 0.72, txt_a, font_size); line_engraving(x_pos, y_txt_front - font_size * 0.72, txt_b, font_size); }
        }
    }
}

module lid() {
    y_txt_front = -box_length / 2 + 5.6;
    y_txt_back  =  box_length / 2 - 5.6;
    y_slot_start   = -box_length / 2 + (show_labels ? 8.6 : 4.0) + 1.8;
    y_slot_end_std = usable_length / 2 - 4.0;
    y_slot_end_mix = box_length / 2 - (show_labels ? 8.6 : 4.0) - 1.8;

    slot_len_std = max(2, y_slot_end_std - y_slot_start); y_slot_center_std = (y_slot_end_std + y_slot_start) / 2;
    slot_len_mix = max(2, y_slot_end_mix - y_slot_start); y_slot_center_mix = (y_slot_end_mix + y_slot_start) / 2;

    union() {
        difference() {
            union() {
                difference() {
                    box_body(box_width, box_length, lid_height, corner_radius, base_chamfer);
                    translate(concat(0, 0, lid_height - lip_height - 0.2)) linear_extrude(lip_height + 0.3) fit_profile(total_assembly_clearance);
                    translate(concat(0, 0, ceiling_thickness)) linear_extrude(lid_height - ceiling_thickness + 0.1) centered_rect(usable_width, usable_length);
                }
                intersection() {
                    union() {
                        retention_boss(x1, bottom_1, d1, d1_nom);
                        retention_boss(x2, bottom_2, d2, d2_nom);
                        retention_boss(x3, bottom_3, d3, d3_nom);
                        retention_boss(x4, bottom_4, d4, d4_nom);
                        retention_boss(x5, bottom_5, d5, d5_nom);
                    }
                    translate(concat(0, 0, lid_height / 2))
                        centered_box(usable_width - 0.6, usable_length - 1.2, lid_height + 10);
                }
            }
            lid_detail(x1, bottom_1, d1, d1_nom, lbl1_a, lbl1_b, slot_len_std, y_slot_center_std, y_txt_front, y_txt_back, false);
            lid_detail(x2, bottom_2, d2, d2_nom, lbl2_a, lbl2_b, slot_len_std, y_slot_center_std, y_txt_front, y_txt_back, false);
            lid_detail(x3, bottom_3, d3, d3_nom, lbl3_a, lbl3_b, slot_len_std, y_slot_center_std, y_txt_front, y_txt_back, false);
            lid_detail(x4, bottom_4, d4, d4_nom, lbl4_a, lbl4_b, slot_len_mix, y_slot_center_mix, y_txt_front, y_txt_back, true);
            lid_detail(x5, bottom_5, d5, d5_nom, lbl5_a, lbl5_b, slot_len_std, y_slot_center_std, y_txt_front, y_txt_back, false);
            side_notches(box_width, lid_height - lip_height - notch_joint_offset);
        }
        channel_ear_partitions(x1, bottom_1, d1, d1_nom, n1, false);
        channel_ear_partitions(x2, bottom_2, d2, d2_nom, n2, false);
        channel_ear_partitions(x3, bottom_3, d3, d3_nom, n3, false);
        channel_ear_partitions(x4, bottom_4, d4, d4_nom, 0,  true);
        channel_ear_partitions(x5, bottom_5, d5, d5_nom, n5, false);
    }
}

module test_slice(obj_h) { translate(concat(0, box_length / 2 - 8, obj_h / 2)) centered_box(box_width + 2, 16, obj_h + 2); }
if (assembled_preview_mode) {
    difference() { union() { base(); translate(concat(0, 0, z_lid_offset)) rotate(concat(180, 0, 0)) lid(); } translate(concat(0, -box_length / 2, 20)) centered_box(box_width + 4, box_length, 50); }
} else if (print_test_mode) {
    translate(concat(-(box_width + part_spacing) / 2, 0, 0)) intersection() { base(); test_slice(base_height); }
    translate(concat((box_width + part_spacing) / 2, 0, 0)) intersection() { lid(); test_slice(lid_height); }
} else {
    translate(concat(-(box_width + part_spacing) / 2, 0, 0)) base();
    translate(concat((box_width + part_spacing) / 2, 0, 0)) lid();
}

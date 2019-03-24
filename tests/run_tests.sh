#!/bin/sh

LIST="\
gd_draw_arc
gd_draw_circle
gd_draw_ellipse
gd_draw_line
gd_draw_polygon
gd_draw_rectangle
gd_draw_regular_polygon
gd_filter_brightness
gd_filter_contrast
gd_filter_edge_detect_quick
gd_filter_emboss
gd_filter_gaussian_blur
gd_filter_gray_scale
gd_filter_mean_removal
gd_filter_negate
gd_filter_selective_blur
gd_filter_smooth
gd_flip
gd_scale
gd_set_color
gd_set_pixel
gd_set_thickness
gd_string_ft
gd_string
gd_character
gd_create_from"

for PROC in $LIST
do
    # echo "$PROC.nim"
    nim c -r "$PROC.nim" && rm $PROC
done

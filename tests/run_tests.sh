#!/bin/sh

LIST="\
gd_arc
gd_brightness
gd_character
gd_circle
gd_contrast
gd_create_from
gd_edge_detect_quick
gd_ellipse
gd_emboss
gd_flip
gd_gaussian_blur
gd_gray_scale
gd_line
gd_mean_removal
gd_negate
gd_polygon
gd_rectangle
gd_regular_polygon
gd_selective_blur
gd_set_pixel
gd_smooth
gd_string_ft
gd_string"

for PROC in $LIST
do
    # echo "$PROC.nim"
    nim c -r "$PROC.nim" && rm $PROC
done

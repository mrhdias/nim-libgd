#!/bin/sh

LIST="\
draw_arc
draw_character
draw_circle
draw_ellipse
draw_line
draw_polygon
draw_rectangle
draw_regular_polygon
draw_string
draw_string_ft
filter_brightness
filter_contrast
filter_edge_detect_quick
filter_emboss
filter_gaussian_blur
filter_gray_scale
filter_mean_removal
filter_negate
filter_selective_blur
filter_smooth
image_create_from
image_flip
image_scale
image_size
set_color
set_pixel
set_thickness"

for PROC in $LIST
do
    # echo "$PROC.nim"
    nim c -r "$PROC.nim" && rm $PROC
done

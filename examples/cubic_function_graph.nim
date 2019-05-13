#
# Graphing a Cubic Function
# f(x) = x^3
#
from os import existsOrCreateDir
from math import `^`
from strformat import format
# v0.19.9 from strformat import fmt
import ../src/libgd

# proc sprintf(buf, frmt: cstring) {.header: "<stdio.h>",
#                                   importc: "sprintf",
#                                   varargs, noSideEffect.}

proc display_grid(img: gdImagePtr, steps: int, padding: array[4, int], x_axis = true, y_axis: bool = true) =
  let
    (width, height) = img.imageSize()
    grey = img.setColor(128, 128, 128)

  if x_axis:
    let grid_width = ((width - (padding[0] + padding[2])) / steps).int
    for c in 1 ..< steps:
      img.drawLine(
        startPoint = [padding[0] + grid_width * c, padding[3]],
        endPoint = [padding[0] + grid_width * c, height - padding[1]],
        dashed = true,
        color = grey
      )

  if y_axis:
    let grid_height = ((height - (padding[1] + padding[3])) / steps).int
    for c in 1 ..< 10 :
      img.drawLine(
        startPoint = [padding[0], height - (padding[1] + grid_height * c)],
        endPoint = [width - padding[2], height - (padding[1] + grid_height * c)],
        dashed = true,
        color = grey
      )


proc get_point(measure, min, max, value: int): int =
  let b = measure / (max - min)
  let a = - b * min.float
  return (a + b * value.float).int


proc main() =

  let
    width = 400
    height = 600
    padding = [60, 60, 40, 40]

  withGd imageCreate(width, height) as img:
    let
      white = img.setColor(255, 255, 255)
      grey = img.setColor(128, 128, 128)
      red = img.setColor(255, 0, 0)
      black = img.setColor(0, 0, 0)

    var data: array[21, array[2, int]]

    var
      i = 0
      min_x = 0
      max_x = 0
      min_y = 0
      max_y = 0
      steps = 10

    # collect data
    for x in -10 .. 10:
      var y = x^3
      data[i] = [x, y]

      if x < min_x: min_x = x
      if x > max_x: max_x = x

      if y < min_y: min_y = y
      if y > max_y: max_y = y

      i += 1

    img.setThickness(1)
    img.drawRectangle(startCorner=[padding[0], padding[3]], endCorner=[width - padding[2], height - padding[1]], color=grey)

    img.display_grid(steps, padding, x_axis=true, y_axis=true)

    # add x values
    let sx = (max_x - min_x) / steps
    let pos_x_step = ((width - (padding[0] + padding[2])) / steps).int
    for i in 0 .. steps:
      let n = (min_x.float + sx * i.float).int
      var res = ""
      n.format("3", res)
      img.drawString(
        font=gdFontGetSmall(),
        position=[padding[0] - 12 + pos_x_step * i, height - (padding[1] - 10)],
        text = res, # v0.19.9 fmt"{n:3}",
        color=black
      )

    # add y values
    let sy = (max_y - min_y) / steps
    let pos_y_step = ((height - (padding[1] + padding[3])) / steps).int
    for i in 0 .. steps:
      let n = (min_y.float + sy * i.float).int
      var res = ""
      n.format("5", res)
      img.drawString(
        font=gdFontGetSmall(),
        position=[padding[0] - 40, height - (padding[1] + 7 + pos_y_step * i)],
        text = res, # v0.19.9 fmt"{n:5}",
        color=black
      )

    var
      saved_x = 0
      saved_y = 0
      started = false

    # draw graph
    for n in 0 ..< data.len:
      let x = padding[0] + get_point(width - (padding[0] + padding[2]), min_x, max_x, data[n][0])
      let y = padding[3] + ((height - (padding[1] + padding[3])) - get_point(height - (padding[1] + padding[3]), min_y, max_y, data[n][1]))

      if started:
        img.setThickness(2)
        img.drawLine(startPoint=[saved_x, saved_y], endPoint=[x, y], color=red)

      img.drawCircle(center=[x, y], radius=6, fill=true, color=black)

      saved_x = x
      saved_y = y
      started = true

    discard existsOrCreateDir("outputs")

    let png_out = open("outputs/cubic_function_graph.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

main()

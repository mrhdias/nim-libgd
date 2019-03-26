#
# https://www.rosettacode.org/wiki/Fractal_tree
#

from math import sin, cos, PI
import ../src/libgd

const
  width = 400
  height = 300
  depth = 8
  angle = 24
  length = 50
  frac = 0.8

proc fractalTree(img: gdImagePtr, x: int, y: int, distance: int, direction: float, depth: int) =
  let x2 = x + int(distance.float * sin(direction * PI/180))
  let y2 = y - int(distance.float * cos(direction * PI/180))

  img.drawLine(startPoint=[x,y], endPoint=[x2,y2])
  if depth > 0:
    fractalTree(img, x2, y2, int(distance.float * frac), direction - angle, depth - 1)
    fractalTree(img, x2, y2, int(distance.float * frac), direction + angle, depth - 1)

proc main() =

  withGd imageCreate(width, height) as img:

    let white = img.backgroundColor(0xffffff)
    let green = img.foregroundColor(0x00ff00)

    fractalTree(img, int(width / 2), int(height * 9 / 10), length, 0, depth)

    let png_out = open("outputs/fractal_tree.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

main()

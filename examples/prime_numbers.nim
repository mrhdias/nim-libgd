#
# Prime Numbers in Spiral
#

from os import getTempDir, `/`, existsOrCreateDir, removeDir
from math import `^`
import ../src/libgd

proc is_prime(n: int64): bool =
  for i in 2 .. n-1:
    if (n mod i) == 0:
      return false

  return if n != 1 and n != 0: true else: false

proc main() =

  let img_width = 200
  let img_height = 200

  # withGd automatically free the memory associated with the image
  withGd imageCreate(img_width, img_height) as img:
    let black = img.backgroundColor(0, 0, 0)
    let red = img.foregroundColor(255, 0, 0)

    proc spiral(side_x: int, side_y: int) =
      var
        x = 0
        y = 0
        dx = 0
        dy = -1

      let max = if side_x >= side_y: side_x else: side_y

      for i in 0 .. max ^ 2:
        if (x.float >= -side_x / 2 and x.float <= side_x / 2) and (y.float >= -side_y / 2 and y.float <= side_y / 2):
          let c = if is_prime(i): red else: black
          img.setPixel(point=[int(img_width / 2) + x, int(img_height / 2) + y], color=c)
        
        if x == y or (x < 0 and x == -y) or (x > 0 and x == 1-y):
          (dx, dy) = (-dy, dx)
      
        (x, y) = (x + dx, y + dy)

    spiral(img_width, img_height)

    withGd img.imageScale(500, 500) as new_img:
      let png_out = open("prime_numbers.png", fmWrite)
      new_img.writePng(png_out)
      png_out.close()


main()

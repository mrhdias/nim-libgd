#
# http://rosettacode.org/wiki/Sierpinski_triangle/Graphical
#

import ../src/libgd

const
  order = 8
  width = 1 shl order
  margin = 10
  height = width

proc main() =

  withGd img, width + margin * 2, height + margin * 2:
    let white = img.gdBackgroundColor("#ffffff")
    let blue = img.gdForegroundColor("#0000ff")

    for y in 0 .. width-1:
      for x in 0 .. width-1:
        if (x and y) == 0:
          img.gdSetPixel(point=[x + margin, y + margin])

    let png_out = open("sierpinski_triangle.png", fmWrite)
    img.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()


main()




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

  withGd imageCreate(width + margin * 2, height + margin * 2) as img:
    discard img.backgroundColor(0xffffff)
    discard img.foregroundColor(0x0000ff)

    for y in 0 .. width-1:
      for x in 0 .. width-1:
        if (x and y) == 0:
          img.setPixel(point=[x + margin, y + margin])

    let png_out = open("outputs/sierpinski_triangle.png", fmWrite)
    img.writePng(png_out)
    png_out.close()


main()




#
# http://www.rosettacode.org/wiki/Pythagoras_tree
#

import ../src/libgd

const
  img_width = 800
  img_height = 600
  maxDepth = 11 
  colFactor = (255 / maxDepth).int

proc drawSquares(img: gdImagePtr, ax: int, ay: int, bx: int, by: int, depth: int) =

  if depth > maxDepth:
    return

  let (dx, dy) = (bx - ax, ay - by)
  let (x3, y3) = (bx - dy, by - dx)
  let (x4, y4) = (ax - dy, ay - dx)
  let (x5, y5) = (x4 + ((dx - dy).float / 2).int, (y4 - ((dx + dy).float / 2).int))

  let c = img.setColor(0, depth * colFactor, 0)

  img.drawLine(startPoint=[ax, ay], endPoint=[bx, by], color=c)
  img.drawLine(startPoint=[bx, by], endPoint=[x3, y3], color=c)
  img.drawLine(startPoint=[x3, y3], endPoint=[x4, y4], color=c)
  img.drawLine(startPoint=[x4, y4], endPoint=[ax, ay], color=c)

  img.drawSquares(x4, y4, x5, y5, depth + 1)
  img.drawSquares(x5, y5, x3, y3, depth + 1)


proc main() =

  withGd imageCreate(img_width, img_height) as img:
    let white = img.setColor(0xffffffff)
    img.drawSquares(340, 550, 460, 550, 0)
    let png_out = open("outputs/pythagoras_tree.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

main()

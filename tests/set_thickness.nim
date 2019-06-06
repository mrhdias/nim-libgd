#
# setThickness
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
from math import `^`
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(300, 300) as img:
    discard img.setColor(255, 255, 255)

    let red = img.setColor(255, 0, 0)
    for thickness in 1 .. 12:
      let space = thickness ^ 2
      img.setThickness(thickness)
      img.drawRectangle(startCorner=[10 + space, 10 + space], endCorner=[290 - space, 290 - space], color=red)

    let png_out = open(outputsDir / "test_set_thickness.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

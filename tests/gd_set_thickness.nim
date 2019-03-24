#
# gdSetThickness
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
from math import `^`
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 300, 300:
    let white = im.gdSetColor(255, 255, 255)

    let red = im.gdSetColor(255, 0, 0)
    for thickness in 1 .. 12:
      echo thickness
      let space = thickness ^ 2
      im.gdSetThickness(thickness)
      im.gdRectangle(startCorner=[10 + space, 10 + space], endCorner=[290 - space, 290 - space], color=red)



    let png_out = open(outputsDir / "test_gd_set_thickness.png", fmWrite)
    im.gdWrite(png_out, content_type=PNG)
    png_out.close()

  removeDir(outputsDir)

main()

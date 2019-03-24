#
# gdSetThickness
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
from math import `^`
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 300, 300:
    let white = img.gdSetColor(255, 255, 255)

    let red = img.gdSetColor(255, 0, 0)
    for thickness in 1 .. 12:
      let space = thickness ^ 2
      img.gdSetThickness(thickness)
      img.gdDrawRectangle(startCorner=[10 + space, 10 + space], endCorner=[290 - space, 290 - space], color=red)

    let png_out = open(outputsDir / "test_gd_set_thickness.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

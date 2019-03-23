#
# gdFlip
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 300, 300:
    let white = im.gdSetColor(255, 255, 255)

    let red = im.gdSetColor(255, 0, 0)
    im.gdRectangle(startCorner=[50, 50], endCorner=[100, 220], color=red)

    im.gdFlip(GD_FLIP_HORIZONTAL)

    let png_out = open(outputsDir / "test_gd_flip.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()

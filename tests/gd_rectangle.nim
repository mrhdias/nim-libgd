#
# gdRectangle
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 128, 128:
    let white = im.gdSetColor(225, 255, 255)
    let red = im.gdSetColor(255, 0, 0)

    im.gdSetThickness(4)
    im.gdRectangle(startCorner=[10, 10], endCorner=[80, 70], color=red)
    let png_out = open(outputsDir / "test_gd_rectangle.png", fmWrite)
    im.gdWrite(png_out, content_type=PNG)
    png_out.close()

  removeDir(outputsDir)

main()

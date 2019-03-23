#
# gdSetPixel
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 128, 128:
    let white = im.gdSetColor(255, 255, 255)
    let blue = im.gdSetColor("#0000ff")

    for i in 10 .. 100:
      im.gdSetPixel(point=[i, i], color=blue)

    let png_out = open(outputsDir / "test_gd_set_pixel.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()

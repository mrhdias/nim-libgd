#
# gdEllipse
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 128, 128:
    let white = im.gdSetColor(225, 255, 255)
    let green = im.gdSetColor("#0000ff")
    im.gdEllipse(center=[64, 64], axis=[60, 80], color=green, fill=true)
    let png_out = open(outputsDir / "test_gd_ellipse.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()

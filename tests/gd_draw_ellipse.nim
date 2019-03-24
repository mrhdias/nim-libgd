#
# gdDrawEllipse
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 128, 128:
    let white = img.gdSetColor(225, 255, 255)
    let green = img.gdSetColor("#0000ff")
    img.gdDrawEllipse(center=[64, 64], axis=[60, 80], color=green, fill=true)
    let png_out = open(outputsDir / "test_gd_draw_ellipse.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

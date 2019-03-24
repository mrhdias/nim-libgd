#
# gdDrawRectangle
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 128, 128:
    let white = img.gdSetColor(255, 255, 255)
    let red = img.gdSetColor(255, 0, 0)

    img.gdSetThickness(4)
    img.gdDrawRectangle(startCorner=[10, 10], endCorner=[80, 70], color=red)
    let png_out = open(outputsDir / "test_gd_draw_rectangle.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

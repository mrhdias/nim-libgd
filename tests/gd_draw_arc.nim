#
# gdDrawArc
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 128, 128:
    let white = img.gdSetColor(225, 255, 255)
    let blue = img.gdSetColor(0, 0, 255)
    img.gdDrawArc(center=[64, 64], axis=[60, 30], angles=[90, 270], color=blue, style=4, fill=true)
    let png_out = open(outputsDir / "test_gd_draw_arc.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

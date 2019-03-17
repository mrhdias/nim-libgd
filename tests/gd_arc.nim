#
# gdArc
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 128, 128:
    let white = im.gdColor(225, 255, 255)
    let blue = im.gdColor(0, 0, 255)
    im.gdArc(center=[64, 64], axis=[60, 30], angles=[90, 270], color=blue, style=4, fill=true)
    let png_out = open(outputsDir / "test_gd_arc.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()

#
# drawArc
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(128, 128) as img:
    let white = img.setColor(225, 255, 255)
    let blue = img.setColor(0, 0, 255)
    img.drawArc(center=[64, 64], axis=[60, 30], angles=[90, 270], color=blue, style=4, fill=true)
    let png_out = open(outputsDir / "test_draw_arc.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

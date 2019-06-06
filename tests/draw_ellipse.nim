#
# drawEllipse
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(128, 128) as img:
    discard img.setColor(225, 255, 255)
    let green = img.setColor(0x0000ff)
    img.drawEllipse(center=[64, 64], axis=[60, 80], color=green, fill=true)
    let png_out = open(outputsDir / "test_draw_ellipse.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

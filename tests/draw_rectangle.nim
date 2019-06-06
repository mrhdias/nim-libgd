#
# drawRectangle
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(128, 128) as img:
    discard img.setColor(255, 255, 255)
    let red = img.setColor(255, 0, 0)

    img.setThickness(4)
    img.drawRectangle(startCorner=[10, 10], endCorner=[80, 70], color=red)
    let png_out = open(outputsDir / "test_draw_rectangle.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

#
# drawLine
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(64, 64) as img:
    let white = img.setColor(255, 255, 255)
    let black = img.setColor(0, 0, 0)
    img.drawLine(startPoint=[0,0], endPoint=[63,63], color=black)
    let png_out = open(outputsDir / "test_draw_line.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

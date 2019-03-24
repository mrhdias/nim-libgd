#
# gdDrawLine
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 64, 64:
    let white = img.gdSetColor(255, 255, 255)
    let black = img.gdSetColor(0, 0, 0)
    img.gdDrawLine(startPoint=[0,0], endPoint=[63,63], color=black)
    let png_out = open(outputsDir / "test_gd_draw_line.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

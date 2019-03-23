#
# gdLine
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 64, 64:
    let white = im.gdSetColor(255, 255, 255)
    let black = im.gdSetColor(0, 0, 0)
    im.gdLine(startPoint=[0,0], endPoint=[63,63], color=black)
    let png_out = open(outputsDir / "test_gd_line.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()

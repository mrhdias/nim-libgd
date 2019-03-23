#
# gdRegularPolygon
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 500, 500:
    let white = im.gdSetColor(255, 255, 255)

    let red = im.gdSetColor("#ff0000")
    let blue = im.gdSetColor("#0000ff")
    var c = red
    for i in countdown(25, 3):
      im.gdRegularPolygon(center=[250,250], sides=i, radius=10 * (i - 2), start_angle=0, color=c, fill=true)
      c = if c == red: blue else: red

    let png_out = open(outputsDir / "test_gd_regular_polygon.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()


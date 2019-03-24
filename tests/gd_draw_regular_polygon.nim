#
# gdDrawRegularPolygon
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 500, 500:
    let white = img.gdSetColor(255, 255, 255)

    let red = img.gdSetColor("#ff0000")
    let blue = img.gdSetColor("#0000ff")
    var c = red
    for i in countdown(25, 3):
      img.gdDrawRegularPolygon(center=[250,250], sides=i, radius=10 * (i - 2), start_angle=0, color=c, fill=true)
      c = if c == red: blue else: red

    let png_out = open(outputsDir / "test_gd_draw_regular_polygon.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()


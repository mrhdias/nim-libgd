#
# drawRegularPolygon
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(500, 500) as img:
    let white = img.setColor(255, 255, 255)

    let red = img.setColor(0xff0000)
    let blue = img.setColor(0x0000ff)
    var c = red
    for i in countdown(25, 3):
      img.drawRegularPolygon(center=[250,250], sides=i, radius=10 * (i - 2), start_angle=0, color=c, fill=true)
      c = if c == red: blue else: red

    let png_out = open(outputsDir / "test_draw_regular_polygon.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()


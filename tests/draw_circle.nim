#
# drawCircle
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(128, 128) as img:
    let white = img.setColor(225, 255, 255)

    let green = img.setColor(0x0000ff)
    img.drawCircle(center=[64, 64], radius=50, color=green, fill=false)

    let red = img.setColor(0xff0000)
    img.drawCircle(center=[64, 64], radius=20, color=red, fill=true)

    let png_out = open(outputsDir / "test_draw_circle.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

    removeDir(outputsDir)

main()

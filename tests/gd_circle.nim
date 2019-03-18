#
# gdCircle
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 128, 128:
    let white = im.gdColor(225, 255, 255)

    let green = im.gdColor("#0000ff")
    im.gdCircle(center=[64, 64], radius=50, color=green, fill=false)

    let red = im.gdColor("#ff0000")
    im.gdCircle(center=[64, 64], radius=20, color=red, fill=true)

    let png_out = open(outputsDir / "test_gd_circle.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()
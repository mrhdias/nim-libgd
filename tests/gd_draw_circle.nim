#
# gdDrawCircle
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 128, 128:
    let white = img.gdSetColor(225, 255, 255)

    let green = img.gdSetColor("#0000ff")
    img.gdDrawCircle(center=[64, 64], radius=50, color=green, fill=false)

    let red = img.gdSetColor("#ff0000")
    img.gdDrawCircle(center=[64, 64], radius=20, color=red, fill=true)

    let png_out = open(outputsDir / "test_gd_draw_circle.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

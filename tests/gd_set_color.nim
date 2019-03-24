#
# gdSetColor
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 300, 300:
    let white = img.gdSetColor(255, 255, 255)

    let yellow = img.gdSetColor("#ffff00")
    img.gdDrawRectangle(startCorner=[20, 100], endCorner=[200, 200], color=yellow, fill=true)

    let red = img.gdSetColor(255, 0, 0, 128)
    img.gdSetThickness(4)
    img.gdDrawRectangle(startCorner=[40, 40], endCorner=[180, 170], color=red)

    let olive = img.gdSetColor("#808000")
    img.gdDrawRectangle(startCorner=[10, 10], endCorner=[290, 290], color=olive)

    let png_out = open(outputsDir / "test_gd_set_color.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

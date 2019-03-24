#
# gdSetColor
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 300, 300:
    let white = im.gdSetColor(255, 255, 255)

    let yellow = im.gdSetColor("#ffff00")
    im.gdRectangle(startCorner=[20, 100], endCorner=[200, 200], color=yellow, fill=true)

    let red = im.gdSetColor(255, 0, 0, 128)
    im.gdSetThickness(4)
    im.gdRectangle(startCorner=[40, 40], endCorner=[180, 170], color=red)

    let olive = im.gdSetColor("#808000")
    im.gdRectangle(startCorner=[10, 10], endCorner=[290, 290], color=olive)

    let png_out = open(outputsDir / "test_gd_set_color.png", fmWrite)
    im.gdWrite(png_out, content_type=PNG)
    png_out.close()

  removeDir(outputsDir)

main()

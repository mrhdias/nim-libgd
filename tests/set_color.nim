#
# setColor
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(300, 300) as img:
    let white = img.setColor(255, 255, 255)

    let yellow = img.setColor(0xffff00)
    img.drawRectangle(startCorner=[20, 100], endCorner=[200, 200], color=yellow, fill=true)

    let red = img.setColor(255, 0, 0, 128)
    img.setThickness(4)
    img.drawRectangle(startCorner=[40, 40], endCorner=[180, 170], color=red)

    let olive = img.setColor(0x808000)
    img.drawRectangle(startCorner=[10, 10], endCorner=[290, 290], color=olive)

    let png_out = open(outputsDir / "test_set_color.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

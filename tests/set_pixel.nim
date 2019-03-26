#
# setPixel
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(128, 128) as img:
    let white = img.setColor(255, 255, 255)
    let blue = img.setColor(0x0000ff)

    for i in 10 .. 100:
      img.setPixel(point=[i, i], color=blue)

    let png_out = open(outputsDir / "test_set_pixel.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

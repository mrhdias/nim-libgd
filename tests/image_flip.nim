#
# imageFlip
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(300, 300) as img:
    let white = img.setColor(255, 255, 255)

    let red = img.setColor(255, 0, 0)
    img.drawRectangle(startCorner=[50, 50], endCorner=[100, 220], color=red)

    img.imageFlip(HORIZONTAL)

    let png_out = open(outputsDir / "test_image_flip.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

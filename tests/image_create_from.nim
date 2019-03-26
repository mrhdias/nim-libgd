#
# createImageFrom
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  let png_img = open("test_img.jpg", fmRead)
  withGd imageCreateFrom(png_img, JPEG) as img:

    let png_out = open(outputsDir / "test_image_create_from.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  png_img.close()

  removeDir(outputsDir)

main()

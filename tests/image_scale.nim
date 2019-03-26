#
# imageScale
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  let png_img = open("test_img.jpg", fmRead)
  withGd createImageFrom(png_img, JPEG) as img:

    var (w, h) = img.imageSize()
    withGd img.imageScale(int(w.float * 0.5), int(h.float * 0.5)) as newimg:
      let png_out = open(outputsDir / "test_image_scale.png", fmWrite)
      newimg.writePng(png_out)
      png_out.close()

  png_img.close()

  removeDir(outputsDir)

main()

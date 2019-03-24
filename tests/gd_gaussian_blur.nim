#
# gdGaussianBlur
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  let png_img = open("test_img.jpg", fmRead)
  withGd img, png_img, JPEG:

    if img.gdGaussianBlur():
      echo "success"

    let png_out = open(outputsDir / "test_gd_gaussian_blur.png", fmWrite)
    img.gdWrite(png_out, content_type=PNG)
    png_out.close()

  png_img.close()

  removeDir(outputsDir)

main()

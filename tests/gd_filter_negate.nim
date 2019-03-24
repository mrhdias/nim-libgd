#
# gdFilterNegate
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  let png_img = open("test_img.jpg", fmRead)
  withGd img, png_img, JPEG:

    if img.gdFilterNegate():
      echo "success"

    let png_out = open(outputsDir / "test_gd_filter_negate.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  png_img.close()

  removeDir(outputsDir)

main()

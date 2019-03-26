#
# filterSelectiveBlur
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  let png_img = open("test_img.jpg", fmRead)
  withGd createImageFrom(png_img, JPEG) as img:

    if img.filterSelectiveBlur():
      echo "success"

    let png_out = open(outputsDir / "test_filter_selective_blur.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  png_img.close()

  # removeDir(outputsDir)

main()

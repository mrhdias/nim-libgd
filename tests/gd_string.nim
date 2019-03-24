#
# gdString
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 300, 300:
    let white = img.gdSetColor(255, 255, 255)

    let red = img.gdSetColor(255, 0, 0)

    img.gdString(font=gdFontGetSmall(), position=[100, 120], text="Hello World 1!", color=red)

    img.gdString(font=gdFontGetSmall(), position=[100, 140], text="Hello World 2!", color=red, up=true)

    img.gdString(font=gdFontGetLarge(), position=[100, 160], text="Hello World 3!")

    let png_out = open(outputsDir / "test_gd_string.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()


  removeDir(outputsDir)

main()

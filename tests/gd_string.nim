#
# gdString
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 300, 300:
    let white = im.gdSetColor(255, 255, 255)

    let red = im.gdSetColor(255, 0, 0)

    im.gdString(font=gdFontGetSmall(), position=[100, 120], text="Hello World 1!", color=red)

    im.gdString(font=gdFontGetSmall(), position=[100, 140], text="Hello World 2!", color=red, up=true)

    im.gdString(font=gdFontGetLarge(), position=[100, 160], text="Hello World 3!")

    let png_out = open(outputsDir / "test_gd_string.png", fmWrite)
    im.gdWrite(png_out, content_type=PNG)
    png_out.close()


  removeDir(outputsDir)

main()

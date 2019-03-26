#
# drawString
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(300, 300) as img:
    let white = img.setColor(255, 255, 255)

    let red = img.setColor(255, 0, 0)

    img.drawString(font=gdFontGetSmall(), position=[100, 120], text="Hello World 1!", color=red)

    img.drawString(font=gdFontGetSmall(), position=[100, 140], text="Hello World 2!", color=red, up=true)

    img.drawString(font=gdFontGetLarge(), position=[100, 160], text="Hello World 3!")

    let png_out = open(outputsDir / "test_draw_string.png", fmWrite)
    img.writePng(png_out)
    png_out.close()


  removeDir(outputsDir)

main()

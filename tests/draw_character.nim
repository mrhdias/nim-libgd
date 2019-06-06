#
# drawCharacter
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(300, 300) as img:
    discard img.setColor(255, 255, 255)

    let blue = img.setColor(0, 0, 255)

    img.drawCharacter(font=gdFontGetSmall(), position=[100, 120], character='H', color=blue)
  
    img.drawCharacter(font=gdFontGetLarge(), position=[100, 140], character='i', color=blue, up=true)

    let png_out = open(outputsDir / "test_draw_character.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

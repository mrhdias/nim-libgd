#
# gdCharacter
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 300, 300:
    let white = im.gdSetColor(255, 255, 255)

    let blue = im.gdSetColor(0, 0, 255)

    im.gdCharacter(font=gdFontGetSmall(), position=[100, 120], character='H', color=blue)
  
    im.gdCharacter(font=gdFontGetLarge(), position=[100, 140], character='i', color=blue, up=true)

    let png_out = open(outputsDir / "test_gd_character.png", fmWrite)
    im.gdWrite(png_out, content_type=PNG)
    png_out.close()

  removeDir(outputsDir)

main()

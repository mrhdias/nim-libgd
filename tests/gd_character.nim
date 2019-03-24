#
# gdCharacter
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 300, 300:
    let white = img.gdSetColor(255, 255, 255)

    let blue = img.gdSetColor(0, 0, 255)

    img.gdCharacter(font=gdFontGetSmall(), position=[100, 120], character='H', color=blue)
  
    img.gdCharacter(font=gdFontGetLarge(), position=[100, 140], character='i', color=blue, up=true)

    let png_out = open(outputsDir / "test_gd_character.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

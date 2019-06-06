#
# gdStringFt
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(300, 300) as img:
    discard img.setColor(255, 255, 255)

    try:
      let blue = img.setColor(0x0000ff)
      img.drawStringFt(color=blue, fontList="LiberationSans-Bold", size=20.0, angle=0.0, position=[100, 200], text="Hello World!")
    except GDFontError:
      let msg = getCurrentExceptionMsg()
      echo msg & ". Please execute this comand:"
      echo "export GDFONTPATH=/usr/share/fonts/TTF/"

    let png_out = open(outputsDir / "test_gd_string_ft.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

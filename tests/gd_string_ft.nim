#
# gdStringFt
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 300, 300:
    let white = img.gdSetColor(255, 255, 255)
    let blue = img.gdSetColor(0, 0, 255)

    try:
      let blue = img.gdSetColor("#0000ff")
      img.gdStringFt(color=blue, fontList="LiberationSans-Bold", size=20.0, angle=0.0, position=[100, 200], text="Hello World!")
    except GDFontError:
      let msg = getCurrentExceptionMsg()
      echo msg & ". Please execute this comand:"
      echo "export GDFONTPATH=/usr/share/fonts/TTF/"

    let png_out = open(outputsDir / "test_gd_string_ft.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()

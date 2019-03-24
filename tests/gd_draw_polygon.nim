#
# gdDrawPolygon
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd img, 500, 500:
    let white = img.gdSetColor(255, 255, 255)

    let blue = img.gdSetColor("#0000ff")
    img.gdDrawPolygon(points=[[120,100],[250,100],[250,300],[100,300]], color=blue, fill=false, open=false)

    let green = img.gdSetColor("#00ff00")
    img.gdDrawPolygon(points=[[50,50],[100,50],[75,100]], color=green, fill=true, open=false)  

    let red = img.gdSetColor("#ff0000")
    img.gdDrawPolygon(points=[[200,150],[250,160],[220,210],[100,150]], color=red, fill=false, open=true)  
  
    let png_out = open(outputsDir / "test_gd_draw_polygon.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()


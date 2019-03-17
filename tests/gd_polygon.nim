#
# gdPolygon
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd im, 500, 500:
    let white = im.gdColor(255, 255, 255)

    let blue = im.gdColor("#0000ff")
    im.gdPolygon(points=[[120,100],[250,100],[250,300],[100,300]], color=blue, fill=false, open=false)

    let green = im.gdColor("#00ff00")
    im.gdPolygon(points=[[50,50],[100,50],[75,100]], color=green, fill=true, open=false)  

    let red = im.gdColor("#ff0000")
    im.gdPolygon(points=[[200,150],[250,160],[220,210],[100,150]], color=red, fill=false, open=true)  
  
    let png_out = open(outputsDir / "test_gd_polygon.png", fmWrite)
    im.gdWrite(png_out, content_type=GD_PNG)
    png_out.close()

  removeDir(outputsDir)

main()


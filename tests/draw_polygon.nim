#
# drawPolygon
#
from os import getTempDir, `/`, existsOrCreateDir, removeDir
import libgd

proc main() =

  let outputsDir = getTempDir() / "libgd-test"
  discard existsOrCreateDir(outputsDir)

  withGd imageCreate(500, 500) as img:
    let white = img.setColor(255, 255, 255)

    let blue = img.setColor(0x0000ff)
    img.drawPolygon(points=[[120,100],[250,100],[250,300],[100,300]], color=blue, fill=false, open=false)

    let green = img.setColor(0x00ff00)
    img.drawPolygon(points=[[50,50],[100,50],[75,100]], color=green, fill=true, open=false)  

    let red = img.setColor(0xff0000)
    img.drawPolygon(points=[[200,150],[250,160],[220,210],[100,150]], color=red, fill=false, open=true)  
  
    let png_out = open(outputsDir / "test_draw_polygon.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

  removeDir(outputsDir)

main()


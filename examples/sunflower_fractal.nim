#
# http://rosettacode.org/wiki/Sunflower_fractal
#

from math import sqrt, pow, PI, sin, cos
import ../src/libgd

const
  width = 400
  height = 400
  numberOfSeeds = 3000

proc main() =
  withGd img, width, height:
    let white = img.gdBackgroundColor("#ffffff")
    let blue = img.gdForegroundColor("#0000ff")

    let c = (sqrt(5.float) + 1) / 2

    for i in 0 .. numberOfSeeds:
      var fi = i.float
      let fn = numberOfSeeds.float

      let r = pow(fi, c) / fn
      let angle = 2 * PI * c * fi
      let x = r * sin(angle) + width / 2
      let y = r * cos(angle) + height / 2
      fi = fi / (fn / 5)
      
      img.gdDrawCircle(center=[x.int, y.int], radius=fi.int)

    let png_out = open("sunflower_fractal.png", fmWrite)
    img.gdWritePng(png_out)
    png_out.close()

main()

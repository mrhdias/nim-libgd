#
# Newton Fractal
# http://code.activestate.com/recipes/577166-newton-fractals/
#
import complex
from math import `mod`
import ../src/libgd

const
  img_width = 512
  img_height = 512
  xa = -1.0
  xb = 1.0
  ya = -1.0
  yb = 1.0
  maxIt = 20
  h = 1e-6
  eps = 1e-3

proc f(z: Complex): Complex = z * z * z - 1.0

proc main() =

  withGd imageCreate(img_width, img_height, true) as img:

    for y in 0 .. img_height - 1:
      let zy = (y.float * (yb - ya) / (img_height.float - 1.0)) + ya
      for x in 0 .. img_width - 1:
        let zx = x.float * (xb - xa) / (img_width.float - 1.0) + xa
        var z: Complex = (re: zx, im: zy)
        var j = 0
        for i in 0 .. maxIt - 1:
          j = i
          let dz = (f(z + (re: h, im: h)) - f(z)) / (re: h, im: h)
          let z0 = z - f(z) / dz
          if abs(z0 - z) < eps:
            #echo "Break: " & $j
            break
          z = z0

        let c = img.setColor(j mod 4 * 64, j mod 8 * 32, j mod 16 * 16)
        let r = j mod 4 * 64
        let g = j mod 8 * 32
        let b = j mod 16 * 16
        img.setPixel(point=[x, y], color=c)

    let png_out = open("outputs/newton_fractal.png", fmWrite)
    img.writePng(png_out)
    png_out.close()

main()

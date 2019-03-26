#
# imageSize
#
import libgd

proc main() =

  let png_img = open("test_img.jpg", fmRead)
  withGd createImageFrom(png_img, JPEG) as img:

    var (w, h) = img.imageSize()
    echo "Width: " & $w
    echo "Height: " & $h

  png_img.close()

main()

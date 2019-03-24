# nim-libgd
Nim Wrapper for LibGD 2.x

Work in progress...

### Drawing Functions

```nim
proc gdSetPixel(
  img: gdImagePtr,
  point: array[2,int],
  color: int = -1
)
proc gdDrawLine(
  img: gdImagePtr,
  start_point: array[2,int],
  end_point: array[2,int],
  color: int = -1,
  dashed: bool = false
)
proc gdDrawRectangle(
  img: gdImagePtr,
  start_corner: array[2,int],
  end_corner: array[2,int],
  color: int,
  fill: bool = false
)
proc gdDrawArc(
  img: gdImagePtr,
  center: array[2,int],
  axis: array[2,int],
  angles: array[2,int],
  color: int,
  fill: bool = false,
  style: int = 0
)
proc gdDrawEllipse(
  img: gdImagePtr,
  center: array[2,int],
  axis: array[2,int],
  color: int,
  fill: bool = false
)
proc gdDrawCircle(
  img: gdImagePtr,
  center: array[2,int],
  radius: int,
  color: int = -1,
  fill: bool = false
)
proc gdDrawPolygon(
  img: gdImagePtr,
  points: openArray[array[0..1, int]],
  color: int,
  fill: bool = false,
  open: bool = false
)
proc gdDrawRegularPolygon(
  img: gdImagePtr,
  center: array[2,int],
  sides: int,
  radius: int,
  start_angle: int = 0,
  color: int,
  fill: bool = false,
  open: bool = false
)
```
### Image Filters

```nim
proc gdFilterContrast(src: gdImagePtr, contrast: float): bool
proc gdFilterBrightness(src: gdImagePtr, brightness: int): bool
proc gdFilterGrayScale(src: gdImagePtr): bool
proc gdFilterNegate(src: gdImagePtr): bool
proc gdFilterEmboss(src: gdImagePtr): bool
proc gdFilterGaussianBlur(src: gdImagePtr): bool
proc gdFilterSmooth(src: gdImagePtr, weight: float): bool
proc gdFilterEdgeDetectQuick(src: gdImagePtr): bool
proc gdFilterSelectiveBlur(src: gdImagePtr): bool
proc gdFilterMeanRemoval(src: gdImagePtr): bool
```

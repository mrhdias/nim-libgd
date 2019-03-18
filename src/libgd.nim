#
#
#
from parseutils import parseHex
from math import sin, cos, degToRad
import strutils

const
  gdMaxColors* = 256

type
  gdInterpolationMethod* {.size: sizeof(cint).} = enum
    GD_DEFAULT = 0,
    GD_BELL,
    GD_BESSEL,
    GD_BILINEAR_FIXED,
    GD_BICUBIC,
    GD_BICUBIC_FIXED,
    GD_BLACKMAN,
    GD_BOX,
    GD_BSPLINE,
    GD_CATMULLROM,
    GD_GAUSSIAN,
    GD_GENERALIZED_CUBIC,
    GD_HERMITE,
    GD_HAMMING,
    GD_HANNING,
    GD_MITCHELL,
    GD_NEAREST_NEIGHBOUR,
    GD_POWER,
    GD_QUADRATIC,
    GD_SINC,
    GD_TRIANGLE,
    GD_WEIGHTED4,
    GD_LINEAR,
    GD_METHOD_COUNT = 23

  interpolation_method* = proc (a1: cdouble): cdouble {.cdecl.}

type
  gdImage* {.bycopy.} = object
    pixels*: ptr ptr cuchar
    sx*: cint
    sy*: cint
    colorsTotal*: cint
    red*: array[gdMaxColors, cint]
    green*: array[gdMaxColors, cint]
    blue*: array[gdMaxColors, cint]
    open*: array[gdMaxColors, cint]
    transparent*: cint
    polyInts*: ptr cint
    polyAllocated*: cint
    #brush*: ptr gdImageStruct
    #tile*: ptr gdImageStruct
    brushColorMap*: array[gdMaxColors, cint]
    tileColorMap*: array[gdMaxColors, cint]
    styleLength*: cint
    stylePos*: cint
    style*: ptr cint
    interlace*: cint
    thick*: cint
    alpha*: array[gdMaxColors, cint]
    trueColor*: cint
    tpixels*: ptr ptr cint
    alphaBlendingFlag*: cint
    saveAlphaFlag*: cint
    AA*: cint
    AA_color*: cint
    AA_dont_blend*: cint
    cx1*: cint
    cy1*: cint
    cx2*: cint
    cy2*: cint
    res_x*: cuint
    res_y*: cuint
    paletteQuantizationMethod*: cint
    paletteQuantizationSpeed*: cint
    paletteQuantizationMinQuality*: cint
    paletteQuantizationMaxQuality*: cint
    interpolation_id*: gdInterpolationMethod
    interpolation*: interpolation_method

  gdImagePtr* = ptr gdImage

  GDFontError* = object of Exception
  GDRegularPolygonError* = object of Exception


type
  gdPoint* {.bycopy.} = object
    x*: cint
    y*: cint

  gdPointPtr* = ptr gdPoint

  gdFont* {.bycopy.} = object
    nchars*: cint
    offset*: cint
    w*: cint
    h*: cint
    data*: cstring

  gdFontPtr* = ptr gdFont



type
  gdFlipDirection* = enum
    GD_FLIP_HORIZONTAL, GD_FLIP_VERTICAL, GD_FLIP_BOTH

  gdFileExtension* = enum
    GD_PNG, GD_JPEG, GD_GIF, GD_BMP

proc gdImageCreate(sx: cint; sy: cint): gdImagePtr {.cdecl, importc: "gdImageCreate", dynlib: "libgd.so".}
const
  gdImageCreatePalette* = gdImageCreate
proc gdImageCreateTrueColor*(sx: cint; sy: cint): gdImagePtr {.cdecl, importc: "gdImageCreateTrueColor", dynlib: "libgd.so".}

proc gdImageDestroy*(im: gdImagePtr) {.cdecl, importc: "gdImageDestroy", dynlib: "libgd.so".}


proc gdImageColorAllocate(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorAllocate", dynlib: "libgd.so".}
proc gdImageColorAllocateAlpha(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorAllocateAlpha", dynlib: "libgd.so".}
proc gdImageColorClosest*(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorClosest", dynlib: "libgd.so".}
proc gdImageColorClosestAlpha*(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorClosestAlpha", dynlib: "libgd.so".}
proc gdImageColorClosestHWB*(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorClosestHWB", dynlib: "libgd.so".}
proc gdImageColorExact*(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorExact", dynlib: "libgd.so".}
proc gdImageColorExactAlpha*(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorExactAlpha", dynlib: "libgd.so".}
proc gdImageColorResolve*(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorResolve", dynlib: "libgd.so".}
proc gdImageColorResolveAlpha*(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorResolveAlpha", dynlib: "libgd.so".}



proc gdImageSetPixel(im: gdImagePtr; x: cint; y: cint; color: cint) {.cdecl, importc: "gdImageSetPixel", dynlib: "libgd.so".}
proc gdImageGetPixel*(im: gdImagePtr; x: cint; y: cint): cint {.cdecl, importc: "gdImageGetPixel", dynlib: "libgd.so".}
proc gdImageGetTrueColorPixel*(im: gdImagePtr; x: cint; y: cint): cint {.cdecl, importc: "gdImageGetTrueColorPixel", dynlib: "libgd.so".}
proc gdImageAABlend*(im: gdImagePtr) {.cdecl, importc: "gdImageAABlend", dynlib: "libgd.so".}


proc gdImageLine(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageLine", dynlib: "libgd.so".}
proc gdImageDashedLine(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageDashedLine", dynlib: "libgd.so".}
proc gdImageRectangle(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageRectangle", dynlib: "libgd.so".}
proc gdImageFilledRectangle(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageFilledRectangle", dynlib: "libgd.so".}
proc gdImageSetClip*(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint) {.cdecl, importc: "gdImageSetClip", dynlib: "libgd.so".}
proc gdImageGetClip*(im: gdImagePtr; x1P: ptr cint; y1P: ptr cint; x2P: ptr cint; y2P: ptr cint) {.cdecl, importc: "gdImageGetClip", dynlib: "libgd.so".}
proc gdImageSetResolution*(im: gdImagePtr; res_x: cuint; res_y: cuint) {.cdecl, importc: "gdImageSetResolution", dynlib: "libgd.so".}
proc gdImageBoundsSafe*(im: gdImagePtr; x: cint; y: cint): cint {.cdecl, importc: "gdImageBoundsSafe", dynlib: "libgd.so".}


proc gdImageFilledArc(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; s: cint; e: cint; color: cint; style: cint) {.cdecl, importc: "gdImageFilledArc", dynlib: "libgd.so".}
proc gdImageArc(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; s: cint; e: cint; color: cint) {.cdecl, importc: "gdImageArc", dynlib: "libgd.so".}
proc gdImageEllipse(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; color: cint) {.cdecl, importc: "gdImageEllipse", dynlib: "libgd.so".}
proc gdImageFilledEllipse(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; color: cint) {.cdecl, importc: "gdImageFilledEllipse", dynlib: "libgd.so".}
proc gdImageFillToBorder*(im: gdImagePtr; x: cint; y: cint; border: cint; color: cint) {.cdecl, importc: "gdImageFillToBorder", dynlib: "libgd.so".}
proc gdImageFill*(im: gdImagePtr; x: cint; y: cint; color: cint) {.cdecl, importc: "gdImageFill", dynlib: "libgd.so".}
proc gdImageCopy*(dst: gdImagePtr; src: gdImagePtr; dstX: cint; dstY: cint; srcX: cint; srcY: cint; w: cint; h: cint) {.cdecl, importc: "gdImageCopy", dynlib: "libgd.so".}
proc gdImageCopyMerge*(dst: gdImagePtr; src: gdImagePtr; dstX: cint; dstY: cint; srcX: cint; srcY: cint; w: cint; h: cint; pct: cint) {.cdecl, importc: "gdImageCopyMerge", dynlib: "libgd.so".}
proc gdImageCopyMergeGray*(dst: gdImagePtr; src: gdImagePtr; dstX: cint; dstY: cint; srcX: cint; srcY: cint; w: cint; h: cint; pct: cint) {.cdecl, importc: "gdImageCopyMergeGray", dynlib: "libgd.so".}


proc gdImagePolygon(im: gdImagePtr; p: gdPointPtr; n: cint; c: cint) {.cdecl, importc: "gdImagePolygon", dynlib: "libgd.so".}
proc gdImageOpenPolygon(im: gdImagePtr; p: gdPointPtr; n: cint; c: cint) {.cdecl, importc: "gdImageOpenPolygon", dynlib: "libgd.so".}
proc gdImageFilledPolygon(im: gdImagePtr; p: gdPointPtr; n: cint; c: cint) {.cdecl, importc: "gdImageFilledPolygon", dynlib: "libgd.so".}

proc gdImageGif(im: gdImagePtr; output: ptr FILE) {.cdecl, importc: "gdImageGif", dynlib: "libgd.so".}
proc gdImagePng(im: gdImagePtr; output: ptr FILE) {.cdecl, importc: "gdImagePng", dynlib: "libgd.so".}
proc gdImageTiff*(im: gdImagePtr; output: ptr FILE) {.cdecl, importc: "gdImageTiff", dynlib: "libgd.so".}
proc gdImageJpeg(im: gdImagePtr; output: ptr FILE; quality: cint) {.cdecl, importc: "gdImageJpeg", dynlib: "libgd.so".}
proc gdImageWebpEx*(im: gdImagePtr; outFile: ptr FILE; quantization: cint) {.cdecl, importc: "gdImageWebpEx", dynlib: "libgd.so".}
proc gdImageWebp*(im: gdImagePtr; outFile: ptr FILE) {.cdecl, importc: "gdImageWebp", dynlib: "libgd.so".}

proc gdImageFlipHorizontal(im: gdImagePtr) {.cdecl, importc: "gdImageFlipHorizontal", dynlib: "libgd.so".}
proc gdImageFlipVertical(im: gdImagePtr) {.cdecl, importc: "gdImageFlipVertical", dynlib: "libgd.so".}
proc gdImageFlipBoth(im: gdImagePtr) {.cdecl, importc: "gdImageFlipBoth", dynlib: "libgd.so".}


proc gdImageChar(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; c: cint; color: cint) {.cdecl, importc: "gdImageChar", dynlib: "libgd.so".}
proc gdImageCharUp(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; c: cint; color: cint) {.cdecl, importc: "gdImageCharUp", dynlib: "libgd.so".}
proc gdImageString(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; s: ptr cuchar; color: cint) {.cdecl, importc: "gdImageString", dynlib: "libgd.so".}
proc gdImageStringUp(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; s: ptr cuchar; color: cint) {.cdecl, importc: "gdImageStringUp", dynlib: "libgd.so".}

proc gdFontGetSmall*(): gdFontPtr {.cdecl, importc: "gdFontGetSmall", dynlib: "libgd.so".}
proc gdFontGetLarge*(): gdFontPtr {.cdecl, importc: "gdFontGetSmall", dynlib: "libgd.so".}
proc gdFontGetMediumBold*(): gdFontPtr {.cdecl, importc: "gdFontGetSmall", dynlib: "libgd.so".}


proc gdImageSetThickness(im: gdImagePtr; thickness: cint) {.cdecl, importc: "gdImageSetThickness", dynlib: "libgd.so".}


proc gdImageSetAntiAliased*(im: gdImagePtr; c: cint) {.cdecl, importc: "gdImageSetAntiAliased", dynlib: "libgd.so".}
proc gdImageSetAntiAliasedDontBlend*(im: gdImagePtr; c: cint; dont_blend: cint) {.cdecl, importc: "gdImageSetAntiAliasedDontBlend", dynlib: "libgd.so".}

proc gdFontCacheSetup*(): cint {.cdecl, importc: "gdFontCacheSetup", dynlib: "libgd.so".}
proc gdFontCacheShutdown*() {.cdecl, importc: "gdFontCacheShutdown", dynlib: "libgd.so".}
proc gdFreeFontCache*() {.cdecl, importc: "gdFreeFontCache", dynlib: "libgd.so".}

proc gdImageStringTTF*(im: ptr gdImage; brect: ptr cint; fg: cint; fontlist: cstring; ptsize: cdouble; angle: cdouble; x: cint; y: cint; s: cstring): cstring {.cdecl, importc: "gdImageStringTTF", dynlib: "libgd.so".}
proc gdImageStringFT(im: ptr gdImage; brect: ptr cint; fg: cint; fontlist: cstring; ptsize: cdouble; angle: cdouble; x: cint; y: cint; s: cstring): cstring {.cdecl, importc: "gdImageStringFT", dynlib: "libgd.so".}


proc gdImageContrast*(src: gdImagePtr; contrast: cdouble): cint {.cdecl, importc: "gdImageContrast", dynlib: "libgd.so".}
proc gdImageBrightness*(src: gdImagePtr; brightness: cint): cint {.cdecl, importc: "gdImageBrightness", dynlib: "libgd.so".}
proc gdImageGrayScale*(src: gdImagePtr): cint {.cdecl, importc: "gdImageGrayScale", dynlib: "libgd.so".}
proc gdImageNegate*(src: gdImagePtr): cint {.cdecl, importc: "gdImageNegate", dynlib: "libgd.so".}

proc gdImageScale(src: gdImagePtr; new_width: cuint; new_height: cuint): gdImagePtr {.cdecl, importc: "gdImageScale", dynlib: "libgd.so".}


proc gdImageCreateFromPng(fd: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromPng", dynlib: "libgd.so".}
proc gdImageCreateFromJpeg(infile: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromJpeg", dynlib: "libgd.so".}
proc gdImageCreateFromGif(fd: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromGif", dynlib: "libgd.so".}
proc gdImageCreateFromBmp(inFile: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromBmp", dynlib: "libgd.so".}
proc gdImageCreateFromFile(filename: cstring): gdImagePtr {.cdecl, importc: "gdImageCreateFromFile", dynlib: "libgd.so".}

    
#--- Nim Interface ---

template withGd*(img: untyped, width: int, height: int, body: untyped): typed =
  block gd:
    let img = gdImageCreate(cast[cint](width), cast[cint](height))
    body
    img.gdImageDestroy()


template withGd*(img: untyped, fd: File, content_type: gdFileExtension = GD_PNG, body: untyped): typed =
  block gd:
    let img = case content_type:
      of GD_JPEG:
        gdImageCreateFromJpeg(cast[ptr File](fd))
      of GD_GIF:
        gdImageCreateFromGif(cast[ptr File](fd))
      of GD_BMP:
        gdImageCreateFromBmp(cast[ptr File](fd))
      else:
        gdImageCreateFromPng(cast[ptr File](fd))
    body
    img.gdImageDestroy()


proc gd_create*(width: int, height: int): gdImagePtr = gdImageCreate(cast[cint](width), cast[cint](height))
proc gd_destroy*(im: gdImagePtr) = im.gdImageDestroy()


proc gd_write*(im: gdImagePtr, output: File, content_type: gdFileExtension, quality: int = -1) =
  case content_type:
    of GD_GIF:
      im.gdImageGif(cast[ptr FILE](output))
    of GD_JPEG:
      im.gdImageJpeg(cast[ptr FILE](output), cast[cint](quality))
    else:
      im.gdImagePng(cast[ptr FILE](output))


proc gd_create_from*(fd: FILE, content_type: gdFileExtension = GD_PNG): gdImagePtr =
  case content_type:
    of GD_JPEG:
      gdImageCreateFromJpeg(cast[ptr File](fd))
    of GD_GIF:
      gdImageCreateFromGif(cast[ptr File](fd))
    of GD_BMP:
      gdImageCreateFromBmp(cast[ptr File](fd))
    else:
      gdImageCreateFromPng(cast[ptr File](fd))

proc gd_create_from_file*(filename: string): gdImagePtr = gdImageCreateFromFile(cast[cstring](filename))


proc gd_color*(im: gdImagePtr, r: int, g: int, b: int): int = cast[int](im.gdImageColorAllocate(cast[cint](r), cast[cint](g), cast[cint](b)))
proc gd_color*(im: gdImagePtr, r: int, g: int, b: int, a: int): int = im.gdImageColorAllocateAlpha(cast[cint](r), cast[cint](g), cast[cint](b), cast[cint](a))
proc gd_color*(im: gdImagePtr, hexcolor: string): int =
  if hexcolor[0] == '#':
    if hexcolor.len == 7:
      var r = 0; discard parseHex("0x$1" % hexcolor[1..2], r)
      var g = 0; discard parseHex("0x$1" % hexcolor[3..4], g)
      var b = 0; discard parseHex("0x$1" % hexcolor[5..6], b)
      return cast[int](im.gdImageColorAllocate(cast[cint](r), cast[cint](g), cast[cint](b)))
    if hexcolor.len == 9:
      var r = 0; discard parseHex("0x$1" % hexcolor[1..2], r)
      var g = 0; discard parseHex("0x$1" % hexcolor[3..4], g)
      var b = 0; discard parseHex("0x$1" % hexcolor[5..6], b)
      var a = 0; discard parseHex("0x$1" % hexcolor[7..8], a)
      return cast[int](im.gdImageColorAllocateAlpha(cast[cint](r), cast[cint](g), cast[cint](b), cast[cint](a)))
  return 0

template gd_background_color*(args: varargs[untyped]): untyped = gd_color(args)
template gd_foreground_color*(args: varargs[untyped]): untyped = gd_color(args)


proc gd_set_pixel*(im: gdImagePtr, point: array[2,int], color: int = -1) =
  im.gdImageSetPixel(cast[cint](point[0]), cast[cint](point[1]), cast[cint](color))


proc gd_line*(im: gdImagePtr, start_point: array[2,int], end_point: array[2,int], color: int = -1, dashed: bool = false) =
  if dashed:
    im.gdImageDashedLine(cast[cint](start_point[0]), cast[cint](start_point[1]), cast[cint](end_point[0]), cast[cint](end_point[1]), cast[cint](color))
  else:
    im.gdImageLine(cast[cint](start_point[0]), cast[cint](start_point[1]), cast[cint](end_point[0]), cast[cint](end_point[1]), cast[cint](color))


proc gd_rectangle*(im: gdImagePtr, start_corner: array[2,int], end_corner: array[2,int], color: int, fill: bool = false) =
  if fill:
    im.gdImageFilledRectangle(cast[cint](start_corner[0]), cast[cint](start_corner[1]), cast[cint](end_corner[0]), cast[cint](end_corner[1]), cast[cint](color))
  else:
    im.gdImageRectangle(cast[cint](start_corner[0]), cast[cint](start_corner[1]), cast[cint](end_corner[0]), cast[cint](end_corner[1]), cast[cint](color))


proc gd_arc*(im: gdImagePtr, center:  array[2,int], axis: array[2,int], angles: array[2,int], color: int, fill: bool = false, style: int = 0) =
  if fill:
    im.gdImageFilledArc(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](angles[0]), cast[cint](angles[1]), cast[cint](color), cast[cint](style))
  else:
    im.gdImageArc(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](angles[0]), cast[cint](angles[1]), cast[cint](color))


proc gd_ellipse*(im: gdImagePtr, center: array[2,int], axis: array[2,int], color: int, fill: bool = false) =
  if fill:
    im.gdImageFilledEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](color))
  else:
    im.gdImageEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](color))


proc gd_circle*(im: gdImagePtr, center: array[2,int], radius: int, color: int = -1, fill: bool = false) =
  if fill:
    im.gdImageFilledEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](radius), cast[cint](radius), cast[cint](color))
  else:
    im.gdImageEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](radius), cast[cint](radius), cast[cint](color))


proc gd_polygon*(im: gdImagePtr, points: openArray[array[0..1, int]], color: int, fill: bool = false, open: bool = false) =
  var pts: seq[gdPoint]
  for idx, point in points:
    var p: gdPoint
    p.x = cast[cint](point[0])
    p.y = cast[cint](point[1])
    pts.add(p)
      
  if fill:
    im.gdImageFilledPolygon(cast[gdPointPtr](addr pts[0]), cast[cint](pts.len), cast[cint](color))
  elif open:
    im.gdImageOpenPolygon(cast[gdPointPtr](addr pts[0]), cast[cint](pts.len), cast[cint](color))
  else:
    im.gdImagePolygon(cast[gdPointPtr](addr pts[0]), cast[cint](pts.len), cast[cint](color))


proc gd_regular_polygon*(im: gdImagePtr, center: array[2,int], sides: int, radius: int, start_angle: int = 0, color: int, fill: bool = false, open: bool = false) =

  if sides < 3:
    raise newException(GDRegularPolygonError, "The number of sides can not be less than 3")

  proc calc_position(x: int, y: int, radius: int, pos_angle: float): (cint, cint) =
    var width = int(radius.float * sin(degToRad(pos_angle)))
    var height = int(radius.float * cos(degToRad(pos_angle)))
    return (cast[cint](x + width), cast[cint](y - height))

  let spacing_angle = 360 / sides
  var pos_angle: float = (90 - start_angle).float
  var n = 0
  var bag = newSeq[gdPoint](sides)
  while n < sides:
    (bag[n].x, bag[n].y) = calc_position(center[0], center[1], radius, pos_angle)
    n += 1
    pos_angle -= spacing_angle

  if fill:
    im.gdImageFilledPolygon(cast[gdPointPtr](addr bag[0]), cast[cint](bag.len), cast[cint](color))
  elif open:
    im.gdImageOpenPolygon(cast[gdPointPtr](addr bag[0]), cast[cint](bag.len), cast[cint](color))
  else:
    im.gdImagePolygon(cast[gdPointPtr](addr bag[0]), cast[cint](bag.len), cast[cint](color))




proc gd_flip*(im: gdImagePtr, direction: gdFlipDirection) =
  if ord(direction) == 0:
    im.gdImageFlipHorizontal()
  if ord(direction) == 1:
    im.gdImageFlipVertical()
  if ord(direction) == 2:
    im.gdImageFlipBoth()

proc gd_string*(im: gdImagePtr, font: gdFontPtr, position: array[2, int], text: string, color: int = 1, up=false) =
  if up:
    im.gdImageStringUp(font, cast[cint](position[0]), cast[cint](position[1]), cast[ptr cuchar](text.cstring), cast[cint](color))
  else:
    im.gdImageString(font, cast[cint](position[0]), cast[cint](position[1]), cast[ptr cuchar](text.cstring), cast[cint](color))


proc gd_character*(im: gdImagePtr, font: gdFontPtr, position: array[2, int], character: char; color: int = 1, up: bool = false) =
  if up:
    im.gdImageCharUp(font, cast[cint](position[0]), cast[cint](position[1]), cast[cint](character), cast[cint](color))
  else:
    im.gdImageChar(font, cast[cint](position[0]), cast[cint](position[1]), cast[cint](character), cast[cint](color))


proc gd_string_ft*(im: gdImagePtr, color: int, fontList: string, size: float, angle: float, position: array[2, int], text: string) =
  var brect: array[8, cint];
  var cp = gdImageStringFT(cast[ptr gdImage](im), cast[ptr cint](addr brect[0]), cast[cint](color), fontList.cstring, cast[cdouble](size), cast[cdouble](angle), cast[cint](position[0]), cast[cint](position[1]), text.cstring)
  if cp.len > 0:
    raise newException(GDFontError, $cp)

proc gd_set_thickness*(im: gdImagePtr, thickness: int) = im.gdImageSetThickness(cast[cint](thickness))

proc gd_set_anti_aliased*(im: gdImagePtr, color: int) = im.gdImageSetAntiAliased(cast[cint](color))

proc gd_scale*(src: gdImagePtr; new_width: cuint; new_height: cuint): gdImagePtr = src.gdImageScale(cast[cuint](new_width), cast[cuint](new_height))



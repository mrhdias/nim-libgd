#
# Copyright (C) 2021 Henrique Dias
# MIT License - Look at LICENSE for details.
# nim-libgd package is an interface to the GD library written by
# Thomas Bouttel.
#

from math import sin, cos, degToRad, `mod`
import strutils
import macros
from strutils import `%`

when defined(windows): 
  const 
    gdlib* = "libgd.dll"
elif defined(macosx): 
  const 
    gdlib* = "libgd.dylib"
else: 
  const 
    gdlib* = "libgd.so"

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
  gdFileExtension* = enum
    PNG, JPEG, GIF, BMP

  gdFlipDirection* = enum
    HORIZONTAL, VERTICAL, BOTH

  gdColorMethod* = enum
    ALLOCATE, CLOSEST, CLOSEST_HWB, EXACT, RESOLVE



proc gdImageCreate(sx: cint; sy: cint): gdImagePtr {.cdecl, importc: "gdImageCreate", dynlib: gdlib.}

const
  gdImageCreatePalette* = gdImageCreate
proc gdImageCreateTrueColor*(sx: cint; sy: cint): gdImagePtr {.cdecl, importc: "gdImageCreateTrueColor", dynlib: gdlib.}

proc gdImageDestroy*(im: gdImagePtr) {.cdecl, importc: "gdImageDestroy", dynlib: gdlib.}


proc gdImageColorAllocate(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorAllocate", dynlib: gdlib.}
proc gdImageColorAllocateAlpha(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorAllocateAlpha", dynlib: gdlib.}
proc gdImageColorClosest(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorClosest", dynlib: gdlib.}
proc gdImageColorClosestAlpha(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorClosestAlpha", dynlib: gdlib.}
proc gdImageColorClosestHWB(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorClosestHWB", dynlib: gdlib.}
proc gdImageColorExact(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorExact", dynlib: gdlib.}
proc gdImageColorExactAlpha(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorExactAlpha", dynlib: gdlib.}
proc gdImageColorResolve(im: gdImagePtr; r: cint; g: cint; b: cint): cint {.cdecl, importc: "gdImageColorResolve", dynlib: gdlib.}
proc gdImageColorResolveAlpha(im: gdImagePtr; r: cint; g: cint; b: cint; a: cint): cint {.cdecl, importc: "gdImageColorResolveAlpha", dynlib: gdlib.}

proc gdImageColorTransparent(im: gdImagePtr; color: cint) {.cdecl, importc: "gdImageColorTransparent", dynlib: gdlib.}

proc gdImageSetPixel(im: gdImagePtr; x: cint; y: cint; color: cint) {.cdecl, importc: "gdImageSetPixel", dynlib: gdlib.}
proc gdImageGetPixel*(im: gdImagePtr; x: cint; y: cint): cint {.cdecl, importc: "gdImageGetPixel", dynlib: gdlib.}
proc gdImageGetTrueColorPixel*(im: gdImagePtr; x: cint; y: cint): cint {.cdecl, importc: "gdImageGetTrueColorPixel", dynlib: gdlib.}
proc gdImageAABlend*(im: gdImagePtr) {.cdecl, importc: "gdImageAABlend", dynlib: gdlib.}


proc gdImageLine(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageLine", dynlib: gdlib.}
proc gdImageDashedLine(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageDashedLine", dynlib: gdlib.}
proc gdImageRectangle(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageRectangle", dynlib: gdlib.}
proc gdImageFilledRectangle(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint; color: cint) {.cdecl, importc: "gdImageFilledRectangle", dynlib: gdlib.}
proc gdImageSetClip*(im: gdImagePtr; x1: cint; y1: cint; x2: cint; y2: cint) {.cdecl, importc: "gdImageSetClip", dynlib: gdlib.}
proc gdImageGetClip*(im: gdImagePtr; x1P: ptr cint; y1P: ptr cint; x2P: ptr cint; y2P: ptr cint) {.cdecl, importc: "gdImageGetClip", dynlib: gdlib.}
proc gdImageSetResolution*(im: gdImagePtr; res_x: cuint; res_y: cuint) {.cdecl, importc: "gdImageSetResolution", dynlib: gdlib.}
proc gdImageBoundsSafe*(im: gdImagePtr; x: cint; y: cint): cint {.cdecl, importc: "gdImageBoundsSafe", dynlib: gdlib.}


proc gdImageFilledArc(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; s: cint; e: cint; color: cint; style: cint) {.cdecl, importc: "gdImageFilledArc", dynlib: gdlib.}
proc gdImageArc(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; s: cint; e: cint; color: cint) {.cdecl, importc: "gdImageArc", dynlib: gdlib.}
proc gdImageEllipse(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; color: cint) {.cdecl, importc: "gdImageEllipse", dynlib: gdlib.}
proc gdImageFilledEllipse(im: gdImagePtr; cx: cint; cy: cint; w: cint; h: cint; color: cint) {.cdecl, importc: "gdImageFilledEllipse", dynlib: gdlib.}
proc gdImageFillToBorder*(im: gdImagePtr; x: cint; y: cint; border: cint; color: cint) {.cdecl, importc: "gdImageFillToBorder", dynlib: gdlib.}
proc gdImageFill(im: gdImagePtr; x: cint; y: cint; color: cint) {.cdecl, importc: "gdImageFill", dynlib: gdlib.}
proc gdImageCopy*(dst: gdImagePtr; src: gdImagePtr; dstX: cint; dstY: cint; srcX: cint; srcY: cint; w: cint; h: cint) {.cdecl, importc: "gdImageCopy", dynlib: gdlib.}
proc gdImageCopyMerge*(dst: gdImagePtr; src: gdImagePtr; dstX: cint; dstY: cint; srcX: cint; srcY: cint; w: cint; h: cint; pct: cint) {.cdecl, importc: "gdImageCopyMerge", dynlib: gdlib.}
proc gdImageCopyMergeGray*(dst: gdImagePtr; src: gdImagePtr; dstX: cint; dstY: cint; srcX: cint; srcY: cint; w: cint; h: cint; pct: cint) {.cdecl, importc: "gdImageCopyMergeGray", dynlib: gdlib.}


proc gdImagePolygon(im: gdImagePtr; p: gdPointPtr; n: cint; c: cint) {.cdecl, importc: "gdImagePolygon", dynlib: gdlib.}
proc gdImageOpenPolygon(im: gdImagePtr; p: gdPointPtr; n: cint; c: cint) {.cdecl, importc: "gdImageOpenPolygon", dynlib: gdlib.}
proc gdImageFilledPolygon(im: gdImagePtr; p: gdPointPtr; n: cint; c: cint) {.cdecl, importc: "gdImageFilledPolygon", dynlib: gdlib.}

proc gdImageGif(im: gdImagePtr; output: ptr FILE) {.cdecl, importc: "gdImageGif", dynlib: gdlib.}
proc gdImagePng(im: gdImagePtr; output: ptr FILE) {.cdecl, importc: "gdImagePng", dynlib: gdlib.}
proc gdImageTiff*(im: gdImagePtr; output: ptr FILE) {.cdecl, importc: "gdImageTiff", dynlib: gdlib.}
proc gdImageJpeg(im: gdImagePtr; output: ptr FILE; quality: cint) {.cdecl, importc: "gdImageJpeg", dynlib: gdlib.}
proc gdImageWebpEx*(im: gdImagePtr; outFile: ptr FILE; quantization: cint) {.cdecl, importc: "gdImageWebpEx", dynlib: gdlib.}
proc gdImageWebp*(im: gdImagePtr; outFile: ptr FILE) {.cdecl, importc: "gdImageWebp", dynlib: gdlib.}

proc gdImageFlipHorizontal(im: gdImagePtr) {.cdecl, importc: "gdImageFlipHorizontal", dynlib: gdlib.}
proc gdImageFlipVertical(im: gdImagePtr) {.cdecl, importc: "gdImageFlipVertical", dynlib: gdlib.}
proc gdImageFlipBoth(im: gdImagePtr) {.cdecl, importc: "gdImageFlipBoth", dynlib: gdlib.}


proc gdImageChar(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; c: cint; color: cint) {.cdecl, importc: "gdImageChar", dynlib: gdlib.}
proc gdImageCharUp(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; c: cint; color: cint) {.cdecl, importc: "gdImageCharUp", dynlib: gdlib.}
proc gdImageString(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; s: ptr cuchar; color: cint) {.cdecl, importc: "gdImageString", dynlib: gdlib.}
proc gdImageStringUp(im: gdImagePtr; f: gdFontPtr; x: cint; y: cint; s: ptr cuchar; color: cint) {.cdecl, importc: "gdImageStringUp", dynlib: gdlib.}

proc gdFontGetSmall*(): gdFontPtr {.cdecl, importc: "gdFontGetSmall", dynlib: gdlib.}
proc gdFontGetLarge*(): gdFontPtr {.cdecl, importc: "gdFontGetSmall", dynlib: gdlib.}
proc gdFontGetMediumBold*(): gdFontPtr {.cdecl, importc: "gdFontGetSmall", dynlib: gdlib.}


proc gdImageSetThickness(im: gdImagePtr; thickness: cint) {.cdecl, importc: "gdImageSetThickness", dynlib: gdlib.}


proc gdImageSetAntiAliased*(im: gdImagePtr; c: cint) {.cdecl, importc: "gdImageSetAntiAliased", dynlib: gdlib.}
proc gdImageSetAntiAliasedDontBlend*(im: gdImagePtr; c: cint; dont_blend: cint) {.cdecl, importc: "gdImageSetAntiAliasedDontBlend", dynlib: gdlib.}

proc gdFontCacheSetup*(): cint {.cdecl, importc: "gdFontCacheSetup", dynlib: gdlib.}
proc gdFontCacheShutdown*() {.cdecl, importc: "gdFontCacheShutdown", dynlib: gdlib.}
proc gdFreeFontCache*() {.cdecl, importc: "gdFreeFontCache", dynlib: gdlib.}

proc gdImageStringTTF*(im: ptr gdImage; brect: ptr cint; fg: cint; fontlist: cstring; ptsize: cdouble; angle: cdouble; x: cint; y: cint; s: cstring): cstring {.cdecl, importc: "gdImageStringTTF", dynlib: gdlib.}
proc gdImageStringFT(im: ptr gdImage; brect: ptr cint; fg: cint; fontlist: cstring; ptsize: cdouble; angle: cdouble; x: cint; y: cint; s: cstring): cstring {.cdecl, importc: "gdImageStringFT", dynlib: gdlib.}


# https://libgd.github.io/manuals/2.2.4/files/gd_filter-c.html
proc gdImageContrast(src: gdImagePtr; contrast: cdouble): cint {.cdecl, importc: "gdImageContrast", dynlib: gdlib.}
proc gdImageBrightness(src: gdImagePtr; brightness: cint): cint {.cdecl, importc: "gdImageBrightness", dynlib: gdlib.}
proc gdImageGrayScale(src: gdImagePtr): cint {.cdecl, importc: "gdImageGrayScale", dynlib: gdlib.}
proc gdImageNegate(src: gdImagePtr): cint {.cdecl, importc: "gdImageNegate", dynlib: gdlib.}
proc gdImageEmboss(src: gdImagePtr): cint {.cdecl, importc: "gdImageEmboss", dynlib: gdlib.}
proc gdImageGaussianBlur(im: gdImagePtr): cint {.cdecl, importc: "gdImageGaussianBlur", dynlib: gdlib.}
proc gdImageSmooth(im: gdImagePtr, weight: float): cint {.cdecl, importc: "gdImageSmooth", dynlib: gdlib.}
proc gdImageEdgeDetectQuick(src: gdImagePtr): cint {.cdecl, importc: "gdImageEdgeDetectQuick", dynlib: gdlib.}
proc gdImageSelectiveBlur(src: gdImagePtr): cint {.cdecl, importc: "gdImageSelectiveBlur", dynlib: gdlib.}
proc gdImageMeanRemoval(im: gdImagePtr): cint {.cdecl, importc: "gdImageMeanRemoval", dynlib: gdlib.}


proc gdImageScale(src: gdImagePtr; new_width: cuint; new_height: cuint): gdImagePtr {.cdecl, importc: "gdImageScale", dynlib: gdlib.}

proc gdImageCreateFromPng(fd: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromPng", dynlib: gdlib.}
proc gdImageCreateFromJpeg(infile: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromJpeg", dynlib: gdlib.}
proc gdImageCreateFromGif(fd: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromGif", dynlib: gdlib.}
proc gdImageCreateFromBmp(inFile: ptr FILE): gdImagePtr {.cdecl, importc: "gdImageCreateFromBmp", dynlib: gdlib.}
proc gdImageCreateFromFile(filename: cstring): gdImagePtr {.cdecl, importc: "gdImageCreateFromFile", dynlib: gdlib.}

    
#--- Nim Interface ---

# https://forum.nim-lang.org/t/3205
macro withGd*(args, body: untyped): untyped =
  if args.kind != nnkInfix or args.len != 3 or not eqIdent(args[0], "as"):
    error "'(value) as (name)' expected in withGd, found: '$1'" % [args.repr]

  let varValue = args[1]
  let varName = args[2]

  template withGdImpl(name, value, body) =
    block:
      let name = value
      try:
        body
      finally:
        # echo "Destroy"
        name.gdImageDestroy()

  getAst(withGdImpl(varName, varValue, body))


proc image_create*(width: int, height: int, true_color: bool = false): gdImagePtr =
  if true_color: gdImageCreateTrueColor(cast[cint](width), cast[cint](height)) else: gdImageCreate(cast[cint](width), cast[cint](height))

proc image_create_from*(fd: File, content_type: gdFileExtension = PNG): gdImagePtr =
  case content_type:
    of JPEG:
      gdImageCreateFromJpeg(cast[ptr File](fd))
    of GIF:
      gdImageCreateFromGif(cast[ptr File](fd))
    of BMP:
      gdImageCreateFromBmp(cast[ptr File](fd))
    else:
      gdImageCreateFromPng(cast[ptr File](fd))


proc image_destroy*(im: gdImagePtr) = im.gdImageDestroy()


proc write_gif*(im: gdImagePtr, output: File) = im.gdImageGif(cast[ptr FILE](output))
proc write_jpeg*(im: gdImagePtr, output: File, quality: int = -1) = im.gdImageJpeg(cast[ptr FILE](output), cast[cint](quality))
proc write_png*(im: gdImagePtr, output: File) = im.gdImagePng(cast[ptr FILE](output))


proc create_image_from*(fd: FILE, content_type: gdFileExtension = PNG): gdImagePtr =
  case content_type:
    of JPEG:
      gdImageCreateFromJpeg(cast[ptr File](fd))
    of GIF:
      gdImageCreateFromGif(cast[ptr File](fd))
    of BMP:
      gdImageCreateFromBmp(cast[ptr File](fd))
    else:
      gdImageCreateFromPng(cast[ptr File](fd))

proc gd_create_from_file*(filename: string): gdImagePtr = gdImageCreateFromFile(cast[cstring](filename))

proc image_size*(src: gdImagePtr): (int, int) = (cast[int](src.sx), cast[int](src.sy))

proc set_color*(im: gdImagePtr, r: int, g: int, b: int, color_method: gdColorMethod = ALLOCATE): int =
  case color_method:
    of CLOSEST:
      cast[int](im.gdImageColorClosest(cast[cint](r), cast[cint](g), cast[cint](b)))
    of CLOSEST_HWB:
      cast[int](im.gdImageColorClosestHWB(cast[cint](r), cast[cint](g), cast[cint](b)))      
    of EXACT:
      cast[int](im.gdImageColorExact(cast[cint](r), cast[cint](g), cast[cint](b)))
    of RESOLVE:
      cast[int](im.gdImageColorResolve(cast[cint](r), cast[cint](g), cast[cint](b)))
    else:
      cast[int](im.gdImageColorAllocate(cast[cint](r), cast[cint](g), cast[cint](b)))

proc set_color*(im: gdImagePtr, r: int, g: int, b: int, a: int, color_method: gdColorMethod = ALLOCATE): int =
  case color_method:
    of CLOSEST:
      cast[int](im.gdImageColorClosestAlpha(cast[cint](r), cast[cint](g), cast[cint](b), cast[cint](a)))
    of EXACT:
      cast[int](im.gdImageColorExactAlpha(cast[cint](r), cast[cint](g), cast[cint](b), cast[cint](a)))
    of RESOLVE:
      cast[int](im.gdImageColorResolveAlpha(cast[cint](r), cast[cint](g), cast[cint](b), cast[cint](a)))
    else:
      cast[int](im.gdImageColorAllocateAlpha(cast[cint](r), cast[cint](g), cast[cint](b), cast[cint](a)))


proc set_color*(im: gdImagePtr, hex_color: int64, color_method: gdColorMethod = ALLOCATE): int =
  # c = 256^2 * r + 256 * g + b;
  # c = 256^3 * r + 256^2 * g + 256 * b + a;
  if hex_color > 16777215:
    let r = (hex_color.float / (256 * 256 * 256)).int
    let g = (hex_color.float / (256 * 256) mod 256).int
    let b = ((hex_color.float / 256) mod 256).int
    let a = (hex_color.float mod 256).int
    return im.set_color(r, g, b, a, color_method)

  let r = (hex_color.float / (256 * 256)).int
  let g = ((hex_color.float / 256) mod 256).int
  let b = (hex_color.float mod 256).int
  return im.set_color(r, g, b, color_method)


template background_color*(args: varargs[untyped]): untyped = set_color(args)
template foreground_color*(args: varargs[untyped]): untyped = set_color(args)


# https://www.php.net/manual/en/ref.image.php
proc color_transparent*(im: gdImagePtr, color: int) = im.gdImageColorTransparent(cast[cint](color))
proc image_fill*(im: gdImagePtr, start_point: array[2,int], color: int = -1) = im.gdImageFill(cast[cint](start_point[0]), cast[cint](start_point[1]), cast[cint](color))

# Begin Drawing Functions

proc set_pixel*(im: gdImagePtr, point: array[2,int], color: int = -1) = im.gdImageSetPixel(cast[cint](point[0]), cast[cint](point[1]), cast[cint](color))


proc draw_line*(im: gdImagePtr, start_point: array[2,int], end_point: array[2,int], color: int = -1, dashed: bool = false) =
  if dashed:
    im.gdImageDashedLine(cast[cint](start_point[0]), cast[cint](start_point[1]), cast[cint](end_point[0]), cast[cint](end_point[1]), cast[cint](color))
  else:
    im.gdImageLine(cast[cint](start_point[0]), cast[cint](start_point[1]), cast[cint](end_point[0]), cast[cint](end_point[1]), cast[cint](color))


proc draw_rectangle*(im: gdImagePtr, start_corner: array[2,int], end_corner: array[2,int], color: int = -1, fill: bool = false) =
  if fill:
    im.gdImageFilledRectangle(cast[cint](start_corner[0]), cast[cint](start_corner[1]), cast[cint](end_corner[0]), cast[cint](end_corner[1]), cast[cint](color))
  else:
    im.gdImageRectangle(cast[cint](start_corner[0]), cast[cint](start_corner[1]), cast[cint](end_corner[0]), cast[cint](end_corner[1]), cast[cint](color))


proc draw_arc*(im: gdImagePtr, center:  array[2,int], axis: array[2,int], angles: array[2,int], color: int, fill: bool = false, style: int = 0) =
  if fill:
    im.gdImageFilledArc(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](angles[0]), cast[cint](angles[1]), cast[cint](color), cast[cint](style))
  else:
    im.gdImageArc(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](angles[0]), cast[cint](angles[1]), cast[cint](color))


proc draw_ellipse*(im: gdImagePtr, center: array[2,int], axis: array[2,int], color: int, fill: bool = false) =
  if fill:
    im.gdImageFilledEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](color))
  else:
    im.gdImageEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](axis[0]), cast[cint](axis[1]), cast[cint](color))


proc draw_circle*(im: gdImagePtr, center: array[2,int], radius: int, color: int = -1, fill: bool = false) =
  if fill:
    im.gdImageFilledEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](radius), cast[cint](radius), cast[cint](color))
  else:
    im.gdImageEllipse(cast[cint](center[0]), cast[cint](center[1]), cast[cint](radius), cast[cint](radius), cast[cint](color))


proc draw_polygon*(im: gdImagePtr, points: openArray[array[0..1, int]], color: int, fill: bool = false, open: bool = false) =
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


proc draw_regular_polygon*(im: gdImagePtr, center: array[2,int], sides: int, radius: int, start_angle: int = 0, color: int, fill: bool = false, open: bool = false) =

  if sides < 3:
    raise newException(ValueError, "The number of sides can not be less than 3")

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

# End Drawing Functions


proc draw_string*(im: gdImagePtr, font: gdFontPtr, position: array[2, int], text: string, color: int = 1, up=false) =
  if up:
    im.gdImageStringUp(font, cast[cint](position[0]), cast[cint](position[1]), cast[ptr cuchar](text.cstring), cast[cint](color))
  else:
    im.gdImageString(font, cast[cint](position[0]), cast[cint](position[1]), cast[ptr cuchar](text.cstring), cast[cint](color))


proc draw_character*(im: gdImagePtr, font: gdFontPtr, position: array[2, int], character: char; color: int = 1, up: bool = false) =
  if up:
    im.gdImageCharUp(font, cast[cint](position[0]), cast[cint](position[1]), cast[cint](character), cast[cint](color))
  else:
    im.gdImageChar(font, cast[cint](position[0]), cast[cint](position[1]), cast[cint](character), cast[cint](color))


proc draw_string_ft*(im: gdImagePtr, color: int, fontList: string, size: float, angle: float, position: array[2, int], text: string) =
  var brect: array[8, cint];
  let cp = gdImageStringFT(cast[ptr gdImage](im), cast[ptr cint](addr brect[0]), cast[cint](color), fontList.cstring, cast[cdouble](size), cast[cdouble](angle), cast[cint](position[0]), cast[cint](position[1]), text.cstring)
  if cp.len > 0:
    raise newException(CatchableError, $cp)

proc set_thickness*(im: gdImagePtr, thickness: int) = im.gdImageSetThickness(cast[cint](thickness))

proc set_anti_aliased*(im: gdImagePtr, color: int) = im.gdImageSetAntiAliased(cast[cint](color))

proc image_scale*(src: gdImagePtr, percentage: float): gdImagePtr = src.gdImageScale(cast[cuint](int(src.sx.float * percentage/100)), cast[cuint](int(src.sy.float * percentage/100)))
proc image_scale*(src: gdImagePtr, new_width: int, new_height: int): gdImagePtr = src.gdImageScale(cast[cuint](new_width), cast[cuint](new_height))

proc image_flip*(im: gdImagePtr, direction: gdFlipDirection) =
  if ord(direction) == 0:
    im.gdImageFlipHorizontal()
  if ord(direction) == 1:
    im.gdImageFlipVertical()
  if ord(direction) == 2:
    im.gdImageFlipBoth()

# Begin Image Filters

proc filter_contrast*(src: gdImagePtr, contrast: float): bool =
  if src.gdImageContrast(cast[cdouble](contrast)) == 0: false else: true
proc filter_brightness*(src: gdImagePtr, brightness: int): bool = 
  if src.gdImageBrightness(cast[cint](brightness)) == 0: false else: true
proc filter_gray_scale*(src: gdImagePtr): bool =
  if cast[cint](src.gdImageGrayScale()) == 0: false else: true
proc filter_negate*(src: gdImagePtr): bool =
  if cast[cint](src.gdImageNegate()) == 0: false else: true
proc filter_emboss*(src: gdImagePtr): bool =
  if cast[cint](src.gdImageEmboss()) == 0: false else: true
proc filter_gaussian_blur*(im: gdImagePtr): bool =
  if cast[cint](im.gdImageGaussianBlur()) == 0: false else: true
proc filter_smooth*(im: gdImagePtr, weight: float): bool =
  if cast[cint](im.gdImageSmooth(weight)) == 0: false else: true
proc filter_edge_detect_quick*(src: gdImagePtr): bool =
  if cast[cint](src.gdImageEdgeDetectQuick()) == 0: false else: true
proc filter_selective_blur*(src: gdImagePtr): bool =
  if cast[cint](src.gdImageSelectiveBlur()) == 0: false else: true
proc filter_mean_removal*(src: gdImagePtr): bool =
  if cast[cint](src.gdImageMeanRemoval()) == 0: false else: true

# End Image Filters

//
//  AnchoredSpritePlugIn.h
//  AnchoredSprite
//
//  Created by Koichi MATSUMOTO on 2014/11/09.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// Constant definitions

// ブレンドモード
#define BLEND_Func_Replace()    glBlendFunc(GL_ONE, GL_ZERO)
#define BLEND_Func_Over()       glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
#define BLEND_Func_Add()        glBlendFunc(GL_ONE, GL_ONE)
#define BLEND_Func_AddAlpha()   glBlendFunc(GL_SRC_ALPHA, GL_ONE)
#define BLEND_Func_Alpha()      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
#define BLEND_Func_Multi()      glBlendFunc(GL_ZERO, GL_SRC_COLOR)
#define BLEND_Func_Invert()     glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ZERO)
#define BLEND_Func_Screen()     glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE)
#define BLEND_Func_XOR()        glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE_MINUS_SRC_COLOR)

#define BLEND_NAME_REPLACE  @"置換"
#define BLEND_NAME_OVER     @"上書き"
#define BLEND_NAME_ADD      @"加算合成 (αなし)"
#define BLEND_NAME_ADDALPHA @"加算合成 (αあり)"
#define BLEND_NAME_ALPHA    @"アルファブレンド"
#define BLEND_NAME_MULTI    @"乗算合成"
#define BLEND_NAME_INVERT   @"反転合成"
#define BLEND_NAME_SCREEN   @"スクリーン合成"
#define BLEND_NAME_XOR      @"排他的論理和合成"

enum BlendMode {
    ClrBlendMode_Replace = 0,
    ClrBlendMode_Over,
    ClrBlendMode_Add,
    ClrBlendMode_AddAlpha,
    ClrBlendMode_Alpha,
    ClrBlendMode_Multi,
    ClrBlendMode_Invert,
    ClrBlendMode_Screen,
    ClrBlendMode_Xor,
    NumOfBlendMode
};

// キー値、名称、デフォルト値
#define PKEY_INPUTIMAGE     @"inputImage"
#define PKEY_INPUTANCHORX   @"inputAnchorX"
#define PKEY_INPUTANCHORY   @"inputAnchorY"
#define PKEY_INPUTANCHORZ   @"inputAnchorZ"
#define PKEY_INPUTDISTX     @"inputDistX"
#define PKEY_INPUTDISTY     @"inputDistY"
#define PKEY_INPUTDISTZ     @"inputDistZ"
#define PKEY_INPUTXAXIS     @"inputXAxis"
#define PKEY_INPUTYAXIS     @"inputYAxis"
#define PKEY_INPUTZAXIS     @"inputZAxis"
#define PKEY_INPUTXANGLE    @"inputXAngle"
#define PKEY_INPUTYANGLE    @"inputYAngle"
#define PKEY_INPUTZANGLE    @"inputZAngle"
#define PKEY_INPUTXSCALE    @"inputXScale"
#define PKEY_INPUTYSCALE    @"inputYScale"
#define PKEY_INPUTZSCALE    @"inputZScale"
#define PKEY_INPUTCOLOR     @"inputColor"
#define PKEY_INPUTBLENDMOD  @"inputBlendMode"

#define PNAME_INPUTIMAGE    @"Image"
#define PNAME_INPUTANCHORX  @"Anchor X"
#define PNAME_INPUTANCHORY  @"Anchor Y"
#define PNAME_INPUTANCHORZ  @"Anchor Z"
#define PNAME_INPUTDISTX    @"X Distance"
#define PNAME_INPUTDISTY    @"Y Distance"
#define PNAME_INPUTDISTZ    @"Z Distance"
#define PNAME_INPUTXAXIS    @"X Axis"
#define PNAME_INPUTYAXIS    @"Y Axis"
#define PNAME_INPUTZAXIS    @"Z Axis"
#define PNAME_INPUTXANGLE   @"X Rotation"
#define PNAME_INPUTYANGLE   @"Y Rotation"
#define PNAME_INPUTZANGLE   @"Z Rotation"
#define PNAME_INPUTXSCALE   @"X Scale"
#define PNAME_INPUTYSCALE   @"Y Scale"
#define PNAME_INPUTZSCALE   @"Z Scale"
#define PNAME_INPUTCOLOR    @"Color"
#define PNAME_INPUTBLENDMOD @"Blend Mode"

#define PDEF_INPUTANCHORX   0.0f
#define PDEF_INPUTANCHORY   0.0f
#define PDEF_INPUTANCHORZ   0.0f
#define PDEF_INPUTDISTX     0.0f
#define PDEF_INPUTDISTY     0.0f
#define PDEF_INPUTDISTZ     0.0f
#define PDEF_INPUTXAXIS     0.0f
#define PDEF_INPUTYAXIS     0.0f
#define PDEF_INPUTZAXIS     0.0f
#define PDEF_INPUTXANGLE    0.0f
#define PDEF_INPUTYANGLE    0.0f
#define PDEF_INPUTZANGLE    0.0f
#define PDEF_INPUTXSCALE    1.0f
#define PDEF_INPUTYSCALE    1.0f
#define PDEF_INPUTZSCALE    1.0f
#define PDEF_INPUTCOLOR     CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTBLENDMOD  ClrBlendMode_Over
#define PMAX_INPUTBLENDMOD  (NumOfBlendMode - 1)
#define PMIN_INPUTXAXIS     -180.0f
#define PMIN_INPUTYAXIS     -180.0f
#define PMIN_INPUTZAXIS     -180.0f
#define PMAX_INPUTXAXIS     180.0f
#define PMAX_INPUTYAXIS     180.0f
#define PMAX_INPUTZAXIS     180.0f

@interface AnchoredSpritePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
// Declare a property input port of type Image with the key inputImage
@property(assign) id<QCPlugInInputImageSource> inputImage;
//@property (copy) NSString* outputBar;
@property (assign) double inputAnchorX;
@property (assign) double inputAnchorY;
@property (assign) double inputAnchorZ;
@property (assign) double inputDistX;
@property (assign) double inputDistY;
@property (assign) double inputDistZ;
@property (assign) double inputXAxis;
@property (assign) double inputYAxis;
@property (assign) double inputZAxis;
@property (assign) double inputXAngle;
@property (assign) double inputYAngle;
@property (assign) double inputZAngle;
@property (assign) double inputXScale;
@property (assign) double inputYScale;
@property (assign) double inputZScale;
@property (assign) CGColorRef inputColor;
@property (assign) NSUInteger inputBlendMode;

@end

//
//  AnchoredSpritePlugIn.h
//  AnchoredSprite
//
//  Created by 松本 光一 on 2014/11/09.
//  Copyright (c) 2014年 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// Constant definitions

// ブレンドモード
#define BLEND_NAME_DEFAULT  @"デフォルト"
#define BLEND_NAME_ALPHA    @"アルファブレンド"
#define BLEND_NAME_ADD      @"加算合成"
#define BLEND_NAME_MULTI    @"乗算合成"
#define BLEND_NAME_INVERT   @"反転合成"
#define BLEND_NAME_SCREEN   @"スクリーン合成"
#define BLEND_NAME_XOR      @"排他的論理和合成"

enum BlendMode {
    ClrBlendMode_Default = 0,
    ClrBlendMode_Alpha,
    ClrBlendMode_Add,
    ClrBlendMode_Multi,
    ClrBlendMode_Invert,
    ClrBlendMode_Screen,
    ClrBlendMode_Xor,
    NumOfBlendMode
};

// ブレンディング
#define BLENDING_REPLACE    @"Replace"
#define BLENDING_OVER       @"Over"
#define BLENDING_ADD        @"Add"

enum Blending {
    Blending_Replace = 0,
    Blending_Øver,
    Blending_Add,
    NumOfBlending
};
#define PDEF_BLENDING      Blending_Øver
#define PMAX_BLENDING      (NumOfBlending - 1)
// Depth Test
#define DEPTHTEST_NONE      @"None"
#define DEPTHTEST_RW        @"Read/Write"
#define DEPTHTEST_RO        @"Read Only"
enum DepthTest {
    None = 0,
    ReadWrite,
    ReadØnly,
    NumOfDepthTest
};
#define PDEF_DEPTHTEST      ReadWrite
#define PMAX_DEPTHTEST      (NumOfDepthTest - 1)

// Face Culling
#define CULLING_NONE        @"None"
#define CULLING_FRONT       @"Front Face"
#define CULLING_BACK        @"Back Face"
enum FaceCUlling {
    NoFace = 0,
    BackFace,
    FrontFåce,
    NumOfFaceCulling
};
#define PDEF_FACECULLING    NoFace
#define PMAX_FACECULLING    (NumOfFaceCulling - 1)

// キー値、名称、デフォルト値
#define PKEY_INPUTIMAGE     @"inputImage"
#define PKEY_INPUTANCHORX   @"inputAnchorX"
#define PKEY_INPUTANCHORY   @"inputAnchorY"
#define PKEY_INPUTANCHORZ   @"inputAnchorZ"
#define PKEY_INPUTDISTX     @"inputDistX"
#define PKEY_INPUTDISTY     @"inputDistY"
#define PKEY_INPUTDISTZ     @"inputDistZ"
#define PKEY_INPUTXANGLE    @"inputXAngle"
#define PKEY_INPUTYANGLE    @"inputYAngle"
#define PKEY_INPUTZANGLE    @"inputZAngle"
#define PKEY_INPUTXSCALE    @"inputXScale"
#define PKEY_INPUTYSCALE    @"inputYScale"
#define PKEY_INPUTZSCALE    @"inputZScale"
#define PKEY_INPUTCOLOR     @"inputColor"
#define PKEY_INPUTBLENDMOD  @"inputBlendMode"
#define PKEY_INPUTDEPTHTEST @"inputDepthTest"
#define PKEY_INPUTCULLING   @"inputCulling"

#define PNAME_INPUTIMAGE    @"Image"
#define PNAME_INPUTANCHORX  @"Anchor X"
#define PNAME_INPUTANCHORY  @"Anchor Y"
#define PNAME_INPUTANCHORZ  @"Anchor Z"
#define PNAME_INPUTDISTX    @"X Distance"
#define PNAME_INPUTDISTY    @"Y Distance"
#define PNAME_INPUTDISTZ    @"Z Distance"
#define PNAME_INPUTXANGLE   @"X Rotation"
#define PNAME_INPUTYANGLE   @"Y Rotation"
#define PNAME_INPUTZANGLE   @"Z Rotation"
#define PNAME_INPUTXSCALE   @"X Scale"
#define PNAME_INPUTYSCALE   @"Y Scale"
#define PNAME_INPUTZSCALE   @"Z Scale"
#define PNAME_INPUTCOLOR    @"Color"
#define PNAME_INPUTBLENDMOD @"Blend Mode"
#define PNAME_INPUTDEPTHTEST @"Depth Testing"
#define PNAME_INPUTCULLING   @"Face Culling"

#define PDEF_INPUTANCHORX   0.0f
#define PDEF_INPUTANCHORY   0.0f
#define PDEF_INPUTANCHORZ   0.0f
#define PDEF_INPUTDISTX     0.0f
#define PDEF_INPUTDISTY     0.0f
#define PDEF_INPUTDISTZ     0.0f
#define PDEF_INPUTXANGLE    0.0f
#define PDEF_INPUTYANGLE    0.0f
#define PDEF_INPUTZANGLE    0.0f
#define PDEF_INPUTXSCALE    1.0f
#define PDEF_INPUTYSCALE    1.0f
#define PDEF_INPUTZSCALE    1.0f
#define PDEF_INPUTCOLOR     CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTBLENDMOD  ClrBlendMode_Default
#define PMAX_INPUTBLENDMOD  (NumOfBlendMode - 1)

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
@property (assign) double inputXAngle;
@property (assign) double inputYAngle;
@property (assign) double inputZAngle;
@property (assign) double inputXScale;
@property (assign) double inputYScale;
@property (assign) double inputZScale;
@property (assign) CGColorRef inputColor;
@property (assign) NSUInteger inputBlendMode;
/* special control ports. */
@property (assign) NSUInteger inputDepthTest;
@property (assign) NSUInteger inputCulling;

@end

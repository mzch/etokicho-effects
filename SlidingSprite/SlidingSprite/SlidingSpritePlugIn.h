//
//  SlidingSpritePlugIn.h
//  SlidingSprite
//
//  Created by Koichi MATSUMOTO on 2014/12/17.
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
#define PKEY_INPUTIMAGE         @"inputImage"
#define PKEY_INPUTANCHORX       @"inputAnchorX"
#define PKEY_INPUTANCHORY       @"inputAnchorY"
#define PKEY_INPUTXPOSSTART     @"inputXPosStart"
#define PKEY_INPUTYPOSSTART     @"inputYPosStart"
#define PKEY_INPUTZPOSSTART     @"inputZPosStart"
#define PKEY_INPUTXPOSEND       @"inputXPosEnd"
#define PKEY_INPUTYPOSEND       @"inputYPosEnd"
#define PKEY_INPUTZPOSEND       @"inputZPosEnd"
#define PKEY_INPUTSTARTTIME     @"inputStartTime"
#define PKEY_INPUTENDTIME       @"inputEndTime"
#define PKEY_INPUTCOLORSTART    @"inputColorStart"
#define PKEY_INPUTCOLOREND      @"inputColorEnd"
#define PKEY_INPUTFADESTARTTIME  @"inputFadeStartTime"
#define PKEY_INPUTFADEENDTIME   @"inputFadeEndTime"
#define PKEY_INPUTXSCALESTART   @"inputXScaleStart"
#define PKEY_INPUTYSCALESTART   @"inputYScaleStart"
#define PKEY_INPUTZSCALESTART   @"inputZScaleStart"
#define PKEY_INPUTXSCALEEND     @"inputXScaleEnd"
#define PKEY_INPUTYSCALEEND     @"inputYScaleEnd"
#define PKEY_INPUTZSCALEEND     @"inputZScaleEnd"
#define PKEY_INPUTSCALESTARTTIME @"inputScaleStartTime"
#define PKEY_INPUTSCALEENDTIME  @"inputScaleEndTime"
#define PKEY_INPUTXAXIS         @"inputXAxis"
#define PKEY_INPUTYAXIS         @"inputYAxis"
#define PKEY_INPUTZAXIS         @"inputZAxis"
#define PKEY_INPUTXANGLESTART   @"inputXAngleStart"
#define PKEY_INPUTYANGLESTART   @"inputYAngleStart"
#define PKEY_INPUTZANGLESTART   @"inputZAngleStart"
#define PKEY_INPUTISXSPIN       @"inputIsXSpin"
#define PKEY_INPUTISYSPIN       @"inputIsYSpin"
#define PKEY_INPUTISZSPIN       @"inputIsZSpin"
#define PKEY_INPUTXANGLEEND     @"inputXAngleEnd"
#define PKEY_INPUTYANGLEEND     @"inputYAngleEnd"
#define PKEY_INPUTZANGLEEND     @"inputZAngleEnd"
#define PKEY_INPUTSPINSTARTTIME @"inputSpinStartTime"
#define PKEY_INPUTSPINENDTIME   @"inputSpinEndTime"
#define PKEY_INPUTTIME          @"inputTime"
#define PKEY_INPUTBLENDMOD      @"inputBlendMode"

#define PNAME_INPUTIMAGE        @"Image"
#define PNAME_INPUTANCHORX      @"Image Anchor X"
#define PNAME_INPUTANCHORY      @"Image Anchor Y"
#define PNAME_INPUTXPOSSTART    @"X Position Start"
#define PNAME_INPUTYPOSSTART    @"Y Position Start"
#define PNAME_INPUTZPOSSTART    @"Z Position Start"
#define PNAME_INPUTXPOSEND      @"X Position End"
#define PNAME_INPUTYPOSEND      @"Y Position End"
#define PNAME_INPUTZPOSEND      @"Z Position End"
#define PNAME_INPUTSTARTTIME    @"Start Time"
#define PNAME_INPUTENDTIME      @"End Time"
#define PNAME_INPUTCOLORSTART   @"Color Start"
#define PNAME_INPUTCOLOREND     @"Color End"
#define PNAME_INPUTFADESTARTTIME @"Fade Start Time"
#define PNAME_INPUTFADEENDTIME  @"Fade End Time"
#define PNAME_INPUTXSCALESTART  @"X Scale Start"
#define PNAME_INPUTYSCALESTART  @"Y Scale Start"
#define PNAME_INPUTZSCALESTART  @"Z Scale Start"
#define PNAME_INPUTXSCALEEND    @"X Scale End"
#define PNAME_INPUTYSCALEEND    @"Y Scale End"
#define PNAME_INPUTZSCALEEND    @"Z Scale End"
#define PNAME_INPUTSCALESTARTTIME @"Scale Start Time"
#define PNAME_INPUTSCALEENDTIME  @"Scale End Time"
#define PNAME_INPUTXAXIS        @"X Axis"
#define PNAME_INPUTYAXIS        @"Y Axis"
#define PNAME_INPUTZAXIS        @"Z Axis"
#define PNAME_INPUTXANGLESTART  @"X Rotation Start"
#define PNAME_INPUTYANGLESTART  @"Y Rotation Start"
#define PNAME_INPUTZANGLESTART  @"Z Rotation Start"
#define PNAME_INPUTISXSPIN      @"Is X Spin"
#define PNAME_INPUTISYSPIN      @"Is Y Spin"
#define PNAME_INPUTISZSPIN      @"Is Z Spin"
#define PNAME_INPUTXANGLEEND    @"X Rotation End"
#define PNAME_INPUTYANGLEEND    @"Y Rotation End"
#define PNAME_INPUTZANGLEEND    @"Z Rotation End"
#define PNAME_INPUTSPINSTARTTIME @"Spin Start Time"
#define PNAME_INPUTSPINENDTIME   @"Spin End Time"
#define PNAME_INPUTTIME         @"Time"
#define PNAME_INPUTBLENDMOD     @"Blend Mode"

#define PDEF_INPUTANCHORX     0.0f
#define PDEF_INPUTANCHORY     0.0f
#define PDEF_INPUTXPOSITION   0.0f
#define PDEF_INPUTYPOSITION   0.0f
#define PDEF_INPUTZPOSITION   0.0f
#define PDEF_INPUTXAXIS       0.0f
#define PDEF_INPUTYAXIS       0.0f
#define PDEF_INPUTZAXIS       0.0f
#define PDEF_INPUTXANGLE      0.0f
#define PDEF_INPUTYANGLE      0.0f
#define PDEF_INPUTZANGLE      0.0f
#define PDEF_INPUTXSCALE      1.0f
#define PDEF_INPUTYSCALE      1.0f
#define PDEF_INPUTZSCALE      1.0f
#define PMIN_INPUTSCALE       0.0f
#define PDEF_INPUTCOLOR       CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTBLENDMOD    ClrBlendMode_Over
#define PMAX_INPUTBLENDMOD    (NumOfBlendMode - 1)
#define PMIN_INPUTXAXIS       -180.0f
#define PMIN_INPUTYAXIS       -180.0f
#define PMIN_INPUTZAXIS       -180.0f
#define PMAX_INPUTXAXIS       180.0f
#define PMAX_INPUTYAXIS       180.0f
#define PMAX_INPUTZAXIS       180.0f
#define PDEF_INPUTISXSPIN     NO
#define PDEF_INPUTISYSPIN     NO
#define PDEF_INPUTISZSPIN     NO
#define PDEF_INPUTTIME        0.0f
#define PDEF_INPUTSETIME      0

@interface SlidingSpritePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
@property(assign) id<QCPlugInInputImageSource> inputImage;
@property (assign) double     inputAnchorX;
@property (assign) double     inputAnchorY;
@property (assign) double     inputXPosStart;
@property (assign) double     inputYPosStart;
@property (assign) double     inputZPosStart;
@property (assign) double     inputXPosEnd;
@property (assign) double     inputYPosEnd;
@property (assign) double     inputZPosEnd;
@property (assign) NSUInteger inputStartTime;
@property (assign) NSUInteger inputEndTime;
@property (assign) CGColorRef inputColorStart;
@property (assign) CGColorRef inputColorEnd;
@property (assign) NSUInteger inputFadeStartTime;
@property (assign) NSUInteger inputFadeEndTime;
@property (assign) double     inputXScaleStart;
@property (assign) double     inputYScaleStart;
@property (assign) double     inputZScaleStart;
@property (assign) double     inputXScaleEnd;
@property (assign) double     inputYScaleEnd;
@property (assign) double     inputZScaleEnd;
@property (assign) NSUInteger inputScaleStartTime;
@property (assign) NSUInteger inputScaleEndTime;
@property (assign) double     inputXAxis;
@property (assign) double     inputYAxis;
@property (assign) double     inputZAxis;
@property (assign) double     inputXAngleStart;
@property (assign) double     inputYAngleStart;
@property (assign) double     inputZAngleStart;
@property (assign) BOOL       inputIsXSpin;
@property (assign) BOOL       inputIsYSpin;
@property (assign) BOOL       inputIsZSpin;
@property (assign) double     inputXAngleEnd;
@property (assign) double     inputYAngleEnd;
@property (assign) double     inputZAngleEnd;
@property (assign) NSUInteger inputSpinStartTime;
@property (assign) NSUInteger inputSpinEndTime;
@property (assign) double     inputTime;
@property (assign) NSUInteger inputBlendMode;

@property (assign) double     X_distance;
@property (assign) double     Y_distance;
@property (assign) double     Z_distance;
@property (assign) double     X_rotation;
@property (assign) double     Y_rotation;
@property (assign) double     Z_rotation;
@property (assign) double     X_scale;
@property (assign) double     Y_scale;
@property (assign) double     Z_scale;
@property (assign) CGFloat    Red;
@property (assign) CGFloat    Green;
@property (assign) CGFloat    Blue;
@property (assign) CGFloat    Alpha;

@end

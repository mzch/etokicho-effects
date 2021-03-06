//
//  Sliding_SpritePlugIn.h
//  Sliding Sprite
//
//  Created by Koichi MATSUMOTO on 2014/12/30.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// Type definitions
typedef struct
{
    GLdouble x;
    GLdouble y;
    GLdouble z;
}
SSProgress;

typedef struct
{
    GLdouble x;
    GLdouble y;
    GLdouble z;
    BOOL     is;
}
SSDistance;

// Constant definitions
#define PERCENTAGE              100.0f
#define MILISECPERSEC           1000.0f

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

#define OPT_NAME_CONSTANT       @"等速"
#define OPT_NAME_ACCELARATE     @"加速"
#define OPT_NAME_DECELARATE     @"減速"

enum SlideOpt {
    Slide_Constant = 0,         // 等速
    Slide_Accelarate,           // 加速
    Slide_Decelarate,           // 減速
    NumOfSlideOpt
};

#define FADE_NAME_CONST         @"一定"
#define FADE_NAME_LOG           @"対数的"
#define FADE_NAME_EXP           @"指数的"

enum FadeOpt {
    Fade_Constant = 0,          // 一定
    Fade_Log,                   // 対数的
    Fade_Exp,                   // 指数的
    NumOfFadeOpt
};

#define JUMP_NAME_ARC           @"ぴょんぴょん"
#define JUMP_NAME_MIRROR        @"コツコツ"
#define JUMP_NAME_QUAD          @"タメあり"
#define JUMP_NAME_FLIGHT        @"逆タメあり"

enum JumpOpt {
    Jump_Arc = 0,
    Jump_Mirror,
    Jump_Quad,
    Jump_Flight,
    NumOfJumpOpt
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
#define PKEY_INPUTXOPTION       @"inputXOption"
#define PKEY_INPUTYOPTION       @"inputYOption"
#define PKEY_INPUTZOPTION       @"inputZOption"
#define PKEY_INPUTCOLOR1        @"inputColor1"
#define PKEY_INPUTCOLOR2        @"inputColor2"
#define PKEY_INPUTCOLOR3        @"inputColor3"
#define PKEY_INPUTFADEINSTART   @"inputFadeInStart"
#define PKEY_INPUTFADEINEND     @"inputFadeInEnd"
#define PKEY_INPUTFADEINOPT     @"inputFadeInOpt"
#define PKEY_INPUTFADEOUTSTART  @"inputFadeOutStart"
#define PKEY_INPUTFADEOUTEND    @"inputFadeOutEnd"
#define PKEY_INPUTFADEOUTOPT    @"inputFadeOutOpt"
#define PKEY_INPUTXSCALESTART   @"inputXScaleStart"
#define PKEY_INPUTYSCALESTART   @"inputYScaleStart"
#define PKEY_INPUTZSCALESTART   @"inputZScaleStart"
#define PKEY_INPUTXSCALEEND     @"inputXScaleEnd"
#define PKEY_INPUTYSCALEEND     @"inputYScaleEnd"
#define PKEY_INPUTZSCALEEND     @"inputZScaleEnd"
#define PKEY_INPUTSCALESTARTTIME @"inputScaleStartTime"
#define PKEY_INPUTSCALEENDTIME  @"inputScaleEndTime"
#define PKEY_INPUTBOUNCE        @"inputBounce"
#define PKEY_INPUTXLEAD         @"inputXLead"
#define PKEY_INPUTYLEAD         @"inputYLead"
#define PKEY_INPUTZLEAD         @"inputZLead"
#define PKEY_INPUTJUMPSTARTTIME @"inputJumpStartTime"
#define PKEY_INPUTJUMPENDTIME   @"inputJumpEndTime"
#define PKEY_INPUTJUMPOPT       @"inputJumpStyle"
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
#define PNAME_INPUTANCHORX      @"Anchor X"
#define PNAME_INPUTANCHORY      @"Anchor Y"
#define PNAME_INPUTXPOSSTART    @"X Start Pos"
#define PNAME_INPUTYPOSSTART    @"Y Start Pos"
#define PNAME_INPUTZPOSSTART    @"Z Start Pos"
#define PNAME_INPUTXPOSEND      @"X End Pos"
#define PNAME_INPUTYPOSEND      @"Y End Pos"
#define PNAME_INPUTZPOSEND      @"Z End Pos"
#define PNAME_INPUTSTARTTIME    @"Start Time"
#define PNAME_INPUTENDTIME      @"End Time"
#define PNAME_INPUTXOPTION      @"X Option"
#define PNAME_INPUTYOPTION      @"Y Option"
#define PNAME_INPUTZOPTION      @"Z Option"
#define PNAME_INPUTCOLOR1       @"Color #1"
#define PNAME_INPUTCOLOR2       @"Color #2"
#define PNAME_INPUTCOLOR3       @"Color #3"
#define PNAME_INPUTFADEINSTART  @"Fade In Start"
#define PNAME_INPUTFADEINEND    @"Fade In End"
#define PNAME_INPUTFADEINOPT    @"Fade In Opt"
#define PNAME_INPUTFADEOUTSTART @"Fade Out Start"
#define PNAME_INPUTFADEOUTEND   @"Fade Out End"
#define PNAME_INPUTFADEOUTOPT   @"Fade Out Opt"
#define PNAME_INPUTXSCALESTART  @"X Start Scale"
#define PNAME_INPUTYSCALESTART  @"Y Start Scale"
#define PNAME_INPUTZSCALESTART  @"Z Start Scale"
#define PNAME_INPUTXSCALEEND    @"X End Scale"
#define PNAME_INPUTYSCALEEND    @"Y End Scale"
#define PNAME_INPUTZSCALEEND    @"Z End Scale"
#define PNAME_INPUTSCALESTARTTIME @"Scale Start"
#define PNAME_INPUTSCALEENDTIME  @"Scale End"
#define PNAME_INPUTBOUNCE       @"Bounce"
#define PNAME_INPUTXLEAD        @"X Lead"
#define PNAME_INPUTYLEAD        @"Y Lead"
#define PNAME_INPUTZLEAD        @"Z Lead"
#define PNAME_INPUTJUMPSTARTTIME @"Jump Start"
#define PNAME_INPUTJUMPENDTIME   @"Jump End"
#define PNAME_INPUTJUMPOPT      @"Jump Style"
#define PNAME_INPUTXAXIS        @"X Axis"
#define PNAME_INPUTYAXIS        @"Y Axis"
#define PNAME_INPUTZAXIS        @"Z Axis"
#define PNAME_INPUTXANGLESTART  @"X Degree"
#define PNAME_INPUTYANGLESTART  @"Y Degree"
#define PNAME_INPUTZANGLESTART  @"Z Degree"
#define PNAME_INPUTISXSPIN      @"Is X Spin"
#define PNAME_INPUTISYSPIN      @"Is Y Spin"
#define PNAME_INPUTISZSPIN      @"Is Z Spin"
#define PNAME_INPUTXANGLEEND    @"X End Degree"
#define PNAME_INPUTYANGLEEND    @"Y End Degree"
#define PNAME_INPUTZANGLEEND    @"Z End Degree"
#define PNAME_INPUTSPINSTARTTIME @"Spin Start"
#define PNAME_INPUTSPINENDTIME   @"Spin End"
#define PNAME_INPUTTIME         @"Time"
#define PNAME_INPUTBLENDMOD     @"Blend Mode"

#define PDEF_INPUTANCHORX     0.0f
#define PDEF_INPUTANCHORY     0.0f
#define PDEF_INPUTXPOSITION   0.0f
#define PDEF_INPUTYPOSITION   0.0f
#define PDEF_INPUTZPOSITION   0.0f
#define PDEF_INPUTOPTION      Slide_Constant
#define PMAX_INPUTOPTION      (NumOfSlideOpt - 1)
#define PDEF_INPUTXAXIS       0.0f
#define PDEF_INPUTYAXIS       0.0f
#define PDEF_INPUTZAXIS       0.0f
#define PDEF_INPUTXANGLE      0.0f
#define PDEF_INPUTYANGLE      0.0f
#define PDEF_INPUTZANGLE      0.0f
#define PDEF_INPUTXSCALE      100.0f
#define PDEF_INPUTYSCALE      100.0f
#define PDEF_INPUTZSCALE      100.0f
#define PMIN_INPUTSCALE       0.0f
#define PDEF_INPUTCOLOR       CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTFADEOPT     Fade_Constant
#define PMAX_INPUTFADEOPT     (NumOfFadeOpt - 1)
#define PDEF_INPUTJUMPOPT     Jump_Arc
#define PMAX_INPUTJUMPOPT     (NumOfJumpOpt - 1)
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
#define PDEF_INPUTBOUNCE      0
#define PDEF_INPUTLEAD        0.0f
#define PDEF_INPUTTIME        0.0f
#define PDEF_INPUTSETIME      0

@interface Sliding_SpritePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
@property(assign) id<QCPlugInInputImageSource> inputImage;
@property (assign) double     inputAnchorX;
@property (assign) double     inputAnchorY;
@property (assign) double     inputXPosStart;
@property (assign) double     inputXPosEnd;
@property (assign) NSUInteger inputXOption;
@property (assign) double     inputYPosStart;
@property (assign) double     inputYPosEnd;
@property (assign) NSUInteger inputYOption;
@property (assign) double     inputZPosStart;
@property (assign) double     inputZPosEnd;
@property (assign) NSUInteger inputZOption;
@property (assign) NSUInteger inputStartTime;
@property (assign) NSUInteger inputEndTime;
@property (assign) CGColorRef inputColor1;
@property (assign) CGColorRef inputColor2;
@property (assign) CGColorRef inputColor3;
@property (assign) NSUInteger inputFadeInStart;
@property (assign) NSUInteger inputFadeInEnd;
@property (assign) NSUInteger inputFadeInOpt;
@property (assign) NSUInteger inputFadeOutStart;
@property (assign) NSUInteger inputFadeOutEnd;
@property (assign) NSUInteger inputFadeOutOpt;
@property (assign) double     inputXScaleStart;
@property (assign) double     inputXScaleEnd;
@property (assign) double     inputYScaleStart;
@property (assign) double     inputYScaleEnd;
@property (assign) double     inputZScaleStart;
@property (assign) double     inputZScaleEnd;
@property (assign) NSUInteger inputScaleStartTime;
@property (assign) NSUInteger inputScaleEndTime;
@property (assign) NSUInteger inputBounce;
@property (assign) double     inputXLead;
@property (assign) double     inputYLead;
@property (assign) double     inputZLead;
@property (assign) NSUInteger inputJumpStartTime;
@property (assign) NSUInteger inputJumpEndTime;
@property (assign) NSUInteger inputJumpStyle;
@property (assign) double     inputXAxis;
@property (assign) double     inputYAxis;
@property (assign) double     inputZAxis;
@property (assign) double     inputXAngleStart;
@property (assign) BOOL       inputIsXSpin;
@property (assign) double     inputXAngleEnd;
@property (assign) double     inputYAngleStart;
@property (assign) BOOL       inputIsYSpin;
@property (assign) double     inputYAngleEnd;
@property (assign) double     inputZAngleStart;
@property (assign) BOOL       inputIsZSpin;
@property (assign) double     inputZAngleEnd;
@property (assign) NSUInteger inputSpinStartTime;
@property (assign) NSUInteger inputSpinEndTime;
@property (assign) double     inputTime;
@property (assign) NSUInteger inputBlendMode;

@property (assign) double     xAnchor;
@property (assign) double     yAnchor;
@property (assign) double     xPosStart;
@property (assign) double     yPosStart;
@property (assign) double     zPosStart;
@property (assign) double     xPosEnd;
@property (assign) double     yPosEnd;
@property (assign) double     zPosEnd;
@property (assign) double     xLeads;
@property (assign) double     yLeads;
@property (assign) double     zLeads;
@property (assign) double     X_distance;
@property (assign) double     Y_distance;
@property (assign) double     Z_distance;
@property (assign) double     X_rotation;
@property (assign) double     Y_rotation;
@property (assign) double     Z_rotation;
@property (assign) double     X_scale;
@property (assign) double     Y_scale;
@property (assign) double     Z_scale;
@property (assign) CGFloat    Red1;
@property (assign) CGFloat    Green1;
@property (assign) CGFloat    Blue1;
@property (assign) CGFloat    Alpha1;
@property (assign) CGFloat    Red2;
@property (assign) CGFloat    Green2;
@property (assign) CGFloat    Blue2;
@property (assign) CGFloat    Alpha2;
@property (assign) NSTimeInterval JumpDuration;
@property (assign) NSTimeInterval JumpDuration2;

@end

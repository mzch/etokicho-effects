//
//  FadePlugIn.h
//  Fade
//
//  Created by Koichi MATSUMOTO on 2015/01/01.
//  Copyright (c) 2015年 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

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

#define FADE_NAME_CONST         @"一定"
#define FADE_NAME_LOG           @"対数的"
#define FADE_NAME_EXP           @"指数的"

enum FadeOpt {
    Fade_Constant = 0,          // 一定
    Fade_Log,                   // 対数的
    Fade_Exp,                   // 指数的
    NumOfFadeOpt
};

#define PKEY_INPUTIMAGE         @"inputImage"
#define PKEY_INPUTCOLOR1        @"inputColor1"
#define PKEY_INPUTCOLOR2        @"inputColor2"
#define PKEY_INPUTCOLOR3        @"inputColor3"
#define PKEY_INPUTFADEINSTART   @"inputFadeInStart"
#define PKEY_INPUTFADEINEND     @"inputFadeInEnd"
#define PKEY_INPUTFADEINOPT     @"inputFadeInOpt"
#define PKEY_INPUTFADEOUTSTART  @"inputFadeOutStart"
#define PKEY_INPUTFADEOUTEND    @"inputFadeOutEnd"
#define PKEY_INPUTFADEOUTOPT    @"inputFadeOutOpt"
#define PKEY_INPUTTIME          @"inputTime"
#define PKEY_INPUTBLENDMOD      @"inputBlendMode"

#define PNAME_INPUTIMAGE        @"Image"
#define PNAME_INPUTCOLOR1       @"Color #1"
#define PNAME_INPUTCOLOR2       @"Color #2"
#define PNAME_INPUTCOLOR3       @"Color #3"
#define PNAME_INPUTFADEINSTART  @"Fade In Start"
#define PNAME_INPUTFADEINEND    @"Fade In End"
#define PNAME_INPUTFADEINOPT    @"Fade In Opt"
#define PNAME_INPUTFADEOUTSTART @"Fade Out Start"
#define PNAME_INPUTFADEOUTEND   @"Fade Out End"
#define PNAME_INPUTFADEOUTOPT   @"Fade Out Opt"
#define PNAME_INPUTTIME         @"Time"
#define PNAME_INPUTBLENDMOD     @"Blend Mode"

#define PDEF_INPUTCOLOR       CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTFADEOPT     Fade_Constant
#define PMAX_INPUTFADEOPT     (NumOfFadeOpt - 1)
#define PDEF_INPUTBLENDMOD    ClrBlendMode_Over
#define PMAX_INPUTBLENDMOD    (NumOfBlendMode - 1)
#define PDEF_INPUTTIME        0.0f
#define PDEF_INPUTSETIME      0

@interface FadePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
@property(assign) id<QCPlugInInputImageSource> inputImage;
//@property double inputFoo;
//@property (copy) NSString* outputBar;
@property (assign) CGColorRef inputColor1;
@property (assign) CGColorRef inputColor2;
@property (assign) CGColorRef inputColor3;
@property (assign) NSUInteger inputFadeInStart;
@property (assign) NSUInteger inputFadeInEnd;
@property (assign) NSUInteger inputFadeInOpt;
@property (assign) NSUInteger inputFadeOutStart;
@property (assign) NSUInteger inputFadeOutEnd;
@property (assign) NSUInteger inputFadeOutOpt;
@property (assign) double     inputTime;
@property (assign) NSUInteger inputBlendMode;

@property (assign) CGFloat    Red1;
@property (assign) CGFloat    Green1;
@property (assign) CGFloat    Blue1;
@property (assign) CGFloat    Alpha1;
@property (assign) CGFloat    Red2;
@property (assign) CGFloat    Green2;
@property (assign) CGFloat    Blue2;
@property (assign) CGFloat    Alpha2;

@end

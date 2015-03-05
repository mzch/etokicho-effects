//
//  Reflect_SpritePlugIn.h
//  Reflect Sprite
//
//  Created by Koichi MATSUMOTO on 2015/02/09.
//  Copyright (c) 2015 Koichi MATSUMOTO. All rights reserved.
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

// キー値、名称、デフォルト値
#define PKEY_INPUTIMAGE         @"inputImage"
#define PKEY_INPUTCOLOR         @"inputColor"
#define PKEY_INPUTFLICKER       @"inputFlicker"
#define PKEY_INPUTTIME          @"inputTime"
#define PKEY_INPUTBLENDMODE     @"inputBlendMode"

#define PNAME_INPUTIMAGE        @"Image"
#define PNAME_INPUTCOLOR        @"Color"
#define PNAME_INPUTFLICKER      @"Flicker"
#define PNAME_INPUTTIME         @"Time"
#define PNAME_INPUTBLENDMODE    @"Blend Mode"

#define PDEF_INPUTCOLOR         CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTFLICKER       0
#define PMAX_INPUTFLICKER       10
#define PMIN_INPUTFLICLER       0
#define PDEF_INPUTTIME          0
#define PDEF_INPUTBLENDMODE     ClrBlendMode_AddAlpha
#define PMAX_INPUTBLENDMODE     (NumOfBlendMode - 1)

@interface Reflect_SpritePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
@property(assign) id<QCPlugInInputImageSource> inputImage;
//@property double inputFoo;
//@property (copy) NSString* outputBar;
@property (assign) CGColorRef   inputColor;
@property (assign) double       inputFlicker;
@property (assign) double       inputTime;
@property (assign) NSUInteger   inputBlendMode;

@end

//
//  ScrollPlugIn.h
//  Scroll
//
//  Created by Koichi MATSUMOTO on 2015/01/01.
//  Copyright (c) 2015年 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

#define MILISECPERSEC           1000.0f
#define BASE_SPEED              1000.0f
#define DECEL_SPEED             100.0f

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

#define BLEND_NAME_REPLACE      @"置換"
#define BLEND_NAME_OVER         @"上書き"
#define BLEND_NAME_ADD          @"加算合成 (αなし)"
#define BLEND_NAME_ADDALPHA     @"加算合成 (αあり)"
#define BLEND_NAME_ALPHA        @"アルファブレンド"
#define BLEND_NAME_MULTI        @"乗算合成"
#define BLEND_NAME_INVERT       @"反転合成"
#define BLEND_NAME_SCREEN       @"スクリーン合成"
#define BLEND_NAME_XOR          @"排他的論理和合成"

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

// スクロールの方向
#define SCROLL_RIGHT            @"右へ"
#define SCROLL_LEFT             @"左へ"
#define SCROLL_UP               @"上へ"
#define SCROLL_DOWN             @"下へ"

enum ScrollMode {
    Scroll_Left = 0,
    Scroll_Right,
    Scroll_Up,
    Scroll_Down,
    NumOfScroll
};

// キー値、名称、デフォルト値
#define PKEY_INPUTIMAGE         @"inputImage"
#define PKEY_INPUTDIR           @"inputDir"
#define PKEY_INPUTSPEED         @"inputSpeed"
#define PKEY_INPUTSTARTTIME     @"inputStartTime"
#define PKEY_INPUTENDTIME       @"inputEndTime"
#define PKEY_INPUTBLENDMODE     @"inputBlendMode"

#define PNAME_INPUTIMAGE        @"Image"
#define PNAME_INPUTDIR          @"Direction"
#define PNAME_INPUTSPEED        @"Speed"
#define PNAME_INPUTSTARTTIME    @"Start Time"
#define PNAME_INPUTENDTIME      @"End Time"
#define PNAME_INPUTBLENDMODE    @"Blend Mode"

#define PDEF_INPUTDIR           Scroll_Left
#define PMIN_INPUTDIR           PDEF_INPUTDIR
#define PMAX_INPUTDIR           (NumOfScroll - 1)
#define PDEF_INPUTSPEED         0.0f
#define PMIN_INPUTSPEED         0.0f
#define PMAX_INPUTSPEED         100.0f
#define PDEF_INPUTBLENDMODE     ClrBlendMode_Over
#define PMAX_INPUTBLENDMODE     (NumOfBlendMode - 1)
#define PDEF_INPUTSETIME        0

@interface ScrollPlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
//@property double inputFoo;
@property(assign) id<QCPlugInInputImageSource> inputImage;
//@property (copy) NSString* outputBar;
@property (assign) NSUInteger inputDir;
@property (assign) double     inputSpeed;
@property (assign) NSUInteger inputStartTime;
@property (assign) NSUInteger inputEndTime;
@property (assign) NSUInteger inputBlendMode;


@end

//
//  Spining_SpritePlugIn.h
//  Spining Sprite
//
//  Created by Koichi MATSUMOTO on 2014/12/30.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// ブレンドモード
#define BLEND_Func_Replace()        glBlendFunc(GL_ONE, GL_ZERO)
#define BLEND_Func_Over()           glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
#define BLEND_Func_Add()            glBlendFunc(GL_ONE, GL_ONE)
#define BLEND_Func_AddAlpha()       glBlendFunc(GL_SRC_ALPHA, GL_ONE)
#define BLEND_Func_Alpha()          glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
#define BLEND_Func_Multi()          glBlendFunc(GL_ZERO, GL_SRC_COLOR)
#define BLEND_Func_Invert()         glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ZERO)
#define BLEND_Func_Screen()         glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE)
#define BLEND_Func_XOR()            glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE_MINUS_SRC_COLOR)

#define BLEND_NAME_REPLACE          @"置換"
#define BLEND_NAME_OVER             @"上書き"
#define BLEND_NAME_ADD              @"加算合成 (αなし)"
#define BLEND_NAME_ADDALPHA         @"加算合成 (αあり)"
#define BLEND_NAME_ALPHA            @"アルファブレンド"
#define BLEND_NAME_MULTI            @"乗算合成"
#define BLEND_NAME_INVERT           @"反転合成"
#define BLEND_NAME_SCREEN           @"スクリーン合成"
#define BLEND_NAME_XOR              @"排他的論理和合成"

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

//
#define PKEY_INPUTIMAGE             @"inputImage"
#define PKEY_INPUTANCHORX           @"inputAnchorX"
#define PKEY_INPUTANCHORY           @"inputAnchorY"
#define PKEY_INPUTXAXIS             @"inputXAxis"
#define PKEY_INPUTYAXIS             @"inputYAxis"
#define PKEY_INPUTZAXIS             @"inputZAxis"
#define PKEY_INPUTXSPEED            @"inputXSpeed"
#define PKEY_INPUTXACCEL            @"inputXAccel"
#define PKEY_INPUTYSPEED            @"inputYSpeed"
#define PKEY_INPUTYACCEL            @"inputYAccel"
#define PKEY_INPUTZSPEED            @"inputZSpeed"
#define PKEY_INPUTZACCEL            @"inputZAccel"
#define PKEY_INPUTSTARTTIME         @"inputStartTime"
#define PKEY_INPUTENDTIME           @"inputEndTime"
#define PKEY_INPUTTIME              @"inputTime"
#define PKEY_INPUTBLENDMODE         @"inputBlendMode"

#define PNAME_INPUTIMAGE            @"Image"
#define PNAME_INPUTANCHORX          @"Anchor X"
#define PNAME_INPUTANCHORY          @"Anchor Y"
#define PNAME_INPUTXAXIS            @"X Axis"
#define PNAME_INPUTYAXIS            @"Y Axis"
#define PNAME_INPUTZAXIS            @"Z Axis"
#define PNAME_INPUTXSPEED           @"Speed (X)"
#define PNAME_INPUTXACCEL           @"Accel (X)"
#define PNAME_INPUTYSPEED           @"Speed (Y)"
#define PNAME_INPUTYACCEL           @"Accel (Y)"
#define PNAME_INPUTZSPEED           @"Speed (Z)"
#define PNAME_INPUTZACCEL           @"Accel (Z)"
#define PNAME_INPUTSTARTTIME        @"Start Time"
#define PNAME_INPUTENDTIME          @"End Time"
#define PNAME_INPUTTIME             @"Time"
#define PNAME_INPUTBLENDMODE        @"Blend Mode"

#define PDEF_INPUTANCHORX           0
#define PDEF_INPUTANCHORY           0
#define PDEF_INPUTAXIS              0
#define PMIN_INPUTAXIS              -180
#define PMAX_INPUTAXIS              180
#define PDEF_INPUTSPEED             0.0f
#define PMIN_INPUTSPEED             -100.0f
#define PMAX_INPUTSPEED             100.0f
#define PDEF_INPUTACCEL             0.0f
#define PMIN_INPUTACCEL             0.0f
#define PMAX_INPUTACCEL             100.0f
#define PDEF_INPUTSTARTTIME         0
#define PDEF_INPUTENDTIME           0
#define PDEF_INPUTTIME              0.0f
#define PDEF_INPUTBLENDMODE         ClrBlendMode_Over
#define PMAX_INPUTBLENDMODE         (NumOfBlendMode - 1)

@interface Spining_SpritePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
@property (assign) id<QCPlugInInputImageSource> inputImage;
//@property double inputFoo;
//@property (copy) NSString* outputBar;
@property (assign) NSUInteger inputAnchorX;
@property (assign) NSUInteger inputAnchorY;
@property (assign) NSUInteger inputXAxis;
@property (assign) NSUInteger inputYAxis;
@property (assign) NSUInteger inputZAxis;
@property (assign) double     inputXSpeed;
@property (assign) double     inputXAccel;
@property (assign) double     inputYSpeed;
@property (assign) double     inputYAccel;
@property (assign) double     inputZSpeed;
@property (assign) double     inputZAccel;
@property (assign) NSUInteger inputStartTime;
@property (assign) NSUInteger inputEndTime;
@property (assign) double     inputTime;
@property (assign) NSUInteger inputBlendMode;

@end

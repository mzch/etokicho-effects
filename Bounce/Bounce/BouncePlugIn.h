//
//  BouncePlugIn.h
//  Bounce
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
#define PKEY_INPUTBOUNCE        @"inputBounce"
#define PKEY_INPUTXLEAD         @"inputXLead"
#define PKEY_INPUTYLEAD         @"inputYLead"
#define PKEY_INPUTZLEAD         @"inputZLead"
#define PKEY_INPUTJUMPSTYLE     @"inputJumpStyle"
#define PKEY_INPUTSTARTTIME     @"inputStartTime"
#define PKEY_INPUTENDTIME       @"inputEndTime"
#define PKEY_INPUTTIME          @"inputTime"
#define PKEY_INPUTBLENDMODE     @"inputBlendMode"

#define PNAME_INPUTIMAGE        @"Image"
#define PNAME_INPUTANCHORX      @"Anchor X"
#define PNAME_INPUTANCHORY      @"Anchor Y"
#define PNAME_INPUTBOUNCE       @"Bounce"
#define PNAME_INPUTXLEAD        @"X Lead"
#define PNAME_INPUTYLEAD        @"Y Lead"
#define PNAME_INPUTZLEAD        @"Z Lead"
#define PNAME_INPUTJUMPSTYLE    @"Jump Style"
#define PNAME_INPUTSTARTTIME    @"Start Time"
#define PNAME_INPUTENDTIME      @"End Time"
#define PNAME_INPUTTIME         @"Time"
#define PNAME_INPUTBLENDMODE    @"Blend Mode"

#define PDEF_INPUTANCHORX     0.0f
#define PDEF_INPUTANCHORY     0.0f
#define PDEF_INPUTFREQUENCY   1.0f
#define PMIN_INPUTFREQUENCY   0.001f
#define PDEF_INPUTBOUNCE      0
#define PDEF_INPUTLEAD        0.0f
#define PDEF_INPUTJUMPSTYLE   Jump_Arc
#define PMAX_INPUTJUMPSTYLE   (NumOfJumpOpt - 1)
#define PDEF_INPUTSETIME      0
#define PDEF_INPUTTIME        0.0f
#define PDEF_INPUTBLENDMODE   ClrBlendMode_Over
#define PMAX_INPUTBLENDMODE   (NumOfBlendMode - 1)

@interface BouncePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
@property(assign) id<QCPlugInInputImageSource> inputImage;
//@property double inputFoo;
//@property (copy) NSString* outputBar;
@property (assign) double     inputAnchorX;
@property (assign) double     inputAnchorY;
@property (assign) NSUInteger inputBounce;
@property (assign) double     inputXLead;
@property (assign) double     inputYLead;
@property (assign) double     inputZLead;
@property (assign) NSUInteger inputJumpStyle;
@property (assign) NSUInteger inputStartTime;
@property (assign) NSUInteger inputEndTime;
@property (assign) double     inputTime;
@property (assign) NSUInteger inputBlendMode;

@property (assign) double     xAnchor;
@property (assign) double     yAnchor;
@property (assign) double     xLeads;
@property (assign) double     yLeads;
@property (assign) double     zLeads;
@property (assign) NSTimeInterval JumpDuration;
@property (assign) NSTimeInterval JumpDuration2;

@end

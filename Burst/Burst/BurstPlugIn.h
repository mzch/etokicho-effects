//
//  BurstPlugIn.h
//  Burst
//
//  Created by Koichi MATSUMOTO on 2014/12/20.
//  Copyright (c) 2014年 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

#define OPENGL_POSLEFT          -1
#define OPENGL_POSRIGHT          1
#define OPENGL_POSTOP           OPENGL_POSRIGHT
#define OPENGL_POSBOTTOM        OPENGL_POSLEFT

// クラス
@interface BurstParticle: NSObject

@property (assign) NSPoint pos;
@property (assign) double x;        // テクスチャの X 座標
@property (assign) double y;        // テクスチャの Y 座標
@property (assign) double width;    // 破片の横幅
@property (assign) double height;   // 破片の縦サイズ
@property (assign) double speedx;   // 破片が持つ X 方向への現在の速度
@property (assign) double speedy;   // 破片が持つ Y 方向への現在の速度
@property (assign) double speedz;   // 破片が持つ Z 方向への現在の速度
@property (assign) double accelx;   // 破片が持つ X 方向への現在の加速度
@property (assign) double accely;   // 破片が持つ X 方向への現在の加速度
@property (assign) double accelz;   // 破片が持つ X 方向への現在の加速度
@property (assign) double gravity;  // 重力加速度 (Y の逆方向への加速度)
@property (assign) double polygonX;         // ポリゴンの原点 X 座標
@property (assign) double polygonY;         // ポリゴンの原点 Y 座標
@property (assign) double polygonZ;         // ポリゴンの原点 Z 座標
@property (assign) double polygonWidth;     // ポリゴンの幅
@property (assign) double polygonHeight;    // ポリゴンの高さ
@property (assign) NSPoint anchor;
@property (assign) double radian;
@end

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

// キー値
#define PKEY_INPUTIMAGE         @"inputImage"
#define PKEY_INPUTANCHORX       @"inputAnchorX"
#define PKEY_INPUTANCHORY       @"inputAnchorY"
#define PKEY_INPUTX             @"inputX"
#define PKEY_INPUTY             @"inputY"
#define PKEY_INPUTWIDTH         @"inputWidth"
#define PKEY_INPUTHEIGHT        @"inputHeight"
#define PKEY_INPUTHORIZONTALDIVISOR @"inputHorizontalDivisor"
#define PKEY_INPUTVIRTICALDIVISOR   @"inputVirticalDivisor"
#define PKEY_INPUTCOLOR         @"inputColor"
#define PKEY_INPUTXMINVELOCITY  @"inputXMinVelocity"
#define PKEY_INPUTXMAXVELOCITY  @"inputXMaxVelocity"
#define PKEY_INPUTYMINVELOCITY  @"inputYMinVelocity"
#define PKEY_INPUTYMAXVELOCITY  @"inputYMaxVelocity"
#define PKEY_INPUTZMINVELOCITY  @"inputZMinVelocity"
#define PKEY_INPUTZMAXVELOCITY  @"inputZMaxVelocity"
#define PKEY_INPUTATTRACTION    @"inputAttraction"
#define PKEY_INPUTBLENDMODE     @"inputBlendMode"
#define PKEY_INPUTSTARTTIME     @"inputStartTime"
#define PKEY_INPUTENDTIME       @"inputEndTime"
#define PKEY_INPUTTIME          @"inputTime"
// 名称
#define PNAME_INPUTIMAGE        @"Image"
#define PNAME_INPUTANCHORX      @"Anchor X"
#define PNAME_INPUTANCHORY      @"Anchor Y"
#define PNAME_INPUTX            @"X Position"
#define PNAME_INPUTY            @"Y Position"
#define PNAME_INPUTWIDTH        @"Width"
#define PNAME_INPUTHEIGHT       @"Height"
#define PNAME_INPUTHORIZONTALDIVISOR @"Horizontal Divisor"
#define PNAME_INPUTVIRTICALDIVISOR   @"Virtical Divisor"
#define PNAME_INPUTCOLOR        @"Color"
#define PNAME_INPUTXMINVELOCITY @"X Min Velocity"
#define PNAME_INPUTXMAXVELOCITY @"X Max Velocity"
#define PNAME_INPUTYMINVELOCITY @"Y Min Velocity"
#define PNAME_INPUTYMAXVELOCITY @"Y Max Velocity"
#define PNAME_INPUTZMINVELOCITY @"Z Min Velocity"
#define PNAME_INPUTZMAXVELOCITY @"Z Max Velocity"
#define PNAME_INPUTATTRACTION   @"Attraction"
#define PNAME_INPUTGRAVITY      @"Gravity"
#define PNAME_INPUTBLENDMODE    @"Blend Mode"
#define PNAME_INPUTSTARTTIME    @"Start Time"
#define PNAME_INPUTENDTIME      @"End Time"
#define PNAME_INPUTTIME         @"Time"
// デフォルト値
#define PDEF_INPUTX             0
#define PDEF_INPUTY             0
#define PDEF_INPUTWIDTH         64
#define PDEF_INPUTHEIGHT        64
#define PDEF_INPUTDIVISOR       64
#define PDEF_INPUTCOLOR         CGColorCreateGenericRGB(1.0f, 1.0f, 1.0f, 1.0f)
#define PDEF_INPUTXMINVELOCITY  -1.0f
#define PDEF_INPUTXMAXVELOCITY  1.0f
#define PDEF_INPUTYMINVELOCITY  -1.0f
#define PDEF_INPUTYMAXVELOCITY  1.0f
#define PDEF_INPUTZMINVELOCITY  -1.0f
#define PDEF_INPUTZMAXVELOCITY  1.0f
#define PDEF_INPUTATTRACTION    0.5f
#define PDEF_INPUTGRAVITY       0.0f
#define PDEF_INPUTBLENDMODE     ClrBlendMode_Over
#define PDEF_INPUTSETIME        0
#define PDEF_INPUTTIME          0.0f
// 最小／最大
#define PMIN_INPUTX             0
#define PMIN_INPUTY             0
#define PMIN_INPUTWIDTH         2
#define PMIN_INPUTHEIGHT        2
#define PMIN_INPUTDIVISOR       2
#define PMIN_INPUTLIFETIME      0.1f
#define PMIN_INPUTSTARTTIME     0
#define PMIN_INPUTENDTIME       0
#define PMAX_INPUTBLENDMODE     (NumOfBlendMode - 1)
#define PMIN_INPUTSETIME        0

@interface BurstPlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
//@property double inputFoo;
//@property (copy) NSString* outputBar;
@property (assign) id<QCPlugInInputImageSource> inputImage;
@property (assign) double     inputAnchorX;
@property (assign) double     inputAnchorY;
@property (assign) double     inputX;
@property (assign) double     inputY;
@property (assign) NSUInteger inputWidth;
@property (assign) NSUInteger inputHeight;
@property (assign) NSUInteger inputHorizontalDivisor;
@property (assign) NSUInteger inputVirticalDivisor;
@property (assign) CGColorRef inputColor;
@property (assign) double     inputXMinVelocity;
@property (assign) double     inputXMaxVelocity;
@property (assign) double     inputYMinVelocity;
@property (assign) double     inputYMaxVelocity;
@property (assign) double     inputZMinVelocity;
@property (assign) double     inputZMaxVelocity;
@property (assign) double     inputAttraction;
@property (assign) double     inputGravity;
@property (assign) NSUInteger inputBlendMode;
@property (assign) NSUInteger inputStartTime;
@property (assign) NSUInteger inputEndTime;
@property (assign) double     inputTime;
//
@property (copy) NSMutableArray * particles;

@end

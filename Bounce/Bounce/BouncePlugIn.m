//
//  BouncePlugIn.m
//  Bounce
//
//  Created by Koichi MATSUMOTO on 2014/12/30.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>
#import <OpenGL/glu.h>
#import <GLKit/GLKit.h>

#import "BouncePlugIn.h"

#define	kQCPlugIn_Name				@"Bounce"
#define	kQCPlugIn_Description		@"Bounce the specified image"

static NSArray * blendOptions;
static NSArray * jumpOptions;

@implementation BouncePlugIn

@dynamic inputImage;
@dynamic inputAnchorX;
@dynamic inputAnchorY;
@dynamic inputBounce;
@dynamic inputXLead;
@dynamic inputYLead;
@dynamic inputZLead;
@dynamic inputJumpStyle;
@dynamic inputStartTime;
@dynamic inputEndTime;
@dynamic inputTime;
@dynamic inputBlendMode;

// Here you need to declare the input / output properties as dynamic as Quartz Composer will handle their implementation
//@dynamic inputFoo, outputBar;

+ (NSDictionary *)attributes
{
	// Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
    return @{QCPlugInAttributeNameKey:kQCPlugIn_Name, QCPlugInAttributeDescriptionKey:kQCPlugIn_Description};
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	// Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
    if ([key isEqualToString:PKEY_INPUTIMAGE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTIMAGE, QCPortAttributeNameKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORX])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORX, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTANCHORX], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PDEF_INPUTANCHORX], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTANCHORY], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PDEF_INPUTANCHORY], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTBOUNCE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTBOUNCE, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTBOUNCE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTBOUNCE], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXLEAD])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXLEAD, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTLEAD], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYLEAD])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYLEAD, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTLEAD], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZLEAD])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZLEAD, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTLEAD], QCPortAttributeDefaultValueKey,
                nil];
    jumpOptions = [NSArray arrayWithObjects:JUMP_NAME_ARC, JUMP_NAME_MIRROR, JUMP_NAME_QUAD, JUMP_NAME_FLIGHT, nil];
    if ([key isEqualToString:PKEY_INPUTJUMPSTYLE])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTJUMPSTYLE, QCPortAttributeNameKey,
                jumpOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTJUMPSTYLE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTJUMPSTYLE], QCPortAttributeMaximumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTSTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTTIME], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTBLENDMODE])
    {
        blendOptions = [NSArray arrayWithObjects:BLEND_NAME_REPLACE, BLEND_NAME_OVER, BLEND_NAME_ADD, BLEND_NAME_ADDALPHA, BLEND_NAME_ALPHA, BLEND_NAME_MULTI,BLEND_NAME_INVERT, BLEND_NAME_SCREEN, BLEND_NAME_XOR, nil];
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTBLENDMODE, QCPortAttributeNameKey,
                blendOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTBLENDMODE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTBLENDMODE], QCPortAttributeMaximumValueKey,
                nil];
    }
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	// Return the execution mode of the plug-in: kQCPlugInExecutionModeProvider, kQCPlugInExecutionModeProcessor, or kQCPlugInExecutionModeConsumer.
	return kQCPlugInExecutionModeConsumer;
}

+ (QCPlugInTimeMode)timeMode
{
	// Return the time dependency mode of the plug-in: kQCPlugInTimeModeNone, kQCPlugInTimeModeIdle or kQCPlugInTimeModeTimeBase.
	return kQCPlugInTimeModeNone;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		// Allocate any permanent resource required by the plug-in.
	}
	
	return self;
}

@end

@implementation BouncePlugIn (Execution)

- (void)setBlendFunc:(CGLContextObj) cgl_ctx
{
    switch (self.inputBlendMode)
    {
        case ClrBlendMode_Replace:      // 置換
            BLEND_Func_Replace();
            break;
        case ClrBlendMode_Add:          // 加算合成 (アルファなし)
            BLEND_Func_Add();
            break;
        case ClrBlendMode_AddAlpha:     // 加算合成 (アルファあり)
            BLEND_Func_AddAlpha();
            break;
        case ClrBlendMode_Alpha:        // アルファブレンド
            BLEND_Func_Alpha();
            break;
        case ClrBlendMode_Multi:        // 乗算合成
            BLEND_Func_Multi();
            break;
        case ClrBlendMode_Invert:       // 反転合成
            BLEND_Func_Invert();
            break;
        case ClrBlendMode_Screen:       // スクリーン合成
            BLEND_Func_Screen();
            break;
        case ClrBlendMode_Xor:          // 排他的論理和合成
            BLEND_Func_XOR();
            break;
        default:                        // 上書き
            BLEND_Func_Over();
            break;
    }
    glEnable(GL_BLEND);
}

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	// Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	
	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
}

- (void)setupExecute:(id <QCPlugInContext>)context ScreenSpec:(NSRect)scspec
{
    NSRect bounds = [context bounds];
    
    double pixelWidth  = bounds.size.width  / scspec.size.width;
    double pixelHeight = bounds.size.height / scspec.size.height;
    
    _xAnchor   = bounds.origin.x + (pixelWidth  * self.inputAnchorX);
    _yAnchor   = bounds.origin.y + (pixelHeight * self.inputAnchorY);
    
    _xLeads    = pixelWidth  * self.inputXLead;
    _yLeads    = pixelHeight * self.inputYLead;
    _zLeads    = pixelWidth  * self.inputZLead;
    
    if (self.inputEndTime > self.inputStartTime && self.inputBounce > 0)
        _JumpDuration = (NSTimeInterval)(self.inputEndTime - self.inputStartTime) / (NSTimeInterval)self.inputBounce;
    else
        _JumpDuration = 0.0f;
    _JumpDuration2 = _JumpDuration / 2;
}

- (SSDistance) getJumpLead
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputEndTime;
    NSTimeInterval CurrentTime = self.inputTime * MILISECPERSEC;
    SSDistance jump = {0.0f, 0.0f, 0.0f};
    
    if ((EndTime > StartTime) &&  (_JumpDuration > 0.0f))
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            double JumpRadian = fmod((NSTimeInterval)(CurrentTime - StartTime) / _JumpDuration, 1.0f);
            double JumpRad2   = (JumpRadian - (_JumpDuration2 / _JumpDuration));
            JumpRad2  = JumpRad2 < 0.0f ? JumpRadian : fabs(JumpRad2 - (_JumpDuration2 / _JumpDuration));
            JumpRad2 *= _JumpDuration / _JumpDuration2;
            switch (self.inputJumpStyle) {
                case Jump_Mirror:
                    jump.x = JumpRad2 * _xLeads;
                    jump.y = JumpRad2 * _yLeads;
                    jump.z = JumpRad2 * _zLeads;
                    break;
                case Jump_Quad:
                    jump.x = pow(JumpRad2, 3) * _xLeads;
                    jump.y = pow(JumpRad2, 3) * _yLeads;
                    jump.z = pow(JumpRad2, 3) * _zLeads;
                    break;
                case Jump_Flight:
                    jump.x = (1.0f + (-1.0f * pow(1.0f - JumpRad2, 3))) * _xLeads;
                    jump.y = (1.0f + (-1.0f * pow(1.0f - JumpRad2, 3))) * _yLeads;
                    jump.z = (1.0f + (-1.0f * pow(1.0f - JumpRad2, 3))) * _zLeads;
                    break;
                default:
                    JumpRadian *= M_PI;
                    jump.x = sin(JumpRadian) * _xLeads;
                    jump.y = sin(JumpRadian) * _yLeads;
                    jump.z = sin(JumpRadian) * _zLeads;
                    break;
            }
        }
    }
    
    return jump;
}

- (void)drawTexture:(id <QCPlugInContext>)context ScreenSpec:(NSRect)scSpec
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    
    // New Position
    NSRect   bounds = [context bounds];
    SSDistance jump = [self getJumpLead];
    GLdouble     nx = (bounds.origin.x - _xAnchor + jump.x);
    GLdouble     ny = (bounds.origin.y - _yAnchor + jump.y);
    
    // move the image to the center
    glTranslated(_xAnchor, _yAnchor, 0.0f);

    // Render the textured quad by mapping the texture coordinates to the vertices
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);       // upper right
        glVertex3d(nx + bounds.size.width, ny + bounds.size.height, jump.z);
        glTexCoord2d(0.0f, 1.0f);       // upper left
        glVertex3d(nx,                     ny + bounds.size.height, jump.z);
        glTexCoord2d(0.0f, 0.0f);       // lower left
        glVertex3d(nx,                     ny,                      jump.z);
        glTexCoord2d(1.0f, 0.0f);       // lower right
        glVertex3d(nx + bounds.size.width, ny,                      jump.z);
    glEnd();
   
    glFlush();
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	/*
	Called by Quartz Composer whenever the plug-in instance needs to execute.
	Only read from the plug-in inputs and produce a result (by writing to the plug-in outputs or rendering to the destination OpenGL context) within that method and nowhere else.
	Return NO in case of failure during the execution (this will prevent rendering of the current frame to complete).
	
	The OpenGL context for rendering can be accessed and defined for CGL macros using:
	CGLContextObj cgl_ctx = [context CGLContextObj];
	*/
    CGLContextObj cgl_ctx = [context CGLContextObj];
    if (cgl_ctx == NULL)
        return NO;
    
    // テクスチャイメージを取得
    id<QCPlugInInputImageSource> image = self.inputImage;
    GLuint textureName = 0;
    if (image) {
        if ([image lockTextureRepresentationWithColorSpace:([image shouldColorMatch] ?  [context colorSpace] :
                                                            [image imageColorSpace])
                                                 forBounds:[image imageBounds]])
        {
            textureName = [image textureName];
        }
    }
    
    CGLSetCurrentContext(cgl_ctx);
    
    // 現在の状態を保存
    GLint saveMode;
    glGetIntegerv(GL_MATRIX_MODE, &saveMode);
    GLboolean saveBlend;
    glGetBooleanv(GL_BLEND, &saveBlend);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glPushMatrix();
    
    // ブレンド処理
    [self setBlendFunc:cgl_ctx];
    
    // 法線の正規化を開始
    glEnable(GL_NORMALIZE);
    
    // 画面表示クリア
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // テクスチャをバインド
    if (textureName)
    {
        [image bindTextureRepresentationToCGLContext:cgl_ctx
                                         textureUnit:GL_TEXTURE0
                                normalizeCoordinates:YES];
    }
    
    // Get current Viewport
    GLint curViewPort[4];
    glGetIntegerv(GL_VIEWPORT, curViewPort);
    NSRect scsize;
    scsize.origin.x = (CGFloat) curViewPort[0];
    scsize.origin.y = (CGFloat) curViewPort[1];
    scsize.size.width  = (CGFloat) curViewPort[2];
    scsize.size.height = (CGFloat) curViewPort[3];
    
    // 初期設定
    [self setupExecute:context ScreenSpec:scsize];
    
    // テクスチャを描画
    [self drawTexture:context ScreenSpec:scsize];
    
    // Unbind the texture from the texture unit.
    if (textureName)
    {
        [image unbindTextureRepresentationFromCGLContext:cgl_ctx textureUnit: GL_TEXTURE0];
    }
    
    // 法線の正規化を終了
    glDisable(GL_NORMALIZE);
    
    // 元の状態を復元
    glPopMatrix();
    if (! saveBlend)
    {
        glDisable(GL_BLEND);
    }
    glMatrixMode(saveMode);
    
    // テクスチャを破棄
    if (textureName)
        [image unlockTextureRepresentation];
    
    // エラーチェック
    GLenum       error;
    error = glGetError();
    if(error) {
        [context logMessage:@"OpenGL error %04X", error];
        return NO;
    }
    
    return YES;
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
}

@end

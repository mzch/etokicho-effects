//
//  FadePlugIn.m
//  Fade
//
//  Created by Koichi MATSUMOTO on 2015/01/01.
//  Copyright (c) 2015 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "FadePlugIn.h"

#define	kQCPlugIn_Name				@"Fade"
#define	kQCPlugIn_Description		@"Smooth Color animation like fade-in or fade-out effect."

static NSArray * blendOptions;
static NSArray * fadeOptions;

@implementation FadePlugIn

@dynamic inputImage;
@dynamic inputColor1;
@dynamic inputColor2;
@dynamic inputColor3;
@dynamic inputFadeInStart;
@dynamic inputFadeInEnd;
@dynamic inputFadeInOpt;
@dynamic inputFadeOutStart;
@dynamic inputFadeOutEnd;
@dynamic inputFadeOutOpt;
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
    if ([key isEqualToString:PKEY_INPUTCOLOR1])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOR1, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTCOLOR2])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOR2, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTCOLOR3])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOR3, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFADEINSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEINSTART, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFADEINEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEINEND, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    fadeOptions = [NSArray arrayWithObjects:FADE_NAME_CONST, FADE_NAME_LOG, FADE_NAME_EXP, nil];
    if ([key isEqualToString:PKEY_INPUTFADEINOPT])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEINOPT, QCPortAttributeNameKey,
                fadeOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTFADEOPT], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTFADEOPT], QCPortAttributeMaximumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTFADEOUTSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEOUTSTART, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFADEOUTEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEOUTEND, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFADEOUTOPT])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEOUTOPT, QCPortAttributeNameKey,
                fadeOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTFADEOPT], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTFADEOPT], QCPortAttributeMaximumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTTIME], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTBLENDMOD])
    {
        blendOptions = [NSArray arrayWithObjects:BLEND_NAME_REPLACE, BLEND_NAME_OVER, BLEND_NAME_ADD, BLEND_NAME_ADDALPHA, BLEND_NAME_ALPHA, BLEND_NAME_MULTI,BLEND_NAME_INVERT, BLEND_NAME_SCREEN, BLEND_NAME_XOR, nil];
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTBLENDMOD, QCPortAttributeNameKey,
                blendOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTBLENDMOD], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTBLENDMOD], QCPortAttributeMaximumValueKey,
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

@implementation FadePlugIn (Execution)

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
    const CGFloat * color1 = CGColorGetComponents(self.inputColor1);
    const CGFloat * color2 = CGColorGetComponents(self.inputColor2);
    _Red1   = color2[0] - color1[0];
    _Green1 = color2[1] - color1[1];
    _Blue1  = color2[2] - color1[2];
    _Alpha1 = color2[3] - color1[3];
    const CGFloat * color3 = CGColorGetComponents(self.inputColor3);
    _Red2   = color3[0] - color2[0];
    _Green2 = color3[1] - color2[1];
    _Blue2  = color3[2] - color2[2];
    _Alpha2 = color3[3] - color2[3];
}

- (GLdouble) getFadeInProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputFadeInStart;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputFadeInEnd;
    NSTimeInterval CurrentTime = self.inputTime * MILISECPERSEC;
    GLdouble progress = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            GLdouble t = (CurrentTime - StartTime) / (EndTime - StartTime);
            switch (self.inputFadeInOpt) {
                case Fade_Log:
                    progress = log(1.0f + t) * 2.0f;
                    progress = progress < 0.0f ? 0.0f : progress;
                    break;
                case Fade_Exp:
                    progress = exp(t) - 1.0f;
                    break;
                default:
                    progress = t;
                    break;
            }
        }
        else
        {
            progress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    return progress;
}

- (GLdouble) getFadeOutProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputFadeOutStart;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputFadeOutEnd;
    NSTimeInterval CurrentTime = self.inputTime * MILISECPERSEC;
    GLdouble progress = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            GLdouble t = (CurrentTime - StartTime) / (EndTime - StartTime);
            switch (self.inputFadeOutOpt) {
                case Fade_Log:
                    progress = log(1.0f + t) * 2.0f;
                    progress = progress < 0.0f ? 0.0f : progress;
                    break;
                case Fade_Exp:
                    progress = exp(t) - 1.0f;
                    break;
                default:
                    progress = t;
                    break;
            }
        }
        else
        {
            progress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    return progress;
}

- (void)drawTexture:(id <QCPlugInContext>)context ScreenSpec:(NSRect)scSpec
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    
    // Set Color
    const CGFloat * colorComponents = CGColorGetComponents(self.inputColor1);
    GLdouble fdin_progress = [self getFadeInProgress];
    GLdouble fout_progress = [self getFadeOutProgress];
    GLdouble red   = colorComponents[0];
    GLdouble green = colorComponents[1];
    GLdouble blue  = colorComponents[2];
    GLdouble alpha = colorComponents[3];
    if (fdin_progress > 0.0f && fdin_progress < 1.0f)
    {
        red   += _Red1   * fdin_progress;
        green += _Green1 * fdin_progress;
        blue  += _Blue1  * fdin_progress;
        alpha += _Alpha1 * fdin_progress;
    }
    if (fdin_progress >= 1.0f)
    {
        colorComponents = CGColorGetComponents(self.inputColor2);
        red   = colorComponents[0];
        green = colorComponents[1];
        blue  = colorComponents[2];
        alpha = colorComponents[3];
        if (fout_progress > 0.0f && fout_progress < 1.0f)
        {
            red   += _Red2   * fout_progress;
            green += _Green2 * fout_progress;
            blue  += _Blue2  * fout_progress;
            alpha += _Alpha2 * fout_progress;
        }
    }
    if (fout_progress >= 1.0f)
    {
        colorComponents = CGColorGetComponents(self.inputColor3);
        red   = colorComponents[0];
        green = colorComponents[1];
        blue  = colorComponents[2];
        alpha = colorComponents[3];
    }
    glColor4f(red, green, blue, alpha);
    
    // Render the textured quad by mapping the texture coordinates to the vertices
    NSRect bounds = [context bounds];
    GLdouble retio = bounds.size.height / bounds.size.width;
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);       // upper right
        glVertex2d( 1.0f,  retio);
        glTexCoord2d(0.0f, 1.0f);       // upper left
        glVertex2d(-1.0f,  retio);
        glTexCoord2d(0.0f, 0.0f);       // lower left
        glVertex2d(-1.0f,  retio * (-1.0f));
        glTexCoord2d(1.0f, 0.0f);       // lower right
        glVertex2d( 1.0f,  retio * (-1.0f));
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

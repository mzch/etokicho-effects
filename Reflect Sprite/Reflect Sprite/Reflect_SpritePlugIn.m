//
//  Reflect_SpritePlugIn.m
//  Reflect Sprite
//
//  Created by Koichi MATSUMOTO on 2015/02/09.
//  Copyright (c) 2015 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "Reflect_SpritePlugIn.h"

#define	kQCPlugIn_Name				@"Reflect Sprite"
#define	kQCPlugIn_Description		@"This patch provide light reflect effect to the image."

static NSArray * blendOptions;

@implementation Reflect_SpritePlugIn

@dynamic inputImage;
@dynamic inputColor;
@dynamic inputFlicker;
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
    if ([key isEqualToString:PKEY_INPUTCOLOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOR, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFLICKER])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFLICKER, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTFLICKER], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTFLICLER], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTFLICKER], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTTIME], QCPortAttributeDefaultValueKey,
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

@implementation Reflect_SpritePlugIn (Execution)


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

- (GLdouble) getSineValueFromCurrentTime:(NSTimeInterval)current
{
    return sin(current);
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
    
    // 前面テクスチャの距離を求める。
    // Get current Viewport
    GLint curViewPort[4];
    glGetIntegerv(GL_VIEWPORT, curViewPort);
    NSRect scsize;
    scsize.origin.x = (CGFloat) curViewPort[0];
    scsize.origin.y = (CGFloat) curViewPort[1];
    scsize.size.width  = (CGFloat) curViewPort[2];
    scsize.size.height = (CGFloat) curViewPort[3];
    NSRect bounds = [context bounds];
    GLdouble nz = bounds.size.width / scsize.size.width;
    GLdouble retio = bounds.size.height / bounds.size.width;

    // テクスチャをバインド
    if (textureName)
    {
        [image bindTextureRepresentationToCGLContext:cgl_ctx
                                         textureUnit:GL_TEXTURE0
                                normalizeCoordinates:YES];
    }
    
    glColor4d(1.0f, 1.0f, 1.0f, 1.0f);
    // テクスチャを描画
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);       // upper right
        glVertex3d(1.0f,   retio, -nz);
        glTexCoord2d(0.0f, 1.0f);       // upper left
        glVertex3d(-1.0f,  retio, -nz);
        glTexCoord2d(0.0f, 0.0f);       // lower left
        glVertex3d(-1.0f, -1.0f * retio, -nz);
        glTexCoord2d(1.0f, 0.0f);       // lower right
        glVertex3d(1.0f,  -1.0f * retio, -nz);
    glEnd();
    
    // 色設定
    const CGFloat * colorComponents = CGColorGetComponents(self.inputColor);
    const GLdouble reflect = [self getSineValueFromCurrentTime:time];
    GLdouble red   = colorComponents[0] * reflect;
    GLdouble green = colorComponents[1] * reflect;
    GLdouble blue  = colorComponents[2] * reflect;
    GLdouble alpha = colorComponents[3] * reflect;
    glColor4d(red, green, blue, alpha);
    // テクスチャを描画
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);       // upper right
        glVertex3d(1.0f,   retio, 0.0f);
        glTexCoord2d(0.0f, 1.0f);       // upper left
        glVertex3d(-1.0f,  retio, 0.0f);
        glTexCoord2d(0.0f, 0.0f);       // lower left
        glVertex3d(-1.0f, -1.0f * retio, 0.0f);
        glTexCoord2d(1.0f, 0.0f);       // lower right
        glVertex3d(1.0f,  -1.0f * retio, 0.0f);
    glEnd();
    
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

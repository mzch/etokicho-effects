//
//  ScrollPlugIn.m
//  Scroll
//
//  Created by Koichi MATSUMOTO on 2015/01/01.
//  Copyright (c) 2015年 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "ScrollPlugIn.h"

#define	kQCPlugIn_Name				@"Scroll"
#define	kQCPlugIn_Description		@"Scroll image."

static NSArray * blendOptions;
static NSArray * scrollOptions;

@implementation ScrollPlugIn

@dynamic inputImage;
@dynamic inputDir;
@dynamic inputSpeed;
@dynamic inputStartTime;
@dynamic inputEndTime;
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
    if ([key isEqualToString:PKEY_INPUTDIR])
    {
        scrollOptions = [NSArray arrayWithObjects:SCROLL_LEFT, SCROLL_RIGHT, SCROLL_UP, SCROLL_DOWN, nil];
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTDIR, QCPortAttributeNameKey,
                scrollOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithInteger:PDEF_INPUTDIR], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMAX_INPUTDIR], QCPortAttributeMaximumValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTDIR], QCPortAttributeMinimumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTSPEED])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSPEED, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTSPEED], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSPEED], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTSPEED], QCPortAttributeMaximumValueKey,
                nil];
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
	return kQCPlugInTimeModeTimeBase;
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

@implementation ScrollPlugIn (Execution)

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

- (GLdouble) getElasped:(NSTimeInterval)time
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputEndTime;
    NSTimeInterval CurrentTime = time * MILISECPERSEC;
    GLdouble t_pass = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            t_pass = (CurrentTime - StartTime) / MILISECPERSEC;
        }
    }
    return t_pass;
}

- (void) scrollUp:(id <QCPlugInContext>)context
    textureScroll:(GLdouble)texScroll
     PlygonScroll:(GLdouble)plyScroll
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    NSRect  bounds = [context bounds];
    GLdouble retio = bounds.size.height / bounds.size.width;
    // 上スクロール
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f, 1.0f - texScroll);
        glVertex2d(1.0f,   retio);
        // Upper Left
        glTexCoord2d(0.0f, 1.0f - texScroll);
        glVertex2d(-1.0f,  retio);
        // Lower Left
        glTexCoord2d(0.0f, 0.0f);
        glVertex2d(-1.0f,  retio * (-1.0f) + plyScroll);
        // Lower Right
        glTexCoord2d(1.0f, 0.0f);
        glVertex2d(1.0f,   retio * (-1.0f) + plyScroll);
    glEnd();
    // Scrolled
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f, 1.0f);
        glVertex2d(1.0f,   retio * -1.0f + plyScroll);
        // Upper Left
        glTexCoord2d(0.0f, 1.0f);
        glVertex2d(-1.0f,  retio * -1.0f + plyScroll);
        // Lower Left
        glTexCoord2d(0.0f, 1.0f - texScroll);
        glVertex2d(-1.0f,  retio * -1.0f);
        // Lower Right
        glTexCoord2d(1.0f, 1.0f - texScroll);
        glVertex2d(1.0f,   retio * -1.0f);
    glEnd();
}

- (void) scrollDown:(id <QCPlugInContext>)context
    textureScroll:(GLdouble)texScroll
     PlygonScroll:(GLdouble)plyScroll
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    NSRect  bounds = [context bounds];
    GLdouble retio = bounds.size.height / bounds.size.width;
    // 下スクロール
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f, 1.0f);
        glVertex2d(1.0f,   retio - plyScroll);
        // Upper Left
        glTexCoord2d(0.0f, 1.0f);
        glVertex2d(-1.0f,  retio - plyScroll);
        // Lower Left
        glTexCoord2d(0.0f, texScroll);
        glVertex2d(-1.0f,  retio * (-1.0f));
        // Lower Right
        glTexCoord2d(1.0f, texScroll);
        glVertex2d(1.0f,   retio * (-1.0f));
    glEnd();
    // Scrolled
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f, texScroll);
        glVertex2d(1.0f,   retio);
        // Upper Left
        glTexCoord2d(0.0f, texScroll);
        glVertex2d(-1.0f,  retio);
        // Lower Left
        glTexCoord2d(0.0f, 0.0f);
        glVertex2d(-1.0f,  retio - plyScroll);
        // Lower Right
        glTexCoord2d(1.0f, 0.0f);
        glVertex2d(1.0f,   retio - plyScroll);
    glEnd();
}

- (void) scrollRight:(id <QCPlugInContext>)context
       textureScroll:(GLdouble)texScroll
        PlygonScroll:(GLdouble)plyScroll
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    NSRect  bounds = [context bounds];
    GLdouble retio = bounds.size.height / bounds.size.width;
    // 右スクロール
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f - texScroll,  1.0f);
        glVertex2d(1.0f,                  retio);
        // Upper Left
        glTexCoord2d(0.0f,                1.0f);
        glVertex2d(-1.0f + plyScroll,   retio);
        // Lower Left
        glTexCoord2d(0.0f,                0.0f);
        glVertex2d(-1.0f + plyScroll,   retio * (-1.0f));
        // Lower Right
        glTexCoord2d(1.0f - texScroll,  0.0f);
        glVertex2d(1.0f,                  retio * (-1.0f));
    glEnd();
    // Scrolled
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f,                1.0f);
        glVertex2d(-1.0f + plyScroll,   retio);
        // Upper Left
        glTexCoord2d(1.0f - texScroll,  1.0f);
        glVertex2d(-1.0f,                 retio);
        // Lower Left
        glTexCoord2d(1.0f - texScroll,  0.0f);
        glVertex2d(-1.0f,                 retio * -1.0f);
        // Lower Right
        glTexCoord2d(1.0f,                0.0f);
        glVertex2d(-1.0f + plyScroll,   retio * -1.0f);
    glEnd();
}

- (void) scrollLeft:(id <QCPlugInContext>)context
      textureScroll:(GLdouble)texScroll
       PlygonScroll:(GLdouble)plyScroll
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    NSRect  bounds = [context bounds];
    GLdouble retio = bounds.size.height / bounds.size.width;
    // 左スクロール
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(1.0f,             1.0f);
        glVertex2d(1.0f - plyScroll, retio);
        // Upper Left
        glTexCoord2d(texScroll,                1.0f);
        glVertex2d(-1.0f,              retio);
        // Lower Left
        glTexCoord2d(texScroll,                0.0f);
        glVertex2d(-1.0f,              retio * (-1.0f));
        // Lower Right
        glTexCoord2d(1.0f,  0.0f);
        glVertex2d(1.0f - plyScroll, retio * (-1.0f));
    glEnd();
    // Scrolled
    glBegin(GL_QUADS);
        // Upper Right
        glTexCoord2d(texScroll,      1.0f);
        glVertex2d(1.0f,               retio);
        // Upper Left
        glTexCoord2d(0.0f,             1.0f);
        glVertex2d(1.0f - plyScroll, retio);
        // Lower Left
        glTexCoord2d(0.0f,             0.0f);
        glVertex2d(1.0f - plyScroll, retio * -1.0f);
        // Lower Right
        glTexCoord2d(texScroll,      0.0f);
        glVertex2d(1.0f,               retio * -1.0f);
    glEnd();
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
    
    // 基準速度
    GLdouble shift = 1  / (BASE_SPEED / DECEL_SPEED);
    // 経過時間を計算
    GLdouble elasped = [self getElasped:time];
    GLdouble tex_Scroll = self.inputSpeed * shift * elasped;
    NSRect  bounds = [context bounds];
    GLdouble ply_Hscroll = self.inputSpeed * bounds.size.width  * shift * elasped;
    GLdouble ply_Vscroll = self.inputSpeed * bounds.size.height * shift * elasped;
    for ( ; ply_Hscroll > bounds.size.width;  ply_Hscroll -= bounds.size.width)
        ;
    for ( ; ply_Vscroll > bounds.size.height; ply_Vscroll -= bounds.size.height)
        ;
    for ( ; tex_Scroll > 1.0f; tex_Scroll -= 1.0f)
        ;
    
    // 色設定
    glColor4d(1.0f, 1.0f, 1.0f, 1.0f);
    // ポリゴン描画
    switch (self.inputDir) {
        case Scroll_Right:
            [self scrollRight:context textureScroll:tex_Scroll PlygonScroll:ply_Hscroll];
            break;
        case Scroll_Up:
            [self scrollUp:context textureScroll:tex_Scroll PlygonScroll:ply_Vscroll];
            break;
        case Scroll_Down:
            [self scrollDown:context textureScroll:tex_Scroll PlygonScroll:ply_Vscroll];
            break;
        default:
            [self scrollLeft:context textureScroll:tex_Scroll PlygonScroll:ply_Hscroll];
            break;
    }
    glFlush();
    
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

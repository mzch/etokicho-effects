//
//  BurstPlugIn.m
//  Burst
//
//  Created by Koichi MATSUMOTO on 2014/12/20.
//  Copyright (c) 2014年 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>
#import <OpenGL/glu.h>
#import <GLKit/GLKit.h>

#import "BurstPlugIn.h"

#define	kQCPlugIn_Name				@"Burst"
#define	kQCPlugIn_Description		@"Burst an image just as Particle System."

static NSArray * blendOptions;

@implementation BurstPlugIn

@dynamic inputImage;
@dynamic inputAnchorX;
@dynamic inputAnchorY;
@dynamic inputX;
@dynamic inputY;
@dynamic inputWidth;
@dynamic inputHeight;
@dynamic inputHorizontalDivisor;
@dynamic inputVirticalDivisor;
@dynamic inputColor;
@dynamic inputXMinVelocity;
@dynamic inputXMaxVelocity;
@dynamic inputYMinVelocity;
@dynamic inputYMaxVelocity;
@dynamic inputZMinVelocity;
@dynamic inputZMaxVelocity;
@dynamic inputAttraction;
@dynamic inputGravity;
@dynamic inputBlendMode;
@dynamic inputStartTime;
@dynamic inputEndTime;
@dynamic inputTime;

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
                [NSNumber numberWithDouble:PDEF_INPUTX], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTX])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTX, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTX], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTWIDTH])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTWIDTH, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTWIDTH], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTWIDTH], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTHEIGHT])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTHEIGHT, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTHEIGHT], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTHEIGHT], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTHORIZONTALDIVISOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTHORIZONTALDIVISOR, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTDIVISOR], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTDIVISOR], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTVIRTICALDIVISOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTVIRTICALDIVISOR, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTDIVISOR], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTDIVISOR], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTCOLOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOR, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXMINVELOCITY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXMINVELOCITY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXMINVELOCITY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXMAXVELOCITY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXMAXVELOCITY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXMAXVELOCITY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYMINVELOCITY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYMINVELOCITY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXMINVELOCITY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYMAXVELOCITY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYMAXVELOCITY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXMAXVELOCITY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZMINVELOCITY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZMINVELOCITY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXMINVELOCITY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZMAXVELOCITY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZMAXVELOCITY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXMAXVELOCITY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTATTRACTION])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTATTRACTION, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTATTRACTION], QCPortAttributeDefaultValueKey,
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
    if ([key isEqualToString:PKEY_INPUTSTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTTIME], QCPortAttributeDefaultValueKey,
                nil];
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
        _particles = nil;
	}
	
	return self;
}


@end

@implementation BurstParticle

- (instancetype) init
{
    self = [super init];
    if (! self)
    {
        return nil;
    }
    
    return self;
}

- (void) initializeWithXMinVelocity:(double)xmin
                       XMaxVelocity:(double)xmax
                       YMinVeloxity:(double)ymin
                       YMaxVelocity:(double)ymax
                       ZMinVeloxity:(double)zmin
                       ZMaxVelocity:(double)zmax
                            Gravity:(double)gravity
                             Anchor:(NSPoint)anchor
{
    _accelx = ((double)rand() / (double)RAND_MAX) * (xmax - xmin) + xmin;
    _accely = ((double)rand() / (double)RAND_MAX) * (ymax - ymin) + ymin;
    _accelz = ((double)rand() / (double)RAND_MAX) * (zmax - zmin) + zmin;
    _gravity = gravity;
    _anchor = anchor;
}

- (void) initializeWithVertex:(id <QCPlugInContext>)context
                     Position:(NSPoint) pos
                         XDiv:(NSUInteger)xdiv
                         YDiv:(NSUInteger)ydiv
                  TextureRect:(NSRect)texRect
                   polygonRect:(NSRect)pbounds
{
    _pos = pos;
    
    _width  = texRect.size.width  / xdiv;
    _height = texRect.size.height / ydiv;
    _x = pos.x * _width  + texRect.origin.x;
    _y = pos.y * _height + texRect.origin.y;
    _radian = atan2(_x - _anchor.x, _y - _anchor.y);
    
    _polygonWidth  = pbounds.size.width;
    _polygonHeight = pbounds.size.height;
    _polygonX      = pbounds.origin.x + (pos.x * _polygonWidth);
    _polygonY      = pbounds.origin.y + (pos.y * _polygonHeight);
    _polygonZ      = 0.0f;
}

- (void) moveToNewPosition:(double)attraction
                  Progress:(BurstProgress)progress
{
    // (attraction * (_accelx < 0.0f ? -1.0f : 1.0f))
    _speedx += _polygonWidth  * (_accelx - (attraction * (_accelx < 0.0f ? -1.0f : 1.0f))) * progress.elapsed;
    _speedy += _polygonHeight * (_accely - (attraction * (_accelx < 0.0f ? -1.0f : 1.0f))) * progress.elapsed;
    _speedz += _polygonWidth  * (_accelz - (attraction * (_accelx < 0.0f ? -1.0f : 1.0f))) * progress.elapsed;
    
    _polygonX += cos(_radian) * _speedx * TIMESCALE;
    _polygonY += sin(_radian) * _speedy * TIMESCALE;
    _polygonY -= (_gravity * pow(progress.elapsed, 2) / 2);
    _polygonZ += cos(_radian) * _speedz * TIMESCALE;
}

- (void) Mapping:(CGLContextObj) cgl_ctx
{
    glTexCoord2d(_x,            _y);            // lower left
    glVertex3d(_polygonX,                   _polygonY,                  _polygonZ);
    glTexCoord2d(_x + _width,   _y);            // lower right
    glVertex3d(_polygonX + _polygonWidth,   _polygonY,                  _polygonZ);
    glTexCoord2d(_x + _width,   _y + _height);  // upper right
    glVertex3d(_polygonX + _polygonWidth,   _polygonY + _polygonHeight, _polygonZ);
    glTexCoord2d(_x,            _y + _height);  // upper left
    glVertex3d(_polygonX,                   _polygonY + _polygonHeight, _polygonZ);
}

@end

@implementation BurstPlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	// Return NO in case of fatal failure (this will prevent rendering of the composition to start).
    CGLContextObj cgl_ctx = [context CGLContextObj];
    if (cgl_ctx == NULL)
        return NO;

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

- (void) prepareParticles:(id <QCPlugInContext>)context ScreenRect:(NSRect)sc
{
    if (_particles)
        return;

    _particles = [[NSMutableArray alloc] initWithCapacity:self.inputVirticalDivisor];

    NSRect bounds  = [context bounds];
    GLdouble pixelWidth  = bounds.size.width  / sc.size.width;
    GLdouble pixelHeight = bounds.size.height / sc.size.height;
    NSRect pbounds;
    pbounds.origin.x = bounds.origin.x + (self.inputX * pixelWidth);
    pbounds.origin.y = bounds.origin.y + (self.inputY * pixelHeight);
    pbounds.size.width  = (CGFloat)(self.inputWidth  * pixelWidth)  / (CGFloat)self.inputHorizontalDivisor;
    pbounds.size.height = (CGFloat)(self.inputHeight * pixelHeight) / (CGFloat)self.inputVirticalDivisor;
    NSRect texRect;
    texRect.size.width  = self.inputWidth  / sc.size.width;
    texRect.size.height = self.inputHeight / sc.size.height;
    texRect.origin.x = self.inputX / sc.size.width;
    texRect.origin.y = self.inputY / sc.size.height;
  
    NSPoint anchor;
    anchor.x = bounds.origin.x + (self.inputAnchorX * pixelWidth);
    anchor.y = bounds.origin.y + (self.inputAnchorY * pixelHeight);
    
    for (int jj = 0; jj < self.inputVirticalDivisor; jj++)
    {
        NSMutableArray * hrline = [[NSMutableArray alloc] initWithCapacity:self.inputHorizontalDivisor];
        for (int ii = 0; ii < self.inputHorizontalDivisor; ii++)
        {
            BurstParticle * p = [[BurstParticle alloc] init];
            [p initializeWithXMinVelocity:self.inputXMinVelocity
                             XMaxVelocity:self.inputXMaxVelocity
                             YMinVeloxity:self.inputYMinVelocity
                             YMaxVelocity:self.inputYMaxVelocity
                             ZMinVeloxity:self.inputZMinVelocity
                             ZMaxVelocity:self.inputZMaxVelocity
                                  Gravity:self.inputGravity
                                   Anchor:anchor];
            NSPoint pos;
            pos.x = ii;
            pos.y = jj;
            [p initializeWithVertex:context
                           Position:pos
                               XDiv:self.inputHorizontalDivisor
                               YDiv:self.inputVirticalDivisor
                        TextureRect:texRect
                        polygonRect:pbounds];
            hrline[ii] = p;
        }
        _particles[jj] = hrline;
    }
}

- (BurstProgress) getProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputEndTime;
    NSTimeInterval CurrentTime = self.inputTime * 1000.0f;
    BurstProgress progress = {0.0f, 0.0f};
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            progress.progress = (CurrentTime - StartTime) / (EndTime - StartTime);
            progress.elapsed  = (CurrentTime - StartTime) / 1000.0f;
        }
        else
        if (CurrentTime > EndTime)
        {
            progress.progress = 1.0f;
            progress.elapsed  = (EndTime - StartTime) / 1000.0f;
        }
    }
    return progress;
}

- (void) movePeicesToNewPositions:(id <QCPlugInContext>)context
                         Progress:(BurstProgress)progress
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    
    for (int jj = 0; jj < self.inputVirticalDivisor; jj++)
    {
        NSMutableArray * ar = _particles[jj];
        for (int ii = 0; ii < self.inputHorizontalDivisor; ii++)
        {
            [ar[ii] moveToNewPosition:self.inputAttraction Progress:progress];
            [ar[ii] Mapping:cgl_ctx];
        }
    }
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
    id<QCPlugInInputImageSource> image = self.inputImage;
    GLuint textureName = 0;
    
    // Initialize
    if (image) {
        if ([image lockTextureRepresentationWithColorSpace:([image shouldColorMatch] ?  [context colorSpace] :
                                                            [image imageColorSpace])
                                                 forBounds:[image imageBounds]])
        {
            textureName = [image textureName];
        }
    }
    
    CGLContextObj cgl_ctx = [context CGLContextObj];
    CGLSetCurrentContext(cgl_ctx);
    
    // 現在の状態を保存
    GLint saveMode;
    glGetIntegerv(GL_MATRIX_MODE, &saveMode);
    GLboolean saveBlend;
    glGetBooleanv(GL_BLEND, &saveBlend);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    // ブレンド処理
    [self setBlendFunc:cgl_ctx];
    
    // 法線の正規化を開始
    glEnable(GL_NORMALIZE);
    
    // テクスチャをバインド
    if (textureName)
    {
        [image bindTextureRepresentationToCGLContext:cgl_ctx
                                         textureUnit:GL_TEXTURE0
                                normalizeCoordinates:YES];
    }
    
    // 画面表示クリア
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);

    // Get current Viewport
    GLint curViewPort[4];
    glGetIntegerv(GL_VIEWPORT, curViewPort);

    // 色設定を取得
    const CGFloat * colorComponents = CGColorGetComponents(self.inputColor);
    GLdouble red   = colorComponents[0];
    GLdouble green = colorComponents[1];
    GLdouble blue  = colorComponents[2];
    GLdouble alpha = colorComponents[3];
    
    // 描画
    BurstProgress progress = [self getProgress];
    
    if (progress.progress > 0.0f && progress.progress < 1.0f)     // 処理実行中
    {
        // パーティクルの準備
        NSRect sc = {curViewPort[0], curViewPort[1], curViewPort[2], curViewPort[3]};
        [self prepareParticles:context ScreenRect:sc];
        // 色設定
        glColor4f(red, green, blue, alpha);
        // ポリゴン描画
        glBegin(GL_QUADS);
            [self movePeicesToNewPositions:context Progress:progress];
        glEnd();
    }
    else
    if (progress.progress >= 1.0f)                       // 処理完了後
    {
        // パーティクルを破棄
        if (_particles)
        {
            NSUInteger max = [_particles count];
            for (int ii = 0; ii < max; ii++)
            {
                [_particles[ii] removeAllObjects];
            }
            [_particles removeAllObjects];
            _particles = nil;
        }
        // 何も描かない
        glColor4f(0.0f, 0.0f, 0.0f, 0.0f);
    }
    else                                        // 未処理
    {
        // 色設定
        glColor4f(red, green, blue, alpha);
        // 全体を描画
        NSRect bounds = [context bounds];
        GLdouble retio = (GLdouble) bounds.size.height / (GLdouble) bounds.size.width;
        glBegin(GL_QUADS);
            glTexCoord2d(1.0f, 1.0f);
            glVertex2d(OPENGL_POSRIGHT, retio * OPENGL_POSTOP);     // upper right
            glTexCoord2d(0.0f, 1.0f);
            glVertex2d(OPENGL_POSLEFT,  retio * OPENGL_POSTOP);     // upper left
            glTexCoord2d(0.0f, 0.0f);
            glVertex2d(OPENGL_POSLEFT,  retio * OPENGL_POSBOTTOM);  // lower left
            glTexCoord2d(1.0f, 0.0f);
            glVertex2d(OPENGL_POSRIGHT, retio * OPENGL_POSBOTTOM);  // lower right
        glEnd();
    }

    // Unbind the texture from the texture unit.
    if (textureName)
    {
        [image unbindTextureRepresentationFromCGLContext:cgl_ctx textureUnit: GL_TEXTURE0];
    }
    
    // 法線の正規化を終了
    glDisable(GL_NORMALIZE);
    
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
    // パーティクルを破棄
    if (_particles)
    {
        NSUInteger max = [_particles count];
        for (int ii = 0; ii < max; ii++)
        {
            [_particles[ii] removeAllObjects];
        }
        [_particles removeAllObjects];
        _particles = nil;
    }
}

@end

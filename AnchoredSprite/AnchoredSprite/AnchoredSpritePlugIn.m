//
//  AnchoredSpritePlugIn.m
//  AnchoredSprite
//
//  Created by Koichi MATSUMOTO on 2014/11/09.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>
#import <OpenGL/glu.h>

#import "AnchoredSpritePlugIn.h"

#define	kQCPlugIn_Name				@"AnchoredSprite"
#define	kQCPlugIn_Description		@"This patch allow to translate, scale and rotate the input image at the specified point."

static NSArray * blendOptions;

@implementation AnchoredSpritePlugIn

//
@dynamic inputImage;
@dynamic inputAnchorX;
@dynamic inputAnchorY;
@dynamic inputAnchorZ;
@dynamic inputDistX;
@dynamic inputDistY;
@dynamic inputDistZ;
@dynamic inputXAngle;
@dynamic inputYAngle;
@dynamic inputZAngle;
@dynamic inputXScale;
@dynamic inputYScale;
@dynamic inputZScale;
@dynamic inputColor;
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
                [NSNumber numberWithFloat:PDEF_INPUTANCHORX], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORY, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTANCHORY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORZ])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORZ, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTANCHORZ], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTDISTX])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTDISTX, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTDISTX], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTDISTY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTDISTY, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTDISTY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTDISTZ])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTDISTZ, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTDISTZ], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXANGLE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXANGLE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYANGLE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYANGLE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZANGLE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZANGLE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXSCALE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXSCALE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXSCALE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYSCALE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYSCALE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYSCALE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZSCALE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZSCALE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZSCALE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTCOLOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOR, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
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

@implementation AnchoredSpritePlugIn (Execution)

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
            glEnable(GL_BLEND);
    }
}

- (void)setDepthTest:(CGLContextObj) cgl_ctx
{
    GLboolean IsOriginDepthTest;
    glGetBooleanv(GL_DEPTH_TEST, &IsOriginDepthTest);

    if (self.inputDepthTest != None)
    {
        if (self.inputDepthTest == ReadWrite)
            glDepthMask(GL_TRUE);
        else
            glDepthMask(GL_FALSE);
        
        glEnable(GL_DEPTH_TEST);
    }
    else
    {
        glDisable(GL_DEPTH_TEST);
    }
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	/*
	Called by Quartz Composer whenever the plug-in instance needs to execute.
	Only read from the plug-in inputs and produce a result (by writing to the plug-in outputs or rendering to the destination OpenGL context) within that method and nowhere else.
	Return NO in case of failure during the execution (this will prevent rendering of the current frame to complete).
	
	The OpenGL context for rendering can be accessed and defined for CGL macros using:
     */
	CGLContextObj cgl_ctx = [context CGLContextObj];
    id<QCPlugInInputImageSource> image = self.inputImage;
    GLuint       textureName = 0;
    
    if(cgl_ctx == NULL)
        return NO;

    // Initialize
    if(image) {
         if ([image lockTextureRepresentationWithColorSpace:([image shouldColorMatch] ? [context colorSpace] :
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
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix();
    glLoadIdentity();

    // ブレンド処理
    [self setBlendFunc:cgl_ctx];

    // テクスチャをバインド
    if (textureName)
    {
        [image bindTextureRepresentationToCGLContext:cgl_ctx
                                         textureUnit:GL_TEXTURE0
                                normalizeCoordinates:YES];
    }
    
    // Create a new Viewport
    NSRect ibounds;
    GLint curViewPort[4];
    glGetIntegerv(GL_VIEWPORT, curViewPort);
    GLuint ix = curViewPort[0] + curViewPort[2] / 2;
    GLuint iy = curViewPort[1] + curViewPort[3] / 2;
    ibounds = [image imageBounds];
    ix -= ibounds.size.width  / 2;
    iy -= ibounds.size.height / 2;
    glViewport(ix, iy, ibounds.size.width, ibounds.size.height);

    // Translate the matrix
    GLdouble      x = self.inputAnchorX;
    GLdouble      y = self.inputAnchorY;
    GLdouble      z = self.inputAnchorZ;
    glTranslated(x, y, z);
    // Rotate the matrix
    GLdouble     ax = self.inputXAngle;
    GLdouble     ay = self.inputYAngle;
    GLdouble     az = self.inputZAngle;
    glRotated(ax, 1.0f, 0.0f, 0.0f);
    glRotated(ay, 0.0f, 1.0f, 0.0f);
    glRotated(az, 0.0f, 0.0f, 1.0f);
    // Set New Position
    GLdouble     ox = self.inputAnchorX * (-1.0f);
    GLdouble     oy = self.inputAnchorY * (-1.0f);
    GLdouble     oz = self.inputAnchorZ * (-1.0f);
    GLdouble     nx = self.inputDistX;
    GLdouble     ny = self.inputDistY;
    GLdouble     nz = self.inputDistZ;
    GLdouble     sx = self.inputXScale;
    GLdouble     sy = self.inputYScale;
    GLdouble     sz = self.inputZScale;
    glTranslated((ox * sx) + nx, (oy * sy) + ny, (oz * sz) + nz);
    // Scale the matrix
    glScaled(sx, sy, sz);
    
    // Render the textured quad by mapping the texture coordinates to the vertices
    NSRect       bounds;
    GLdouble     retio;
    bounds = [context bounds];
    retio = (bounds.size.height / bounds.size.width);
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);
        glVertex2d(1.0f, retio);            // upper right
        glTexCoord2d(0.0f, 1.0f);
        glVertex2d(-1.0f, retio);           // upper left
        glTexCoord2d(0.0f, 0.0f);
        glVertex2d(-1.0f, retio * (-1.0f)); // lower left
        glTexCoord2d(1.0f, 0.0f);
        glVertex2d(1.0f, retio * (-1.0f));  // lower right
    glEnd();
    
    // Set Color
    const CGFloat * colorComponents = CGColorGetComponents(self.inputColor);
    glColor4d(colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);

    // Restore original viewport
    glViewport(curViewPort[0], curViewPort[1], curViewPort[2], curViewPort[3]);

    if (textureName)
    {
        // Unbind the texture from the texture unit.
        [image unbindTextureRepresentationFromCGLContext:cgl_ctx textureUnit: GL_TEXTURE0];
    }

    // Restore
    glPopMatrix();
    glMatrixMode(saveMode);
    
    // エラーチェック
    GLenum       error;
    error = glGetError();
    if(error) {
        [context logMessage:@"OpenGL error %04X", error];
        return NO;
    }
    
    // テクスチャを破棄
    if(textureName)
        [image unlockTextureRepresentation];


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

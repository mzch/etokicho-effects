//
//  AnchoredSpritePlugIn.m
//  AnchoredSprite
//
//  Created by Koichi MATSUMOTO on 2014/11/09.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "AnchoredSpritePlugIn.h"

#define	kQCPlugIn_Name				@"AnchoredSprite"
#define	kQCPlugIn_Description		@"Translate, Scale and Rotate an input image at the specified point."

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
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTBLENDMOD, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTBLENDMOD], QCPortAttributeDefaultValueKey,
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

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	/*
	Called by Quartz Composer whenever the plug-in instance needs to execute.
	Only read from the plug-in inputs and produce a result (by writing to the plug-in outputs or rendering to the destination OpenGL context) within that method and nowhere else.
	Return NO in case of failure during the execution (this will prevent rendering of the current frame to complete).
	
	The OpenGL context for rendering can be accessed and defined for CGL macros using:
     */
    GLint         saveMode;
	CGLContextObj cgl_ctx = [context CGLContextObj];
    GLdouble      x = self.inputAnchorX;
    GLdouble      y = self.inputAnchorY;
    GLdouble      z = self.inputAnchorZ;
    GLdouble     ox = self.inputAnchorX * (-1.0f);
    GLdouble     oy = self.inputAnchorY * (-1.0f);
    GLdouble     oz = self.inputAnchorZ * (-1.0f);
    GLdouble     nx = self.inputDistX;
    GLdouble     ny = self.inputDistY;
    GLdouble     nz = self.inputDistZ;
    GLdouble     ax = self.inputXAngle;
    GLdouble     ay = self.inputYAngle;
    GLdouble     az = self.inputZAngle;
    GLdouble     sx = self.inputXScale;
    GLdouble     sy = self.inputYScale;
    GLdouble     sz = self.inputZScale;
    GLenum       error;
    GLdouble     retio;
    id<QCPlugInInputImageSource> image = self.inputImage;
    const CGFloat * colorComponents = CGColorGetComponents(self.inputColor);
    NSRect       bounds;
    GLuint       textureName = 0;

    if(cgl_ctx == NULL)
        return NO;

    //
    if(image) {
         if ([image lockTextureRepresentationWithColorSpace:([image shouldColorMatch] ? [context colorSpace] :
                                                                                        [image imageColorSpace])
                                                     forBounds:[image imageBounds]])
         {
             textureName = [image textureName];
         }
    }
    // Save and set the modelview matrix.
    glGetIntegerv(GL_MATRIX_MODE, &saveMode);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    // Color mode
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_BLEND);  //ブレンド有効化
    //
    glPushMatrix();
    // Translate the matrix
    glTranslated(x, y, z);
    // Rotate the matrix
    glRotated(ax, 1.0f, 0.0f, 0.0f);
    glRotated(ay, 0.0f, 1.0f, 0.0f);
    glRotated(az, 0.0f, 0.0f, 1.0f);
    // Set New Position
    glTranslated((ox * sx) + nx, (oy * sy) + ny, (oz * sz) + nz);
    // Scale the matrix
    glScaled(sx, sy, sz);

    if (textureName)
    {
        [image bindTextureRepresentationToCGLContext:cgl_ctx
                                         textureUnit:GL_TEXTURE0
                                normalizeCoordinates:YES];
    }

    // ブレンド処理
     switch (self.inputBlendMode)
     {
     case CLR_BLEND_ALPHA:          // ― アルファブレンド
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        break;
     case CLR_BLEND_ADD:            // ― 加算合成
        glBlendFunc(GL_SRC_ALPHA, GL_ONE);
        break;
     case CLR_BLEND_MULTI:          // ― 乗算合成
        glBlendFunc(GL_ZERO, GL_SRC_COLOR);
        break;
     case CLR_BLAND_INVERT:         // ― 反転合成
        glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ZERO);
        break;
     case CLR_BLEND_SCREEN:         // ― スクリーン合成
        glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE);
        break;
     case CLR_BLEND_XOR:            // ― 排他的論理和合成
        glBlendFunc(GL_ONE_MINUS_DST_COLOR, GL_ONE_MINUS_SRC_COLOR);
        break;
     default:
        glBlendFunc(GL_ONE, GL_ZERO);
        break;
     }

    // Set the color.
    glColor4d(colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);
    
    // Render the textured quad by mapping the texture coordinates to the vertices
    bounds = [context bounds];
    retio = (bounds.size.height / bounds.size.width);
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);
        glVertex3d(1.0f, retio, 0.0f);    // upper right
        glTexCoord2d(0.0f, 1.0f);
        glVertex3d(-1.0f, retio, 0.0f);   // upper left
        glTexCoord2d(0.0f, 0.0f);
        glVertex3d(-1.0f, retio * (-1.0f), 0.0f);  // lower left
        glTexCoord2d(1.0f, 0.0f);
        glVertex3d(1.0f, retio * (-1.0f), 0.0f);   // lower right
    glEnd();
    
    glFlush();
    
    if (textureName)
    {
        // Unbind the texture from the texture unit.
        [image unbindTextureRepresentationFromCGLContext:cgl_ctx textureUnit: GL_TEXTURE0];
    }

    glDisable(GL_BLEND);  //ブレンド無効化

    // Restore
    glMatrixMode(GL_MODELVIEW);
    glPopMatrix();
    glMatrixMode(saveMode);
    
    // Check for OpenGL errors and log them if there are errors.
    error = glGetError();
    if(error) {
        [context logMessage:@"OpenGL error %04X", error];
        return NO;
    }
    
    // Release the texture.
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

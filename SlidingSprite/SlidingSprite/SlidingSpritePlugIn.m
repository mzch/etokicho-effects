//
//  SlidingSpritePlugIn.m
//  SlidingSprite
//
//  Created by Koichi MATSUMOTO on 2014/12/17.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>
#import <OpenGL/glu.h>
#import <GLKit/GLKit.h>

#import "SlidingSpritePlugIn.h"

#define	kQCPlugIn_Name				@"SlidingSprite"
#define	kQCPlugIn_Description		@"Slide in/out, scale and spin a specified image on the screen."

static NSArray * blendOptions;
static NSArray * jumpOptions;

@implementation SlidingSpritePlugIn

@dynamic inputImage;
@dynamic inputAnchorX;
@dynamic inputAnchorY;
@dynamic inputXPosStart;
@dynamic inputYPosStart;
@dynamic inputZPosStart;
@dynamic inputXPosEnd;
@dynamic inputYPosEnd;
@dynamic inputZPosEnd;
@dynamic inputStartTime;
@dynamic inputEndTime;
@dynamic inputColorStart;
@dynamic inputColorEnd;
@dynamic inputFadeStartTime;
@dynamic inputFadeEndTime;
@dynamic inputXScaleStart;
@dynamic inputYScaleStart;
@dynamic inputZScaleStart;
@dynamic inputXScaleEnd;
@dynamic inputYScaleEnd;
@dynamic inputZScaleEnd;
@dynamic inputScaleStartTime;
@dynamic inputScaleEndTime;
@dynamic inputBounce;
@dynamic inputXLead;
@dynamic inputYLead;
@dynamic inputZLead;
@dynamic inputJumpStartTime;
@dynamic inputJumpEndTime;
@dynamic inputBehavior;
@dynamic inputXAxis;
@dynamic inputYAxis;
@dynamic inputZAxis;
@dynamic inputXAngleStart;
@dynamic inputYAngleStart;
@dynamic inputZAngleStart;
@dynamic inputIsXSpin;
@dynamic inputIsYSpin;
@dynamic inputIsZSpin;
@dynamic inputXAngleEnd;
@dynamic inputYAngleEnd;
@dynamic inputZAngleEnd;
@dynamic inputSpinStartTime;
@dynamic inputSpinEndTime;
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
                [NSNumber numberWithFloat:PDEF_INPUTANCHORX], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORY, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTANCHORY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXPOSSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXPOSSTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYPOSSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYPOSSTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZPOSSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZPOSSTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXPOSEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXPOSEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYPOSEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYPOSEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZPOSEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZPOSEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZPOSITION], QCPortAttributeDefaultValueKey,
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
    if ([key isEqualToString:PKEY_INPUTCOLORSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLORSTART, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTCOLOREND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTCOLOREND, QCPortAttributeNameKey,
                PDEF_INPUTCOLOR, QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFADESTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADESTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTFADEENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTFADEENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXSCALESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXSCALESTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYSCALESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYSCALESTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZSCALESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZSCALESTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXSCALEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXSCALEEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYSCALEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYSCALEEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZSCALEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZSCALEEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSCALESTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSCALESTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSCALEENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSCALEENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
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
                [NSNumber numberWithFloat:PDEF_INPUTLEAD], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYLEAD])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYLEAD, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTLEAD], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZLEAD])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZLEAD, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTLEAD], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTJUMPSTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTJUMPSTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTJUMPENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTJUMPENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTBEHAVIOR])
    {
        jumpOptions = [NSArray arrayWithObjects:JUMP_ARC, JUMP_WALK, JUMP_QUAD, nil];
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTBEHAVIOR, QCPortAttributeNameKey,
                jumpOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTBEHAVIOR], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTBEHAVIOR], QCPortAttributeMaximumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTXAXIS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXAXIS, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXAXIS], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTXAXIS], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithFloat:PMAX_INPUTXAXIS], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYAXIS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYAXIS, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYAXIS], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTYAXIS], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithFloat:PMAX_INPUTYAXIS], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZAXIS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZAXIS, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZAXIS], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithFloat:PMIN_INPUTZAXIS], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithFloat:PMAX_INPUTZAXIS], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXANGLESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXANGLESTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYANGLESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYANGLESTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZANGLESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZANGLESTART, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTISXSPIN])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTISXSPIN, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTISXSPIN], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTISYSPIN])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTISYSPIN, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTISYSPIN], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTISZSPIN])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTISZSPIN, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTISZSPIN], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXANGLEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXANGLEEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTXANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYANGLEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYANGLEEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTYANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZANGLEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZANGLEEND, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTZANGLE], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSPINSTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSPINSTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSPINENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSPINENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSETIME], QCPortAttributeMinimumValueKey,
                nil];
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
        _X_distance = 0.0f;
        _Y_distance = 0.0f;
        _Z_distance = 0.0f;
        _X_rotation = 0.0f;
        _Y_rotation = 0.0f;
        _Z_rotation = 0.0f;
        _X_scale    = 0.0f;
        _Y_scale    = 0.0f;
        _Z_scale    = 0.0f;
        _Red        = 1.0f;
        _Green      = 1.0f;
        _Blue       = 1.0f;
        _Alpha      = 1.0f;
        _JumpDuration = 0;
	}
	
	return self;
}


@end

@implementation SlidingSpritePlugIn (Execution)

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

- (BOOL)setupExecute
{
    // 変化量を求める
    _X_distance = self.inputXPosEnd - self.inputXPosStart;
    _Y_distance = self.inputYPosEnd - self.inputYPosStart;
    _Z_distance = self.inputZPosEnd - self.inputZPosStart;

    const CGFloat * colorStart = CGColorGetComponents(self.inputColorStart);
    const CGFloat * colorEnd   = CGColorGetComponents(self.inputColorEnd);
    _Red   = colorEnd[0] - colorStart[0];
    _Green = colorEnd[1] - colorStart[1];
    _Blue  = colorEnd[2] - colorStart[2];
    _Alpha = colorEnd[3] - colorStart[3];

    _X_scale = self.inputXScaleEnd - self.inputXScaleStart;
    _Y_scale = self.inputYScaleEnd - self.inputYScaleStart;
    _Z_scale = self.inputZScaleEnd - self.inputZScaleStart;

    if (self.inputIsXSpin)
        _X_rotation = self.inputXAngleEnd * 360.0f;
    else
        _X_rotation = self.inputXAngleEnd - self.inputXAngleStart;
    if (self.inputIsYSpin)
        _Y_rotation = self.inputYAngleEnd * 360.0f;
    else
        _Y_rotation = self.inputYAngleEnd - self.inputYAngleStart;
    if (self.inputIsZSpin)
        _Z_rotation = self.inputZAngleEnd * 360.0f;
    else
        _Z_rotation = self.inputZAngleEnd - self.inputZAngleStart;

    if (self.inputJumpEndTime > self.inputJumpStartTime && self.inputBounce > 0)
        _JumpDuration = (self.inputJumpEndTime - self.inputJumpStartTime) / self.inputBounce;
    else
        _JumpDuration = 0;

    return YES;
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

- (GLdouble) getSlideProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputEndTime;
    NSTimeInterval CurrentTime = self.inputTime * 1000.0f;
    GLdouble progress = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            progress = (CurrentTime - StartTime) / (EndTime - StartTime);
        }
        else
        {
            progress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    else
    {
        progress = 0.0f;
    }
    return progress;
}

- (GLdouble) getFadeProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputFadeStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputFadeEndTime;
    NSTimeInterval CurrentTime = self.inputTime * 1000.0f;
    GLdouble progress = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            progress = (CurrentTime - StartTime) / (EndTime - StartTime);
        }
        else
        {
            progress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    else
    {
        progress = 0.0f;
    }
    return progress;
}

- (GLdouble) getScaleProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputScaleStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputScaleEndTime;
    NSTimeInterval CurrentTime = self.inputTime * 1000.0f;
    GLdouble progress = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            progress = (CurrentTime - StartTime) / (EndTime - StartTime);
        }
        else
        {
            progress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    else
    {
        progress = 0.0f;
    }
    return progress;
}

- (GLdouble) getSpinProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputSpinStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputSpinEndTime;
    NSTimeInterval CurrentTime = self.inputTime * 1000.0f;
    GLdouble progress = 0.0f;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            progress = (CurrentTime - StartTime) / (EndTime - StartTime);
        }
        else
        {
            progress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    else
    {
        progress = 0.0f;
    }
    return progress;
}

- (SSDistance) getJumpLead
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputJumpStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputJumpEndTime;
    NSTimeInterval CurrentTime = self.inputTime * 1000.0f;
    SSDistance jump = {0.0f, 0.0f, 0.0f};
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            if (_JumpDuration > 0)
            {
                NSUInteger JumpCounter = (CurrentTime - StartTime) / _JumpDuration;
                double JumpRadian = (CurrentTime - (JumpCounter * _JumpDuration)) / 1000.0f;
                
                switch (self.inputBehavior)
                {
                    case ClrJumpBehavior_Quad:
                        jump.x = pow(JumpRadian, 2) * self.inputXLead;
                        jump.y = pow(JumpRadian, 2) * self.inputYLead;
                        jump.z = pow(JumpRadian, 2) * self.inputZLead;
                        break;
                    case ClrJumpBehavior_Walk:
                        jump.x = log(JumpRadian + 1.0f) * self.inputXLead;
                        jump.y = log(JumpRadian + 1.0f) * self.inputYLead;
                        jump.z = log(JumpRadian + 1.0f) * self.inputZLead;
                        break;
                    case ClrJumpBehavior_Arc:
                    default:
                        JumpRadian *= M_PI;
                        jump.x = sin(JumpRadian) * self.inputXLead;
                        jump.y = sin(JumpRadian) * self.inputYLead;
                        jump.z = sin(JumpRadian) * self.inputZLead;
                        break;
                }
            }
        }
    }
    
    return jump;
}

- (void)drawTexture:(id <QCPlugInContext>)context
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    
    // Translate the matrix
    GLdouble progress = [self getSlideProgress];
    GLdouble      x = self.inputAnchorX + (_X_distance * progress);
    GLdouble      y = self.inputAnchorY + (_Y_distance * progress);
    glTranslated(x, y, 0.0f);

    // Rotate the matrix
    GLdouble spin_progress = [self getSpinProgress];
    GLdouble     ax = self.inputXAngleStart + (_X_rotation * spin_progress);
    GLdouble     ay = self.inputYAngleStart + (_Y_rotation * spin_progress);
    GLdouble     az = self.inputZAngleStart + (_Z_rotation * spin_progress);
    GLfloat   rad_x = GLKMathDegreesToRadians((float) self.inputXAxis);
    GLfloat   rad_y = GLKMathDegreesToRadians((float) self.inputYAxis);
    GLfloat   rad_z = GLKMathDegreesToRadians((float) self.inputZAxis);
    GLfloat   vec_x = cos(rad_y) * cos(rad_z);
    GLfloat   vec_y = (sin(rad_x) * sin(rad_y) * cos(rad_z)) - (cos(rad_x) * sin(rad_z));
    GLfloat   vec_z = (cos(rad_x) * sin(rad_y) * cos(rad_z)) + (sin(rad_y) * sin(rad_z));
    glRotated(ax, vec_x, vec_y, vec_z);
    vec_x = cos(rad_y) * sin(rad_z);
    vec_y = (sin(rad_x) * sin(rad_y) * sin(rad_z)) + (cos(rad_x) * cos(rad_z));
    vec_z = (cos(rad_x) * sin(rad_y) * sin(rad_z)) - (sin(rad_x) * cos(rad_z));
    glRotated(ay, vec_x, vec_y, vec_z);
    vec_x = (-1.0f) * sin(rad_y);
    vec_y = sin(rad_x) * cos(rad_y);
    vec_z = cos(rad_x) * cos(rad_y);
    glRotated(az, vec_x, vec_y, vec_z);

    // Scale the matrix
    GLdouble scale_progress = [self getScaleProgress];
    GLdouble     sx = self.inputXScaleStart + (_X_scale * scale_progress);
    GLdouble     sy = self.inputYScaleStart + (_Y_scale * scale_progress);
    GLdouble     sz = self.inputZScaleStart + (_Z_scale * scale_progress);
    glScaled(sx, sy, sz);

    // Set New Position
    SSDistance jump = [self getJumpLead];
    GLdouble     nx = self.inputXPosStart + (_X_distance * progress) + jump.x;
    GLdouble     ny = self.inputYPosStart + (_Y_distance * progress) + jump.y;
    GLdouble     nz = self.inputZPosStart + (_Z_distance * progress) + jump.z;
    glTranslated((nx - x) * sx, (ny - y) * sy, nz * sz);
    
    // Set Color
    const CGFloat * colorComponents = CGColorGetComponents(self.inputColorStart);
    GLdouble fade_progress = [self getFadeProgress];
    GLdouble red   = colorComponents[0] + (_Red   * fade_progress);
    GLdouble green = colorComponents[1] + (_Green * fade_progress);
    GLdouble blue  = colorComponents[2] + (_Blue  * fade_progress);
    GLdouble alpha = colorComponents[3] + (_Alpha * fade_progress);
    glColor4f(red, green, blue, alpha);

    // Render the textured quad by mapping the texture coordinates to the vertices
    NSRect bounds = [context bounds];
    GLdouble retio = (GLdouble) bounds.size.height / (GLdouble) bounds.size.width;
    GLdouble Vertex = 2.0f;
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);
        glVertex2d(Vertex, retio * Vertex);                     // upper right
        glTexCoord2d(-1.0f, 1.0f);
        glVertex2d(Vertex * -1.0f, retio * Vertex);             // upper left
        glTexCoord2d(-1.0f, -1.0f);
        glVertex2d(Vertex * -1.0f, retio * Vertex * (-1.0f));   // lower left
        glTexCoord2d(1.0f, -1.0f);
        glVertex2d(Vertex, retio * Vertex * (-1.0f));           // lower right
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
    
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Get current Viewport
    GLint curViewPort[4];
    glGetIntegerv(GL_VIEWPORT, curViewPort);
    // Create a new Viewport
    GLuint ix = curViewPort[0] + curViewPort[2] / 2;
    GLuint iy = curViewPort[1] + curViewPort[3] / 2;
    NSRect ibounds = [image imageBounds];
    ix -= ibounds.size.width  / 2;
    iy -= ibounds.size.height / 2;
    // ビューを設定
    glViewport(ix, iy, ibounds.size.width, ibounds.size.height);
   
    // 初期設定
    [self setupExecute];
    
    // テクスチャを描画
    [self drawTexture:context];
    
    // 元のビューを設定
    glViewport(curViewPort[0], curViewPort[1], curViewPort[2], curViewPort[3]);

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
    // Restore original viewport
}

@end

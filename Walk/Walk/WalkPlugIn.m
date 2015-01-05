//
//  WalkPlugIn.m
//  Walk
//
//  Created by Koichi MATSUMOTO on 2015/01/05.
//  Copyright (c) 2015 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>
#import <OpenGL/glu.h>
#import <GLKit/GLKit.h>

#import "WalkPlugIn.h"

#define	kQCPlugIn_Name				@"Walk"
#define	kQCPlugIn_Description		@"This patch provide an image with walking-effect."

static NSArray * blendOptions;
static NSArray * slideOptions;
static NSArray * swingOptions;
static NSArray * fadeOptions;

@implementation WalkPlugIn

@dynamic inputImage;
@dynamic inputAnchorX;
@dynamic inputAnchorY;
@dynamic inputXPosStart;
@dynamic inputYPosStart;
@dynamic inputZPosStart;
@dynamic inputXPosEnd;
@dynamic inputYPosEnd;
@dynamic inputZPosEnd;
@dynamic inputSwing;
@dynamic inputRoll;
@dynamic inputPitch;
@dynamic inputDuration;
@dynamic inputSwingOpt;
@dynamic inputStartTime;
@dynamic inputEndTime;
@dynamic inputXOption;
@dynamic inputYOption;
@dynamic inputZOption;
@dynamic inputColor1;
@dynamic inputColor2;
@dynamic inputColor3;
@dynamic inputFadeInStart;
@dynamic inputFadeInEnd;
@dynamic inputFadeInOpt;
@dynamic inputFadeOutStart;
@dynamic inputFadeOutEnd;
@dynamic inputFadeOutOpt;
@dynamic inputXScaleStart;
@dynamic inputYScaleStart;
@dynamic inputZScaleStart;
@dynamic inputXScaleEnd;
@dynamic inputYScaleEnd;
@dynamic inputZScaleEnd;
@dynamic inputScaleStartTime;
@dynamic inputScaleEndTime;
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
                nil];
    if ([key isEqualToString:PKEY_INPUTANCHORY])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTANCHORY, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTANCHORY], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXPOSSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXPOSSTART, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYPOSSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYPOSSTART, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTYPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZPOSSTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZPOSSTART, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTZPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXPOSEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXPOSEND, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYPOSEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYPOSEND, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTYPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZPOSEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZPOSEND, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTZPOSITION], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSWING])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSWING, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTSWING], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSWING], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTSWING], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTROLL])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTROLL, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTROLL], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTROLL], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTPITCH])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTPITCH, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTPITCH], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTPITCH], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTDURATION])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTDURATION, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTDURATION], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PMIN_INPUTDURATION], QCPortAttributeMinimumValueKey,
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
    slideOptions = [NSArray arrayWithObjects:OPT_NAME_CONSTANT, OPT_NAME_ACCELARATE, OPT_NAME_DECELARATE, nil];
    if ([key isEqualToString:PKEY_INPUTXOPTION])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXOPTION, QCPortAttributeNameKey,
                slideOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTOPTION], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTOPTION], QCPortAttributeMaximumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTYOPTION])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYOPTION, QCPortAttributeNameKey,
                slideOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTOPTION], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTOPTION], QCPortAttributeMaximumValueKey,
                nil];
    }
    if ([key isEqualToString:PKEY_INPUTZOPTION])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZOPTION, QCPortAttributeNameKey,
                slideOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTOPTION], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTOPTION], QCPortAttributeMaximumValueKey,
                nil];
    }
    swingOptions = [NSArray arrayWithObjects:SWING_NAME_NORMAL, SWING_NAME_HOP, SWING_NAME_RUNNING, SWING_NAME_SKIP, SWING_NAME_STAGGERED, nil];
    if ([key isEqualToString:PKEY_INPUTSWINGOPT])
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSWINGOPT, QCPortAttributeNameKey,
                swingOptions, QCPortAttributeMenuItemsKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTSWINGOPT], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithUnsignedInteger:PMAX_INPUTSWINGOPT], QCPortAttributeMaximumValueKey,
                nil];
    }
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
    if ([key isEqualToString:PKEY_INPUTXSCALESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXSCALESTART, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYSCALESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYSCALESTART, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTYSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZSCALESTART])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZSCALESTART, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTZSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXSCALEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXSCALEEND, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTXSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYSCALEEND])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYSCALEEND, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTYSCALE], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSCALE],  QCPortAttributeMinimumValueKey,
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

@implementation WalkPlugIn (Execution)

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

- (void)setupExecute:(id <QCPlugInContext>)context ScreenSpec:(NSRect)scspec
{
    NSRect bounds = [context bounds];
    
    double pixelWidth  = bounds.size.width  / scspec.size.width;
    double pixelHeight = bounds.size.height / scspec.size.height;
    
    _xAnchor   = bounds.origin.x + (pixelWidth  * self.inputAnchorX);
    _yAnchor   = bounds.origin.y + (pixelHeight * self.inputAnchorY);
    
    _xPosStart = bounds.origin.x + (pixelWidth  * self.inputXPosStart);
    _yPosStart = bounds.origin.y + (pixelHeight * self.inputYPosStart);
    _zPosStart = (self.inputZPosStart * pixelWidth);
    
    _xPosEnd   = bounds.origin.x + (pixelWidth  * self.inputXPosEnd);
    _yPosEnd   = bounds.origin.y + (pixelHeight * self.inputYPosEnd);
    _zPosEnd   = (self.inputZPosEnd * pixelWidth);
    
    _Roll      = pixelWidth * self.inputRoll;
    _Pitch     = pixelHeight * self.inputPitch;
    
    _X_distance = _xPosEnd - _xPosStart;
    _Y_distance = _yPosEnd - _yPosStart;
    _Z_distance = _zPosEnd - _zPosStart;

    _SwingStart  = self.inputSwing;
    _SwingEnd    = self.inputSwing * (-1.0f);
    
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
    
    _X_scale = (self.inputXScaleEnd - self.inputXScaleStart) / PERCENTAGE;
    _Y_scale = (self.inputYScaleEnd - self.inputYScaleStart) / PERCENTAGE;
    _Z_scale = (self.inputZScaleEnd - self.inputZScaleStart) / PERCENTAGE;
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

- (SSProgress) getSlideProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputEndTime;
    NSTimeInterval CurrentTime = self.inputTime * MILISECPERSEC;
    SSProgress progress = {0.0f, 0.0f, 0.0f};
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            GLdouble t   = CurrentTime - StartTime;
            GLdouble max = EndTime - StartTime;
            switch (self.inputXOption) {
                case Slide_Accelarate:
                    progress.x = ((t + 1) * t / 2.0) / ((max + 1) * max / 2.0);
                    break;
                case Slide_Decelarate:
                    progress.x = ((max * 2 - t + 1) * t / 2.0) / ((max + 1) * max / 2.0);
                    break;
                default:
                    progress.x = t / max;
                    break;
            }
            switch (self.inputYOption) {
                case Slide_Accelarate:
                    progress.y = ((t + 1) * t / 2.0) / ((max + 1) * max / 2.0);
                    break;
                case Slide_Decelarate:
                    progress.y = ((max * 2 - t + 1) * t / 2.0) / ((max + 1) * max / 2.0);
                    break;
                default:
                    progress.y = t / max;
                    break;
            }
            switch (self.inputZOption) {
                case Slide_Accelarate:
                    progress.z = ((t + 1) * t / 2.0) / ((max + 1) * max / 2.0);
                    break;
                case Slide_Decelarate:
                    progress.z = ((max * 2 - t + 1) * t / 2.0) / ((max + 1) * max / 2.0);
                    break;
                default:
                    progress.z = t / max;
                    break;
            }
        }
        else
        {
            GLdouble p = (CurrentTime > EndTime) ? 1.0f : 0.0f;
            progress.x = progress.y = progress.z = p;
        }
    }
    return progress;
}

- (SSSwing) getSwingProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputEndTime;
    NSTimeInterval CurrentTime = self.inputTime * MILISECPERSEC;
    SSSwing progress = {0.0f, 0.0f, 0.0f};
    
    if (self.inputDuration > 0 && EndTime > StartTime)
    {
        double dur  = fmod(((double)(CurrentTime - StartTime) / (double) self.inputDuration), 1.0f);
        NSUInteger cur = (NSUInteger) CurrentTime - StartTime;
        BOOL sign = (cur / self.inputDuration) % 2 ? YES : NO;

        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            if (sign)
            {
                progress.deg  = _SwingStart * sin(dur * M_PI);
            }
            else
            {
                progress.deg = _SwingEnd * sin(dur * M_PI);
            }
            switch (self.inputSwingOpt) {
                case Swing_Staggered:
                    if (progress.deg < 0.0f)
                        progress.roll = _Roll * pow(sin(dur * M_PI), 3) * 2.0f;
                    else
                        progress.roll = _Roll * pow(sin(dur * M_PI), 3) * (-2.0f);
                    progress.pitch = fabs(_Pitch * pow(sin(dur * M_PI), 3)) * (-2.0f);
                    break;
                case Swing_Skip:
                    if (progress.deg < 0.0f)
                        progress.roll = _Roll * sin(dur * M_PI);
                    else
                        progress.roll = _Roll * sin(dur * M_PI) * (-1.0f);
                    progress.pitch = fabs(_Pitch * sin(dur * M_PI));
                    progress.deg = 0.0f;
                    break;
                case Swing_Running:
                    if (progress.deg < 0.0f)
                        progress.roll = _Roll * sin(dur * M_PI);
                    else
                        progress.roll = _Roll * sin(dur * M_PI) * (-1.0f);
                    progress.pitch = fabs(_Pitch * sin(dur * M_PI)) * (-1.0f);
                    progress.deg = 0.0f;
                    break;
                case Swing_Hop:
                    progress.pitch = fabs(_Pitch * sin(dur * M_PI));
                    if (progress.deg < 0.0f)
                        progress.roll = _Roll * sin(dur * M_PI);
                    else
                        progress.roll = _Roll * sin(dur * M_PI) * (-1.0f);
                    break;
                default:
                    progress.pitch = fabs(_Pitch * sin(dur * M_PI)) * (-1.0f);
                    if (progress.deg < 0.0f)
                        progress.roll = _Roll * sin(dur * M_PI);
                    else
                        progress.roll = _Roll * sin(dur * M_PI) * (-1.0f);
                    break;
            }
        }
    }
    return progress;
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

- (GLdouble) getScaleProgress
{
    NSTimeInterval StartTime   = (NSTimeInterval) self.inputScaleStartTime;
    NSTimeInterval EndTime     = (NSTimeInterval) self.inputScaleEndTime;
    NSTimeInterval CurrentTime = self.inputTime * MILISECPERSEC;
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
    return progress;
}

- (void)drawTexture:(id <QCPlugInContext>)context aTime:(NSTimeInterval)current ScreenSpec:(NSRect)scSpec
{
    CGLContextObj cgl_ctx = [context CGLContextObj];
    
    // move the image to the center
    SSProgress progress = [self getSlideProgress];
    NSRect bounds = [context bounds];
    GLdouble x = _xPosStart + (_X_distance * progress.x);
    GLdouble y = _yPosStart + (_Y_distance * progress.y);
    glTranslated(x, y, 0.0f);
    
    // Rotate the matrix
    SSSwing swing_progress = [self getSwingProgress];
    glRotated(swing_progress.deg, 0.0f, 0.0f, 1.0f);

#if 0
    GLdouble     ax = self.inputXAngleStart + (_X_rotation * spin_progress);
    GLdouble     ay = self.inputYAngleStart + (_Y_rotation * spin_progress);
    GLdouble     az = self.inputZAngleStart + (_Z_rotation * spin_progress);    SSProgress progress = [self getSlideProgress];
    NSRect bounds = [context bounds];
    GLdouble x = _xPosStart + (_X_distance * progress.x);
    GLdouble y = _yPosStart + (_Y_distance * progress.y);
    glTranslated(x, y, 0.0f);

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
#endif

    // Scale the matrix
    GLdouble scale_progress = [self getScaleProgress];
    GLdouble     sx = (self.inputXScaleStart / PERCENTAGE) + (_X_scale * scale_progress);
    GLdouble     sy = (self.inputYScaleStart / PERCENTAGE) + (_Y_scale * scale_progress);
    GLdouble     sz = (self.inputZScaleStart / PERCENTAGE) + (_Z_scale * scale_progress);
    glScaled(sx, sy, sz);
    
    // Set the original position
    glTranslated(-x, -y, 0.0f);
    
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
    // New Position
    GLdouble     nx = (bounds.origin.x + _xPosStart - _xAnchor + (_X_distance * progress.x)) + swing_progress.roll;
    GLdouble     ny = (bounds.origin.y + _yPosStart - _yAnchor + (_Y_distance * progress.y)) + swing_progress.pitch;
    GLdouble     nz = (_zPosStart + (_Z_distance * progress.z));
    
    // Render the textured quad by mapping the texture coordinates to the vertices
    glBegin(GL_QUADS);
        glTexCoord2d(1.0f, 1.0f);       // upper right
        glVertex3d(nx + bounds.size.width, ny + bounds.size.height, nz);
        glTexCoord2d(0.0f, 1.0f);       // upper left
        glVertex3d(nx,                     ny + bounds.size.height, nz);
        glTexCoord2d(0.0f, 0.0f);       // lower left
        glVertex3d(nx,                     ny,                      nz);
        glTexCoord2d(1.0f, 0.0f);       // lower right
        glVertex3d(nx + bounds.size.width, ny,                      nz);
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
    [self drawTexture:context aTime:time ScreenSpec:scsize];
    
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

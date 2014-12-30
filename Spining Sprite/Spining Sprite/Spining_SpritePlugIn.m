//
//  Spining_SpritePlugIn.m
//  Spining Sprite
//
//  Created by Koichi MATSUMOTO on 2014/12/30.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>
#import <OpenGL/glu.h>
#import <GLKit/GLKit.h>

#import "Spining_SpritePlugIn.h"

#define	kQCPlugIn_Name				@"Spining Sprite"
#define	kQCPlugIn_Description		@"Spin the specified image."

// Static array variables
static NSArray * blendOptions;

@implementation Spining_SpritePlugIn

@dynamic inputImage;
@dynamic inputAnchorX;
@dynamic inputAnchorY;
@dynamic inputXAxis;
@dynamic inputYAxis;
@dynamic inputZAxis;
@dynamic inputXSpeed;
@dynamic inputXAccel;
@dynamic inputYSpeed;
@dynamic inputYAccel;
@dynamic inputZSpeed;
@dynamic inputZAccel;
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
    if ([key isEqualToString:PKEY_INPUTXSPEED])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXSPEED, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTSPEED], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSPEED], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTSPEED], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYSPEED])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYSPEED, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTSPEED], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSPEED], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTSPEED], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZSPEED])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZSPEED, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTSPEED], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTSPEED], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTSPEED], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTXACCEL])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTXACCEL, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTACCEL], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTACCEL], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTACCEL], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTYACCEL])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTYACCEL, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTACCEL], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTACCEL], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTACCEL], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTZACCEL])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTZACCEL, QCPortAttributeNameKey,
                [NSNumber numberWithDouble:PDEF_INPUTACCEL], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithDouble:PMIN_INPUTACCEL], QCPortAttributeMinimumValueKey,
                [NSNumber numberWithDouble:PMAX_INPUTACCEL], QCPortAttributeMaximumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTSTARTTIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTSTARTTIME], QCPortAttributeMinimumValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithInteger:PDEF_INPUTENDTIME], QCPortAttributeDefaultValueKey,
                [NSNumber numberWithInteger:PDEF_INPUTENDTIME], QCPortAttributeMinimumValueKey,
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
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	// Return the execution mode of the plug-in: kQCPlugInExecutionModeProvider, kQCPlugInExecutionModeProcessor, or kQCPlugInExecutionModeConsumer.
	return kQCPlugInExecutionModeProcessor;
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

@implementation Spining_SpritePlugIn (Execution)

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
	CGLContextObj cgl_ctx = [context CGLContextObj];
	*/
	
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

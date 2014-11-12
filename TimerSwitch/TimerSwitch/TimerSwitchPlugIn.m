//
//  TimerSwitchPlugIn.m
//  TimerSwitch
//
//  Created by Koichi MATSUMOTO on 2014/11/11.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "TimerSwitchPlugIn.h"

#define	kQCPlugIn_Name				@"TimerSwitch"
#define	kQCPlugIn_Description		@"This patch outputs time left in seconds and mili seconds, in addition, a boolean value, YES if in time.\nIn case of specifying \"Start Time\" is greater than 0, this will continue to output 0 and NO until Patch time reaches \"Start Time\".\nWhile Patch time is greater than \"Start Time\" and less than \"End Time\", this patch will continue to output time left and YES.\nAfter \"End Time\" goes on, This will continue to output 0 and NO again."

@implementation TimerSwitchPlugIn

@dynamic inputCurrentTime;
@dynamic inputStartTime;
@dynamic inputEndTime;
@dynamic outputTimeLeft;
@dynamic outputMiliTimeLeft;
@dynamic outputProgress;
@dynamic outputIsInTime;

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
    if ([key isEqualToString:PKEY_INPUTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PDEF_INPUTTIME],  QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTSTARTTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTSTARTTIME, QCPortAttributeNameKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTSTARTTIME], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_INPUTENDTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_INPUTENDTIME, QCPortAttributeNameKey,
                [NSNumber numberWithUnsignedInteger:PDEF_INPUTENDTIME], QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PKEY_OUTPUTTIMELEFT])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_OUTPUTTIMELEFT, QCPortAttributeNameKey,
                nil];
    if ([key isEqualToString:PKEY_OUTPUTMTIMELEFT])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_OUTPUTMTIMELEFT, QCPortAttributeNameKey,
                nil];
    if ([key isEqualToString:PKEY_OUTPUTPROGRESS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_OUTPUTPROGRESS, QCPortAttributeNameKey,
                nil];
    if ([key isEqualToString:PKEY_OUTPUTISINTIME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PNAME_OUTPUTISINTIME, QCPortAttributeNameKey,
                nil];
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

@implementation TimerSwitchPlugIn (Execution)

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
    NSUInteger CurrentTime = round(self.inputCurrentTime * 1000);
    NSUInteger StartTime   = self.inputStartTime;
    NSUInteger EndTime     = self.inputEndTime;
    
    if (EndTime > StartTime)
    {
        if (CurrentTime >= StartTime && CurrentTime <= EndTime)
        {
            self.outputIsInTime = YES;
            self.outputMiliTimeLeft = EndTime - CurrentTime;
            self.outputTimeLeft = (double) (EndTime - StartTime) / 1000.0f;
            self.outputProgress = (double)(CurrentTime - StartTime) / (double)(EndTime - StartTime);
        }
        else
        {
            self.outputIsInTime = NO;
            self.outputMiliTimeLeft = 0;
            self.outputTimeLeft = 0.0f;
            self.outputProgress = (CurrentTime > EndTime) ? 1.0f : 0.0f;
        }
    }
    else
    {
        self.outputIsInTime = NO;
        self.outputMiliTimeLeft = 0;
        self.outputTimeLeft = 0.0f;
        self.outputProgress = 0.0f;
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

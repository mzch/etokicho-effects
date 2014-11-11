//
//  Image_With_Bordered_StringPlugIn.m
//  Image With Bordered String
//
//  Created by Koichi MATSUMOTO on 2014/11/09.
//  Copyright (c) 2014年 Koichi MATSUMOTO. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "Image_With_Bordered_StringPlugIn.h"

#define	kQCPlugIn_Name				@"Image With Bordered String"
#define	kQCPlugIn_Description		@"This patch draw specified string with a border. You can specify its width and color."

@implementation Image_With_Bordered_StringPlugIn

// Accessor for output
@dynamic outputImage;
// Accessor for input
@dynamic inputString;
@dynamic inputFontName;
@dynamic inputFontSize;
@dynamic inputColor;
@dynamic inputBorderWidth;
@dynamic inputBorderColor;

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
    if ([key isEqualToString:PLUGIN_PORTKEY_STRING])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_STRING, QCPortAttributeNameKey,
                PLUGIN_PORTDEF_STRING,  QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PLUGIN_PORTKEY_FONTNAME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_FONTNAME, QCPortAttributeNameKey,
                PLUGIN_PORTDEF_FONTNAME,  QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PLUGIN_PORTKEY_FONTSIZE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_FONTSIZE, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PLUGIN_PORTDEF_FONTSIZE],  QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PLUGIN_PORTKEY_COLOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_COLOR, QCPortAttributeNameKey,
                PLUGIN_PORTDEF_COLOR,  QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PLUGIN_PORTKEY_BORDERWIDTH])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_BORDERWIDTH, QCPortAttributeNameKey,
                [NSNumber numberWithFloat:PLUGIN_PORTDEF_BORDERWIDTH],  QCPortAttributeDefaultValueKey,
                nil];
    if ([key isEqualToString:PLUGIN_PORTKEY_BORDERCOLOR])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_BORDERCOLOR, QCPortAttributeNameKey,
                PLUGIN_PORTDEF_BORDERCOLOR,  QCPortAttributeDefaultValueKey,
                nil];

    if ([key isEqualToString:PLUGIN_PORTKEY_IMAGE])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                PLUGIN_PORTNAME_IMAGE, QCPortAttributeNameKey,
                nil];
    
	return nil;
}

+ (NSArray*) sortedPropertyPortKeys
{
    NSArray * propertyPortKeys = [NSArray arrayWithObjects:PLUGIN_PORTKEY_STRING,
                                                           PLUGIN_PORTKEY_FONTNAME,
                                                           PLUGIN_PORTKEY_FONTSIZE,
                                                           PLUGIN_PORTKEY_COLOR,
                                                           PLUGIN_PORTKEY_BORDERWIDTH,
                                                           PLUGIN_PORTKEY_BORDERCOLOR,
                                  nil];
    
    return [[super sortedPropertyPortKeys] arrayByAddingObjectsFromArray:propertyPortKeys];
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

@implementation Image_With_Bordered_StringPlugIn (Execution)

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

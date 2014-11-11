//
//  TimerSwitchPlugIn.h
//  TimerSwitch
//
//  Created by Koichi MATSUMOTO on 2014/11/11.
//  Copyright (c) 2014 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// Constant Definitions
#define PKEY_INPUTTIME          @"inputCurrentTime"
#define PKEY_INPUTSTARTTIME     @"inputStartTime"
#define PKEY_INPUTENDTIME       @"inputEndTime"
#define PKEY_OUTPUTTIMELEFT     @"outputTimeLeft"
#define PKEY_OUTPUTMTIMELEFT    @"outputMiliTimeLeft"
#define PKEY_OUTPUTPROGRESS     @"outputProgress"
#define PKEY_OUTPUTISINTIME     @"outputIsInTime"

#define PNAME_INPUTTIME         @"Time"
#define PNAME_INPUTSTARTTIME    @"Start Time"
#define PNAME_INPUTENDTIME      @"End Time"
#define PNAME_OUTPUTTIMELEFT    @"Time Left"
#define PNAME_OUTPUTMTIMELEFT   @"Time Left (msec)"
#define PNAME_OUTPUTPROGRESS    @"Progress"
#define PNAME_OUTPUTISINTIME    @"Is In Time"

#define PDEF_INPUTTIME          0.0f
#define PDEF_INPUTSTARTTIME     0
#define PDEF_INPUTENDTIME       0

@interface TimerSwitchPlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
//@property double inputFoo;
//@property (copy) NSString* outputBar;

@property (assign) double       inputCurrentTime;
@property (assign) NSUInteger   inputStartTime;
@property (assign) NSUInteger   inputEndTime;
@property (assign) double       outputTimeLeft;
@property (assign) NSUInteger   outputMiliTimeLeft;
@property (assign) double       outputProgress;
@property (assign) BOOL         outputIsInTime;

@end

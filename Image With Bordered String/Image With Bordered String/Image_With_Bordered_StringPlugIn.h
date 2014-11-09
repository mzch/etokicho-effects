//
//  Image_With_Bordered_StringPlugIn.h
//  Image With Bordered String
//
//  Created by 松本 光一 on 2014/11/09.
//  Copyright (c) 2014年 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// Constant Definisions
#define PLUGIN_PORTKEY_STRING       @"inputString"
#define PLUGIN_PORTKEY_FONTNAME     @"inputFontName"
#define PLUGIN_PORTKEY_FONTSIZE     @"inputFontSize"
#define PLUGIN_PORTKEY_COLOR        @"inputColor"
#define PLUGIN_PORTKEY_BORDERWIDTH  @"inputBorderWidth"
#define PLUGIN_PORTKEY_BORDERCOLOR  @"inputBorderColor"
#define PLUGIN_PORTKEY_IMAGE        @"outputImage"

#define PLUGIN_PORTNAME_STRING      @"String"
#define PLUGIN_PORTNAME_FONTNAME    @"Font Name"
#define PLUGIN_PORTNAME_FONTSIZE    @"Font Size"
#define PLUGIN_PORTNAME_COLOR       @"Color"
#define PLUGIN_PORTNAME_BORDERWIDTH @"Border Width"
#define PLUGIN_PORTNAME_BORDERCOLOR @"Border Color"
#define PLUGIN_PORTNAME_IMAGE       @"Image"

#define PLUGIN_PORTDEF_STRING       @"アイドルマスター"
#define PLUGIN_PORTDEF_FONTNAME     @"HiraKakuProN-W3"
#define PLUGIN_PORTDEF_FONTSIZE     0.2
#define PLUGIN_PORTDEF_COLOR        CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)
#define PLUGIN_PORTDEF_BORDERWIDTH  0.0
#define PLUGIN_PORTDEF_BORDERCOLOR  CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)

@interface Image_With_Bordered_StringPlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
//@property double inputFoo;
//@property (copy) NSString* outputBar;

// Accessor for output Image
@property (assign) id<QCPlugInOutputImageProvider> outputImage;

// Accessor for input Value
@property (readwrite, assign) NSString * inputString;
@property (readwrite, assign) NSString * inputFontName;
@property (readwrite, assign) double     inputFontSize;
@property (readwrite, assign) CGColorRef inputColor;
@property (readwrite, assign) double     inputBorderWidth;
@property (readwrite, assign) CGColorRef inputBorderColor;

@end

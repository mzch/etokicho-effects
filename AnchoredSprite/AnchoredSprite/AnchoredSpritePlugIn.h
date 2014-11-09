//
//  AnchoredSpritePlugIn.h
//  AnchoredSprite
//
//  Created by 松本 光一 on 2014/11/09.
//  Copyright (c) 2014年 Koichi MATSUMOTO. All rights reserved.
//

#import <Quartz/Quartz.h>

// Constant definitions

#define PKEY_INPUTIMAGE     @"inputImage"
#define PKEY_INPUTANCHORX   @"inputAnchorX"
#define PKEY_INPUTANCHORY   @"inputAnchorY"
#define PKEY_INPUTANCHORZ   @"inputAnchorZ"
#define PKEY_INPUTDISTX     @"inputDistX"
#define PKEY_INPUTDISTY     @"inputDistY"
#define PKEY_INPUTDISTZ     @"inputDistZ"
#define PKEY_INPUTXANGLE    @"inputXAngle"
#define PKEY_INPUTYANGLE    @"inputYAngle"
#define PKEY_INPUTZANGLE    @"inputZAngle"
#define PKEY_INPUTXSCALE    @"inputXScale"
#define PKEY_INPUTYSCALE    @"inputYScale"
#define PKEY_INPUTZSCALE    @"inputZScale"
#define PKEY_INPUTCOLOR     @"inputColor"

#define PNAME_INPUTIMAGE    @"Image"
#define PNAME_INPUTANCHORX  @"Anchor X"
#define PNAME_INPUTANCHORY  @"Anchor Y"
#define PNAME_INPUTANCHORZ  @"Anchor Z"
#define PNAME_INPUTDISTX    @"X Distance"
#define PNAME_INPUTDISTY    @"Y Distance"
#define PNAME_INPUTDISTZ    @"Z Distance"
#define PNAME_INPUTXANGLE   @"X Rotation"
#define PNAME_INPUTYANGLE   @"Y Rotation"
#define PNAME_INPUTZANGLE   @"Z Rotation"
#define PNAME_INPUTXSCALE   @"X Scale"
#define PNAME_INPUTYSCALE   @"Y Scale"
#define PNAME_INPUTZSCALE   @"Z Scale"
#define PNAME_INPUTCOLOR    @"Color"

#define PDEF_INPUTANCHORX   0.0f
#define PDEF_INPUTANCHORY   0.0f
#define PDEF_INPUTANCHORZ   0.0f
#define PDEF_INPUTDISTX     0.0f
#define PDEF_INPUTDISTY     0.0f
#define PDEF_INPUTDISTZ     0.0f
#define PDEF_INPUTXANGLE    0.0f
#define PDEF_INPUTYANGLE    0.0f
#define PDEF_INPUTZANGLE    0.0f
#define PDEF_INPUTXSCALE    1.0f
#define PDEF_INPUTYSCALE    1.0f
#define PDEF_INPUTZSCALE    1.0f
#define PDEF_INPUTCOLOR     CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)

@interface AnchoredSpritePlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
// Declare a property input port of type Image with the key inputImage
@property(assign) id<QCPlugInInputImageSource> inputImage;
//@property (copy) NSString* outputBar;
@property (assign) double inputAnchorX;
@property (assign) double inputAnchorY;
@property (assign) double inputAnchorZ;
@property (assign) double inputDistX;
@property (assign) double inputDistY;
@property (assign) double inputDistZ;
@property (assign) double inputXAngle;
@property (assign) double inputYAngle;
@property (assign) double inputZAngle;
@property (assign) double inputXScale;
@property (assign) double inputYScale;
@property (assign) double inputZScale;
@property (assign) CGColorRef inputColor;

@end

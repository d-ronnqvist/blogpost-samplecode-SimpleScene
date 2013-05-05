//
//  SimpleSceneView.m
//  SimpleScene
//
//  Created by David Rönnqvist on 5/5/13.
//  Copyright (c) 2013 David Rönnqvist. All rights reserved.
//

#import "SimpleSceneView.h"

@implementation SimpleSceneView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
	self.backgroundColor = [NSColor darkGrayColor];
    
    // ==== SCENE CREATION ==== //
    
    // An empty scene
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;
    
	// A camera
    // --------
    // The camera is moved back and up from the center of the scene
    // and then rotated so that it looks down to the center
	SCNNode *cameraNode = [SCNNode node];
	cameraNode.camera = [SCNCamera camera];
	cameraNode.position = SCNVector3Make(0, 15, 30);
    cameraNode.transform = CATransform3DRotate(cameraNode.transform, -M_PI/7.0, 1, 0, 0);
    
    [scene.rootNode addChildNode:cameraNode];
	
    // A spot light
    // ------------
    // The spot light is positioned above the camera and points
    // down to the center of the scene using a transform
    SCNLight *spotLight = [SCNLight light];
    spotLight.type = SCNLightTypeSpot;
    spotLight.color = [NSColor redColor];
	SCNNode *spotLightNode = [SCNNode node];
	spotLightNode.light = spotLight;
    spotLightNode.position = SCNVector3Make(-2, 30, 30);
    spotLightNode.transform = CATransform3DRotate(spotLightNode.transform, -M_PI_4, 1, 0, 0);
    
	[scene.rootNode addChildNode:spotLightNode];
    
    // A square box
    // ------------
    // A square box is positioned in the center of the scene (default)
    // and given a small rotation around Y to highlight the perspective.
    CGFloat boxSide = 15.0;
    SCNBox *box = [SCNBox boxWithWidth:boxSide
                                height:boxSide
                                length:boxSide
                         chamferRadius:0];
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    boxNode.transform = CATransform3DMakeRotation(M_PI_2/3, 0, 1, 0);
    
    [scene.rootNode addChildNode:boxNode];
    
    
    // ==== ANIMATIONS ==== //
    
    
    // Changing the color of the spot light
    // ------------------------------------
    // Create an repeating, reversing animation of the "color" property.
    // Animate from red to blue to green using an linear timing function.
    CAKeyframeAnimation *spotColor = [CAKeyframeAnimation animationWithKeyPath:@"color"];
    spotColor.values = @[(id)[NSColor redColor], (id)[NSColor blueColor], (id)[NSColor greenColor], (id)[NSColor redColor]];
    spotColor.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    spotColor.repeatCount = INFINITY;
    spotColor.duration = 3.0;
    
    [spotLight addAnimation:spotColor forKey:@"ChangeTheColorOfTheSpot"];
    
    // Rotating the box
    // ----------------
    // Create a rotation transform for when the box is rotated halfway around
    // the x,y-diagonal. Make the animation linear and repeat it to give the
    // illusion of it being a continuous rotation
    CABasicAnimation *boxRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    boxRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(boxNode.transform, M_PI, 1, 1, 0)];
    boxRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    boxRotation.repeatCount = INFINITY;
    boxRotation.duration = 2.0;
    
    [boxNode addAnimation:boxRotation forKey:@"RotateTheBox"];
}

@end

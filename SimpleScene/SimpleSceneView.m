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
}

@end

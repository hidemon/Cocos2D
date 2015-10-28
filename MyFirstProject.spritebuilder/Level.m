//
//  Level.m
//  MyFirstProject
//
//  Created by mackbook on 15/5/30.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Level.h"

@implementation Level
-(void)launchBird:(id)sender
{
    //Calculate the rotation in radians
    float rotationRadians = CC_DEGREES_TO_RADIANS(_launcher.rotation);
    
    //Vector for the rotation
    CGPoint directionVector = ccp(sinf(rotationRadians),cosf(rotationRadians));
    CGPoint ballOffset = ccpMult(directionVector, 50);
    
    //Load a ball and set its initial position
    CCNode * ball = [CCBReader load:@"Bird"];
    ball.position = ccpAdd(_launcher.position, ballOffset);
    
    //Add the ball to the physics node
    [_physicsNode addChild:ball];
    
    //Make an impulse and apply it
    CGPoint force = ccpMult(directionVector, 50000);
    [ball.physicsBody applyForce:force];
    
    NSLog(@"HHHHHHH");
}



@end

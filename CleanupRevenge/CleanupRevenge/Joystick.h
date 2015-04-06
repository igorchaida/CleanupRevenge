//
//  Joystick.h
//  CleanupRevenge
//
//  Created by Igor de Almeida on 06/04/15.
//  Copyright (c) 2015 segaNub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Joystick : SKNode
{
    SKSpriteNode *thumbNode;
    BOOL isTracking;
    CGPoint velocity;
    CGPoint travelLimit;
    float angularVelocity;
}

@property(nonatomic, readonly) CGPoint velocity;
@property(nonatomic, readonly) float angularVelocity;

-(id) initWithThumb: (SKSpriteNode*) aNode;
+(id) joystickWithThumb: (SKSpriteNode*) aNode;
-(id) initWithThumb: (SKSpriteNode*) thumbNode andBackdrop: (SKSpriteNode*) backgroundNode;
+(id) joystickWithThumb: (SKSpriteNode*) thumbNode andBackdrop: (SKSpriteNode*) backgroundNode;
@end

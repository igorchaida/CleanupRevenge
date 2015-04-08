//
//  GameScene.m
//  CleanupRevenge
//
//  Created by Igor de Almeida on 06/04/15.
//  Copyright (c) 2015 segaNub. All rights reserved.
//

#import "GameScene.h"
#import "JCJoystick.h"
#import "JCImageJoystick.h"

@interface GameScene ()

@property (nonatomic,strong)SKSpriteNode *background;
@property (strong, nonatomic) JCJoystick *joystick;
@property SKNode *sprite;
@property (strong, nonatomic) JCImageJoystick *imageJoystick;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"FundoTEST-2.png"];
        [_background setName:@"background"];
        [_background setAnchorPoint:CGPointZero];
        _background.xScale = 0.5;
        _background.yScale = 0.5;
        [self addChild:_background];
        
        //JCImageJoystic
        self.imageJoystick = [[JCImageJoystick alloc]initWithJoystickImage:(@"redStick.png") baseImage:@"stickbase.png"];
        [self.imageJoystick setPosition:CGPointMake(80, 70)];
        [self addChild:self.imageJoystick];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Peixe1.png"];
        self.sprite = sprite;
        sprite.xScale = 0.22;
        sprite.yScale = 0.22;
        sprite.position = CGPointMake(CGRectGetMidX(self.frame)*1.5,
                                             CGRectGetMidY(self.frame));
        [super addChild:sprite];
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self.sprite setPosition:CGPointMake(self.sprite.position.x+self.imageJoystick.x*3, self.sprite.position.y+self.imageJoystick.y*3)];
}
@end

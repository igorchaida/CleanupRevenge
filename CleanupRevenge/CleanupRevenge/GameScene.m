//
//  GameScene.m
//  CleanupRevenge
//
//  Created by Igor de Almeida on 06/04/15.
//  Copyright (c) 2015 segaNub. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (nonatomic,strong)SKSpriteNode *background;


@end

@implementation GameScene



-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    _background = [SKSpriteNode spriteNodeWithImageNamed:@"FundoTEST.png"];
    [_background setName:@"background"];
    [_background setAnchorPoint:CGPointZero];
//    background.size.height = 337;
    
    [self addChild:_background];
    
    myLabel.text = @"TESTE1";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Peixe1"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

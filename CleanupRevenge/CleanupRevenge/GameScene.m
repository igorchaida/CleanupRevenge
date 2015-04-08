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
#import "JCButton.h"

@interface GameScene ()

@property (nonatomic,strong)SKSpriteNode *background;
@property (strong, nonatomic) JCJoystick *joystick;
@property (strong, nonatomic) JCButton *normalButton;
@property (strong, nonatomic) JCButton *turboButton;
@property SKNode *sprite;
@property (strong, nonatomic) JCImageJoystick *imageJoystick;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //JCJoystick
        self.joystick = [[JCJoystick alloc] initWithControlRadius:40 baseRadius:45 baseColor:[SKColor blueColor] joystickRadius:25 joystickColor:[SKColor redColor]];
        [self.joystick setPosition:CGPointMake(70,70)];
        [self addChild:self.joystick];
        
        
        //JCImageJoystic
        self.imageJoystick = [[JCImageJoystick alloc]initWithJoystickImage:(@"redStick.png") baseImage:@"stickbase.png"];
        [self.imageJoystick setPosition:CGPointMake(50, 270)];
        [self addChild:self.imageJoystick];
        
        //JCButton
        
        self.normalButton = [[JCButton alloc] initWithButtonRadius:25 color:[SKColor greenColor] pressedColor:[SKColor blackColor] isTurbo:NO];
        [self.normalButton setPosition:CGPointMake(size.width - 40,95)];
        [self addChild:self.normalButton];
        
        
        self.turboButton = [[JCButton alloc] initWithButtonRadius:25 color:[SKColor yellowColor] pressedColor:[SKColor blackColor] isTurbo:YES];
        [self.turboButton setPosition:CGPointMake(size.width - 85,50)];
        [self addChild:self.turboButton];
        
        //scheduling the action to check buttons
        SKAction *wait = [SKAction waitForDuration:0.3];
        SKAction *checkButtons = [SKAction runBlock:^{
            [self checkButtons];
        }];
        SKAction *checkButtonsAction = [SKAction sequence:@[wait,checkButtons]];
        [self runAction:[SKAction repeatActionForever:checkButtonsAction]];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Peixe1.png"];
        self.sprite = sprite;
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = CGPointMake(CGRectGetMidX(self.frame)*1.5,
                                             CGRectGetMidY(self.frame));
        [super addChild:sprite];
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self.sprite setPosition:CGPointMake(self.sprite.position.x+self.imageJoystick.x, self.sprite.position.y+self.imageJoystick.y)];
}

- (void)checkButtons
{
    
    if (self.normalButton.wasPressed) {
        [self addSquareIn:CGPointMake(0,self.size.height-40) withColor:[SKColor greenColor]];
    }
    
    if (self.turboButton.wasPressed) {
        [self addSquareIn:CGPointMake(0,self.size.height-80) withColor:[SKColor yellowColor]];
    }
    
}

- (void)addSquareIn:(CGPoint)position
          withColor:(SKColor *)color
{
    SKSpriteNode *square = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(15,10)];
    [square setPosition:position];
    SKAction *move = [SKAction moveTo:CGPointMake(self.size.width+square.size.width/2,position.y) duration:1.0];
    SKAction *destroy = [SKAction removeFromParent];
    [self addChild:square];
    [square runAction:[SKAction sequence:@[move,destroy]]];
}
@end

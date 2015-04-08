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
#import "Rope.h"

@interface GameScene ()

@property (nonatomic,strong)SKSpriteNode *background;
@property (strong, nonatomic) JCJoystick *joystick;
@property SKNode *sprite;
@property (strong, nonatomic) JCImageJoystick *imageJoystick;
@property (nonatomic)CGPoint _touchStartPoint;
@property (nonatomic)CGPoint _touchEndPoint;
@property (nonatomic)BOOL _touchMoving;

@end
int countTrash = 0;
@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"FundoTEST-2.png"];
        [_background setName:@"background"];
        [_background setAnchorPoint:CGPointZero];
        _background.xScale = 0.5;
        _background.yScale = 0.5;
        [self addChild:_background];
        
        self.imageJoystick = [[JCImageJoystick alloc]initWithJoystickImage:(@"Joystick1.png") baseImage:@"Joystick2.png"];
        [self.imageJoystick setPosition:CGPointMake(80, 70)];
        [self addChild:self.imageJoystick];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Peixe1.png"];
        self.sprite = sprite;
        sprite.xScale = 0.22;
        sprite.yScale = 0.22;
        sprite.position = CGPointMake(CGRectGetMidX(self.frame)*1.5,
                                             CGRectGetMidY(self.frame));
        [super addChild:sprite];
        [self buildScene];
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self.sprite setPosition:CGPointMake(self.sprite.position.x+self.imageJoystick.x*3, self.sprite.position.y+self.imageJoystick.y*3)];
    
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    
    if(timeSinceLast > 1)//more than a sencond since last update
    {
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

-(void) buildScene {
    
    //Coloca fisica no ambiente inteiro (tamanha da tela)
    SKNode *edge = [SKNode new];
    edge.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    //    edge.physicsBody.mass = 0.1;
    [self addChild:edge];
    
    //Cria o tronco de arvore, com posicao e fisica
    SKSpriteNode *branch = [SKSpriteNode spriteNodeWithImageNamed:@"Branch"];
    branch.position = CGPointMake(CGRectGetMaxX(self.frame) - branch.size.width / 2,
                                  CGRectGetMidY(self.frame) + 320);
    branch.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(branch.frame.size.width, 10)];
    
    //Ponto de origem do primeiro gomo da corrente
    CGPoint ropeAttachPos = CGPointMake(branch.position.x - 250, branch.position.y-50);
    branch.physicsBody.dynamic = NO; //Deixa o objeto estico
    branch.zPosition = 100;
    
    CGPoint ropeAttachPos2 = CGPointMake(branch.position.x + 200, branch.position.y-50);
    branch.physicsBody.dynamic = NO; //Deixa o objeto estico
    branch.zPosition = 100;
    
    [self addChild:branch];
    
    // All objects need to be initialized first. Position of attached object
    // is decided by rope and rope adds object to scene.
    
    //Cria a bola, no nosso caso sera o anzol
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Anzol"];
    ball.name = @"ANZOL";
    SKSpriteNode *ball2 = [SKSpriteNode spriteNodeWithImageNamed:@"Anzol"];
    ball.name = @"ANZOL2";
    
    Rope *rope = [Rope new];
    [self addChild:rope];
    
    Rope *rope2 = [Rope new];
    [self addChild:rope2];
    

    // Attach rope to branch.
    [rope setAttachmentPoint:ropeAttachPos toNode:branch];
    
    [rope2 setAttachmentPoint:ropeAttachPos2 toNode:branch];

    // This now actually creates physics body. Not ideal but good for the demo.
    [rope attachObject:ball];
    
    [rope2 attachObject:ball2];
    
    // Setting lenght actually also builds the rope. For production, have own method for building rope.
    //define o tamanho do anzol
    rope.ropeLength = 30;
    rope2.ropeLength = 30;
}

-(void)addTrash
{
    SKSpriteNode *bota = [SKSpriteNode spriteNodeWithImageNamed:@"Bota"];
    SKSpriteNode *garrafa = [SKSpriteNode spriteNodeWithImageNamed:@"Garrafa"];
    SKSpriteNode *lata = [SKSpriteNode spriteNodeWithImageNamed:@"Lata"];
    SKSpriteNode *sacola = [SKSpriteNode spriteNodeWithImageNamed:@"Sacola"];
    SKSpriteNode *barril = [SKSpriteNode spriteNodeWithImageNamed:@"Barril"];
    SKSpriteNode *pneu = [SKSpriteNode spriteNodeWithImageNamed:@"Pneu"];
    
    /*SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
     [bota runAction:[SKAction repeatActionForever:action]];
     [garrafa runAction:[SKAction repeatActionForever:action]];
     [lata runAction:[SKAction repeatActionForever:action]];
     [sacola runAction:[SKAction repeatActionForever:action]];*/
    
    NSMutableArray *lixos = [[NSMutableArray alloc] init];
    
    [lixos addObject:bota];
    [lixos addObject:garrafa];
    [lixos addObject:lata];
    [lixos addObject:sacola];
    [lixos addObject:barril];
    [lixos addObject:pneu];
    
    SKSpriteNode *trash = [lixos objectAtIndex:(arc4random() % lixos.count)];
    trash.xScale = 0.16;
    trash.yScale = 0.16;
    
    int minX = trash.size.width;
    int maxX = self.frame.size.width;
    int rangeX = maxX - minX;//547
    int actualX = (arc4random() % rangeX) + 30;
    
    if(actualX <= 0){
        actualX += trash.size.width / 2;
    }
    else if(actualX >= 620){
        actualX -= trash.size.width / 2;
    }
    
    //NSLog(@"%d",rangeX);
    //NSLog(@"%d",actualX);
    
    //Position where the trash is thrown
    
    trash.position = CGPointMake(actualX, self.frame.size.height);
    [self addChild:trash];
    
    /*trash.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:trash.size];
     trash.physicsBody.usesPreciseCollisionDetection = YES;
     trash.physicsBody.dynamic = TRUE;*/
    
    // Determine speed of thrash
    int minSpeed = 10.0;
    int maxSpeed = 20.0;
    int rangeSpeed = maxSpeed - minSpeed;
    int actualSpeed = (arc4random() % rangeSpeed) + minSpeed;
    
    //NSLog(@"%d",actualSpeed);
    
    //Create the actions
    SKAction *actionMove = [SKAction moveTo:CGPointMake(actualX,-self.frame.size.height) duration:actualSpeed];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    [trash runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

-(void) updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    self.lastTrashTimeInterval += timeSinceLast;
    
    if(countTrash >= 100){
        if (self.lastTrashTimeInterval > 1)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            NSLog(@"%d",countTrash);
        }
    }
    if(countTrash >= 60){
        if (self.lastTrashTimeInterval > 2)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            NSLog(@"%d",countTrash);
        }
    }
    if(countTrash >= 30){
        if (self.lastTrashTimeInterval > 3)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            NSLog(@"%d",countTrash);
        }
    }
    if(countTrash >= 10){
        if (self.lastTrashTimeInterval > 4)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            NSLog(@"%d",countTrash);
        }
    }
    else{
        if (self.lastTrashTimeInterval > 5)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            NSLog(@"%d",countTrash);
        }
    }
    
}

@end

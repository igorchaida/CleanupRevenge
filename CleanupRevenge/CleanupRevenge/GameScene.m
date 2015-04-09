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
@property (nonatomic) bool isFollow;
@property (nonatomic) bool playerMove;
@property (nonatomic) bool isAligned;
@property (nonatomic)SKSpriteNode *range;
@property (nonatomic)SKSpriteNode *range2;
@property (nonatomic)NSMutableArray *objectsInCene;

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
        sprite.name = @"JOGADOR";
        self.sprite = sprite;
        sprite.xScale = 0.22;
        sprite.yScale = 0.22;
        //        sprite.position = CGPointMake(CGRectGetMidX(self.frame)*1.5,
        //                                             CGRectGetMidY(self.frame));
        sprite.position = CGPointMake(300, 150);
        [super addChild:sprite];
        [self buildScene];
        
        _playerMove = true;
        _isAligned = true;
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    
    if(_playerMove==true){
        [self.sprite setPosition:CGPointMake(self.sprite.position.x+self.imageJoystick.x*3, self.sprite.position.y+self.imageJoystick.y*3)];
    }
    
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
    
    //    //Coloca fisica no ambiente inteiro (tamanha da tela)
    //    SKNode *edge = [SKNode new];
    //    edge.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    //    //    edge.physicsBody.mass = 0.1;
    //    [self addChild:edge];
    
    //Cria o tronco de arvore, com posicao e fisica
    SKSpriteNode *branch = [SKSpriteNode spriteNodeWithImageNamed:@"Branch"];
    branch.name = @"FIXACAOANZOL1";
    branch.position = CGPointMake(CGRectGetMaxX(self.frame) - branch.size.width / 2,
                                  CGRectGetMidY(self.frame) + 320);
    branch.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(branch.frame.size.width, 10)];
    
    //Ponto de origem do primeiro gomo da corrente
    CGPoint ropeAttachPos = CGPointMake(117, 457.5);
    branch.physicsBody.dynamic = NO; //Deixa o objeto estico
    //    branch.zPosition = 100;
    
    CGPoint ropeAttachPos2 = CGPointMake(567, 457.5);
    branch.physicsBody.dynamic = NO; //Deixa o objeto estico
    //    branch.zPosition = 100;
    
    [self addChild:branch];
    
    //Cria a bola, no nosso caso sera o anzol
    SKSpriteNode *anzol = [SKSpriteNode spriteNodeWithImageNamed:@"Anzol"];
    anzol.name = @"ANZOL";
    SKSpriteNode *anzol2 = [SKSpriteNode spriteNodeWithImageNamed:@"Anzol"];
    anzol2.name = @"ANZOL2";
    
    Rope *rope = [Rope new];
    [self addChild:rope];
    
    Rope *rope2 = [Rope new];
    [self addChild:rope2];
    
    
    // Attach rope to branch.
    [rope setAttachmentPoint:ropeAttachPos toNode:branch];
    
    [rope2 setAttachmentPoint:ropeAttachPos2 toNode:branch];
    
    // This now actually creates physics body. Not ideal but good for the demo.
    [rope attachObject:anzol];
    
    [rope2 attachObject:anzol2];
    
    // Setting lenght actually also builds the rope. For production, have own method for building rope.
    //define o tamanho do anzol
    rope.ropeLength = 30;
    rope2.ropeLength = 30;
    
    //CRIA O RANGE DA ISCA
    self.range = [SKSpriteNode spriteNodeWithImageNamed:@"Range"];
    self.range.position = anzol.position;
    self.range.name = @"RANGE";
    [self addChild:_range];
    
    //CRIA O RANGE DA ISCA2
    self.range2 = [SKSpriteNode spriteNodeWithImageNamed:@"Range"];
    self.range2.position = anzol2.position;
    self.range2.name = @"RANGE2";
    [self addChild:_range2];
    
}

-(void)addTrash
{
    SKSpriteNode *bota = [SKSpriteNode spriteNodeWithImageNamed:@"Bota"];
    bota.name = @"LIXO";
    SKSpriteNode *garrafa = [SKSpriteNode spriteNodeWithImageNamed:@"Garrafa"];
    garrafa.name = @"LIXO";
    SKSpriteNode *lata = [SKSpriteNode spriteNodeWithImageNamed:@"Lata"];
    lata.name = @"LIXO";
    SKSpriteNode *sacola = [SKSpriteNode spriteNodeWithImageNamed:@"Sacola"];
    sacola.name = @"LIXO";
    SKSpriteNode *barril = [SKSpriteNode spriteNodeWithImageNamed:@"Barril"];
    barril.name = @"LIXO";
    SKSpriteNode *pneu = [SKSpriteNode spriteNodeWithImageNamed:@"Pneu"];
    pneu.name = @"LIXO";
    
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
    
    NSLog(@"\nLixo em cena: %lu", (unsigned long)[self.objectsInCene count]);
    
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
            //            NSLog(@"%d",countTrash);
        }
    }
    if(countTrash >= 60){
        if (self.lastTrashTimeInterval > 2)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            //            NSLog(@"%d",countTrash);
        }
    }
    if(countTrash >= 30){
        if (self.lastTrashTimeInterval > 3)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            //            NSLog(@"%d",countTrash);
        }
    }
    if(countTrash >= 10){
        if (self.lastTrashTimeInterval > 4)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            //            NSLog(@"%d",countTrash);
        }
    }
    else{
        if (self.lastTrashTimeInterval > 5)
        {
            self.lastTrashTimeInterval = 0;
            [self addTrash];
            countTrash++;
            //            NSLog(@"%d",countTrash);
        }
    }
    
    [self checkCollision];
    
}


-(void)checkCollision
{
    SKNode *jogador = [self childNodeWithName:@"JOGADOR"];
    SKNode *range = [self childNodeWithName:@"RANGE"];
    SKNode *range2 = [self childNodeWithName:@"RANGE2"];
    SKNode *anzol = [self childNodeWithName:@"ANZOL"];
    SKNode *anzol2 = [self childNodeWithName:@"ANZOL2"];
    
    //    NSLog(@"\nLixo em cena: %d", self.objectsInCene.count);
    
    if(self.objectsInCene!=nil){//NAO ESTA ENTRANDO NESSA FUNCAO
        SKNode *lixo = [self childNodeWithName:@"LIXO"];
        if([jogador intersectsNode:lixo]){
            [self fimDeJogo:jogador withObject:lixo];
        }
        else if([anzol intersectsNode:lixo]){
            [self marcaPontos:anzol withObject:lixo];
        }
        else if([anzol2 intersectsNode:lixo]){
            [self marcaPontos:anzol2 withObject:lixo];
        }
    }
    if([jogador intersectsNode:range]){
        
        [self moveAnzol:range withPlayer:jogador];
    }
    if([jogador intersectsNode:range2]){
        [self moveAnzol:range2 withPlayer:jogador];
    }
    else{
        //        SKNode *anzol = [self childNodeWithName:@"ANZOL"];
        SKAction *backToOrigin = [SKAction moveTo:CGPointMake(117, 170) duration:0.1];
        [range runAction:backToOrigin];
        [anzol runAction:backToOrigin];
        SKAction *backToOrigin2 = [SKAction moveTo:CGPointMake(567, 170) duration:0.1];
        [range2 runAction:backToOrigin2];
        [anzol2 runAction:backToOrigin2];
    }
    
    [self fishIsDead:anzol withPlayer:jogador];
    [self fishIsDead:anzol2 withPlayer:jogador];
    
    
}

//COLISAO COM O LIXO FIM DE JOGO - OBS: COM PROBLEMAS
-(void)fimDeJogo:(SKNode *)player withObject: (SKNode *)objetc
{
    for(SKNode *i in self.objectsInCene){
        if([self isColliding:player withObject:i]){
            _playerMove = false;
            //CHAMAR TELA OPCOES PARA RECOMECAR O JOGO
        }
    }
}

//COLISAO COM O LIXO E O ANZOL
-(void)marcaPontos:(SKNode *)anzol withObject: (SKNode *)lixo
{
    if([self isColliding:anzol withObject:lixo]){
        NSLog(@"Lixo colidiu com o anzol");
    }
}

//VERIFICA A VIDA DO PEIXE
-(void)fishIsDead:(SKNode *)anzol withPlayer: (SKNode *)player
{
    if([self isColliding:anzol withObject:player]){
        _playerMove = false;
    }
}


//MOVIMENTO O ANZOL
-(void)moveAnzol:(SKNode *)range0 withPlayer: (SKNode *)player
{
    SKNode *anzol;
    SKNode *range;
    
    if([range0.name isEqualToString:@"RANGE"]){
        anzol = [self childNodeWithName:@"ANZOL"];
        range = [self childNodeWithName:@"RANGE"];
    }else{
        anzol = [self childNodeWithName:@"ANZOL2"];
        range = [self childNodeWithName:@"RANGE2"];
    }
    
    float distX = range.position.x - player.position.x;
    float distY = range.position.y - player.position.y;
    float distX2 = distX;
    float distY2 = distY;
    if(distY2<0){ distY2 = distY2*-1; }
    if(distX2<0){ distX2 = distX2*-1; }
    
    float catOp = powf(distY, 2);
    float catAdj = powf(distX, 2);
    float somaRaios = range.frame.size.height+player.frame.size.height;
    
    float hip = sqrtf((catOp+catAdj));
    
    //    _isAligned = [self checkAlign:anzol withRange:range];
    
    if(hip<=somaRaios){// && _isAligned){
        _isFollow = true;
        
        float x2, y2;
        if(distX2>distY2){
            if(distX<0){ x2 = 0.5; }
            else{ x2 = -0.5; }
            SKAction *move = [SKAction moveByX:x2 y:(x2*distY)/distX duration:.5];
            [anzol runAction:move];
            [range runAction:move];
        }else{
            if(distY<0){ y2 = 0.5; }
            else{ y2 = -0.5; }
            SKAction *move = [SKAction moveByX:(y2*distX)/distY y:y2 duration:.5];
            [anzol runAction:move];
            [range runAction:move];
        }
        
    }else{
        _isFollow = false;
        _isAligned = false;
        
        
        //        SKAction *backToOrigin = [SKAction moveTo:CGPointMake(117, 457.5) duration:1];
        //        [range runAction:backToOrigin];
        //        [anzol runAction:backToOrigin];
    }
    
}


//VERIFICA ALINHAMENTO DO RANGE DO ANZOL COM O ANZOL (OBS: COM PROBLEMAS)
-(Boolean)checkAlign:(SKNode*)anzol withRange: (SKNode *)range{
    
    float lim = 5;
    float anzolX = anzol.position.x;
    float anzolY = anzol.position.y;
    float rangeX = range.position.x;
    float rangeY = range.position.y;
    
    
    if( rangeX <= anzolX+lim && rangeX >= anzolX-lim && rangeY <= anzolY+lim && rangeY >= anzolY-lim ){
        return true;
    }
    NSLog(@"NAO ESTA ALINHADO");
    //    SKAction *moveRange = [SKAction moveByX:anzolX y:anzolY duration:.1];
    //    [range runAction:moveRange];
    return false;
}

-(Boolean)isColliding:(SKNode *)object1 withObject: (SKNode *)objetc2
{
    float distX = object1.position.x - objetc2.position.x;
    float distY = object1.position.y - objetc2.position.y;
    float distX2 = distX;
    float distY2 = distY;
    if(distY2<0){ distY2 = distY2*-1; }
    if(distX2<0){ distX2 = distX2*-1; }
    
    float catOp = powf(distY, 2);
    float catAdj = powf(distX, 2);
    float somaRaios = object1.frame.size.height/4+objetc2.frame.size.height/4;
    
    float hip = sqrtf((catOp+catAdj));
    
    if(hip<=somaRaios){
        return true;
    }
    
    return false;
    
}

@end

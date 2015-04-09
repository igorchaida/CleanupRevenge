//
//  GameScene.h
//  CleanupRevenge
//

//  Copyright (c) 2015 segaNub. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MenuViewController.h"
#import "GameViewController.h"


@class GameViewController;
@interface GameScene : SKScene <UIAlertViewDelegate> 
@property (nonatomic) NSTimeInterval lastTrashTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (weak, nonatomic) GameViewController* father;

@end

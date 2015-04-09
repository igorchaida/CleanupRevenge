//
//  MenuViewController.m
//  CleanupRevenge
//
//  Created by Igor de Almeida on 06/04/15.
//  Copyright (c) 2015 segaNub. All rights reserved.
//

#import "MenuViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "SoundManager.h"
#import "GameScene.h"
#import "JCJoystick.h"
#import "JCImageJoystick.h"
#import "Rope.h"
#import "SoundManager.h"



@interface MenuViewController ()
@property (nonatomic,strong)SKSpriteNode *background;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        
        // Configurando o sharedManager
        [[SoundManager sharedManager] prepareToPlay];
        [[SoundManager sharedManager] setMusicVolume:0.1];
        [[SoundManager sharedManager] setSoundVolume:1];
        [[SoundManager sharedManager] stopAllSounds];
        
        [[SoundManager sharedManager] playMusic:@"Music.mp3" looping:YES];
}

-(IBAction)unwindToMenuViewController:(UIStoryboardSegue *)unwindSegue{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    
    // Dispose of any resources that can be recreated.
}

@end

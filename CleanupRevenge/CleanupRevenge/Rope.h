//
//  Rope.h
//  TesteAnzol
//
//  Created by Bira on 07/04/15.
//  Copyright (c) 2015 Senac. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Rope : SKNode

@property int ropeLength;

// Attach rope to SKNode.
-(void) setAttachmentPoint:(CGPoint) point toNode:(SKNode*) body;

// Set set something to hang on the end of the rope.
-(void) attachObject:(SKSpriteNode*) object;

@end
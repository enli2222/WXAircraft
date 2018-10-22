//
//  GameScene.m
//  WXAircraft
//
//  Created by enli on 2018/10/19.
//  Copyright © 2018年 enli. All rights reserved.
//

#import "GameScene.h"
#import "ELSpiritNode.h"

@implementation GameScene {
    BOOL _isPlane;
    CGPoint _position;
    CGFloat scale;
}

- (void)didMoveToView:(SKView *)view {
    _isPlane = NO;
    NSLog(@"scale:%f nativeScale:%f",[UIScreen mainScreen].scale, [UIScreen mainScreen].nativeScale);
    scale = 2.0;
    self.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:192.0/255.0 blue:203.0/255.0 alpha:1.0];
//    SKLabelNode *label = [SKLabelNode labelNodeWithText:@"微信小飞机之山寨版"];
//    label.color = [UIColor whiteColor];
//    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
//    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
//    label.position = CGPointMake(self.size.width /2, self.size.height /2);
//    [self addChild:label];
    
    SKSpriteNode *bgNode = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
    bgNode.position = CGPointMake(0, 0);
    bgNode.zPosition = 0;
    bgNode.anchorPoint = CGPointZero;
    bgNode.size = self.size;
    [self addChild: bgNode];
    
    SKSpriteNode *player = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"hero1"]]];
    player.position = CGPointMake(self.size.width / 2, self.size.height /2);
    player.anchorPoint = CGPointMake(0.5, 0.5);
    player.size = CGSizeMake(player.size.width / scale, player.size.height /scale);
    player.zPosition = 1;
    player.name = @"plane";
    [self addChild:player];
                            
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

-(void)panAction:(UIPanGestureRecognizer *)sender{
//    switch (sender.state) {
//        case UIGestureRecognizerStateBegan:
//            NSLog(@"UIGestureRecognizerStateBegan");
//            break;
//        case UIGestureRecognizerStateChanged:
//            NSLog(@"UIGestureRecognizerStateChanged");
//            break;
//        case UIGestureRecognizerStateCancelled:
//        case UIGestureRecognizerStateEnded:
//        case UIGestureRecognizerStateFailed:
//            NSLog(@"UIGestureRecognizerStateEnded");
//            break;
//        default:
//            break;
//    }
//
    
    
    if (_isPlane) {
        _position = [sender locationInView:sender.view];
//        NSLog(@"%f:%f",_position.x,_position.y);
    }

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _isPlane = NO;
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:position];
    _isPlane = [node.name isEqualToString:@"plane"];
    
//    // Run 'Pulse' action from 'Actions.sks'
//    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
//    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    SKSpriteNode *player = (SKSpriteNode *)[self childNodeWithName:@"plane"];
    player.position = CGPointMake(_position.x, self.size.height-_position.y);
    
}

@end

//
//  GameScene.m
//  WXAircraft
//
//  Created by enli on 2018/10/19.
//  Copyright © 2018年 enli. All rights reserved.
//

#define Bullet_MAX 50

#import "GameScene.h"
#import "StartScene.h"
#import "ELSpiritNode.h"

@implementation GameScene {
    BOOL _isPlane;
    CGPoint _position;
    CGFloat scale;
    NSMutableArray *bullets;
    NSMutableArray *enemys;
    SKSpriteNode *player;
    UInt32 bulletCategory,enemyCategory,playerCategory;
    SKAction *enemy1_down;
}

- (void)didMoveToView:(SKView *)view {
    _isPlane = NO;
//    NSLog(@"scale:%f nativeScale:%f",[UIScreen mainScreen].scale, [UIScreen mainScreen].nativeScale);
    scale = 1.5;
    bulletCategory = 0x1 << 0;
    enemyCategory = 0x1 << 1;
    playerCategory = 0x1 << 2;
    self.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:192.0/255.0 blue:203.0/255.0 alpha:1.0];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.physicsWorld.contactDelegate = self;
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
    
    player = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"hero1"]]];
    player.size = CGSizeMake(player.size.width / scale, player.size.height /scale);
    player.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,player.size.height);
    player.anchorPoint = CGPointMake(0.5, 0.5);
    player.zPosition = 1;
    player.name = @"plane";
    player.physicsBody = [SKPhysicsBody bodyWithTexture:player.texture size:player.size];
    player.physicsBody.allowsRotation = NO;
    player.physicsBody.categoryBitMask = playerCategory;
    player.physicsBody.contactTestBitMask = enemyCategory | bulletCategory;
    player.physicsBody.dynamic = YES;
    [self addChild:player];
    
    bullets = [[NSMutableArray alloc]init];
    enemys = [[NSMutableArray alloc]init];
    
    SKAction *actionAddEnemy = [SKAction runBlock:^{
        [self addEnemy:@"enemy1" speed:4.0];
    }];
    SKAction *actionWaitNextEnemy = [SKAction waitForDuration:1.0];
    [self runAction:[SKAction repeatActionForever:
     [SKAction sequence:@[actionAddEnemy,actionWaitNextEnemy]]]];
                            
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    
    enemy1_down = [SKAction animateWithTextures:@[[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"enemy1_down1"]],[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"enemy1_down2"]],[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"enemy1_down3"]],[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"enemy1_down4"]]] timePerFrame:0.15];

}

-(void)addEnemy:(NSString *)name speed:(CGFloat)speed{
    SKSpriteNode *enemy = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:name]]];
    enemy.size = CGSizeMake(enemy.size.width / scale, enemy.size.height /scale);
    CGFloat positionX = arc4random_uniform([UIScreen mainScreen].bounds.size.width - enemy.size.width);
    enemy.position = CGPointMake(positionX, [UIScreen mainScreen].bounds.size.height);
    enemy.zPosition = 1;
    enemy.physicsBody = [SKPhysicsBody bodyWithTexture:enemy.texture size:enemy.size];
    enemy.physicsBody.categoryBitMask = enemyCategory;
    enemy.physicsBody.contactTestBitMask = playerCategory | bulletCategory ;
    enemy.physicsBody.dynamic = YES;
    [self addChild:enemy];
    
    SKAction *actionMove = [SKAction moveTo:CGPointMake(positionX, enemy.size.height / 2) duration:speed];
    SKAction *actionMoveDone = [SKAction runBlock:^{
        [enemy removeFromParent];
        [self->enemys removeObject:enemy];
    }];
    [enemy runAction:[SKAction sequence:@[actionMove,actionMoveDone]]];
    [enemys addObject:enemy];
}

-(void)shot{
    SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[[ELSpiritNode getShareInstance] getByName:@"bullet1"]]];
    bullet.size = CGSizeMake(bullet.size.width / scale, bullet.size.height /scale);
    bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bullet.size];
    bullet.physicsBody.categoryBitMask = bulletCategory;
    bullet.physicsBody.contactTestBitMask = enemyCategory ;
    bullet.position = CGPointMake(player.position.x,player.position.y);
    bullet.physicsBody.dynamic = NO;
    bullet.zPosition = 1;
    bullet.name = @"bullet";
    [self addChild:bullet];
    SKAction *actionMove = [SKAction moveTo:CGPointMake(bullet.position.x, [UIScreen mainScreen].bounds.size.height) duration:1.0];
    SKAction *actionMoveDone = [SKAction runBlock:^{
        [bullet removeFromParent];
    }];
    [bullet runAction:[SKAction sequence:@[actionMove,actionMoveDone]]];
//    [bullets addObject:bullet];
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

    
    if (_isPlane) {
        _position = [sender locationInView:sender.view];
//        NSLog(@"%f:%f",_position.x,_position.y);
        SKSpriteNode *player = (SKSpriteNode *)[self childNodeWithName:@"plane"];
        player.position = CGPointMake(_position.x, self.size.height-_position.y);
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
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
////    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
////    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
//}
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
////    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
//}

-(void)update:(CFTimeInterval)currentTime {
    static int bulletNum = 0;
    if (bulletNum > 20) {
        [self shot];
        bulletNum = 0;
    }
    bulletNum ++;
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
//    SKPhysicsBody *bodyA,*bodyB;
    NSLog(@"didBeginContact");
    SKNode *nodeA = contact.bodyA.node;
    if (contact.bodyA.categoryBitMask == enemyCategory) {
        [nodeA runAction:enemy1_down completion:^{
            [nodeA removeAllActions];
            [nodeA removeFromParent];
        }];
    }else{
        [nodeA removeAllActions];
        [nodeA removeFromParent];
    }
    SKNode *nodeB = contact.bodyB.node;
    if (contact.bodyB.categoryBitMask == enemyCategory) {
        [nodeB runAction:enemy1_down completion:^{
            [nodeB removeAllActions];
            [nodeB removeFromParent];
        }];
    }else{
        [nodeB removeAllActions];
        [nodeB removeFromParent];
    }
    
    if (contact.bodyA.categoryBitMask == playerCategory || contact.bodyB.categoryBitMask == playerCategory) {
        [self endGame];
        return;
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact{
    NSLog(@"didEndContact");
}

-(void)endGame{
    StartScene *ss = [[StartScene alloc]initWithSize:self.size];
    [self.view presentScene:ss transition:[SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0]];
}

@end

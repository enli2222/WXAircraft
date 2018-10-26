//
//  StartScene.m
//  WXAircraft
//
//  Created by enli on 2018/10/26.
//  Copyright © 2018 enli. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"

@implementation StartScene

-(void)didMoveToView:(SKView *)view{
    self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    SKLabelNode *resultLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    resultLabel.text = @"山寨打飞机";
    resultLabel.fontSize = 30.0;
    resultLabel.fontColor = [SKColor blueColor];
    resultLabel.position = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height /2);
    [self addChild:resultLabel];
    
    SKLabelNode *retryLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    retryLabel.text = @"开始游戏";
    retryLabel.fontSize = 20;
    retryLabel.fontColor = [SKColor blueColor];
    retryLabel.position = CGPointMake(resultLabel.position.x, resultLabel.position.y * 0.8);
    retryLabel.name = @"retryLabel";
    [self addChild:retryLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%f,%f",self.size.width,self.size.height);
    GameScene *gs = [[GameScene alloc]initWithSize:self.size];
    SKTransition *tr = [SKTransition revealWithDirection:SKTransitionDirectionRight duration:1.0];
    [self.view presentScene:gs transition:tr];
}

@end

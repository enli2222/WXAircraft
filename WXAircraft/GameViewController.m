//
//  GameViewController.m
//  WXAircraft
//
//  Created by enli on 2018/10/19.
//  Copyright © 2018年 enli. All rights reserved.
//

#import "GameViewController.h"
#import "StartScene.h"

@implementation GameViewController

-(void)loadView{
    self.view = [[SKView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    StartScene *scene = [[StartScene alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    skView.ignoresSiblingOrder = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

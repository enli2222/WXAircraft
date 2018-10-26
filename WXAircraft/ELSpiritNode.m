//
//  ELSpiritNode.m
//  WXAircraft
//
//  Created by enli on 2018/10/20.
//  Copyright © 2018年 enli. All rights reserved.
//

#import "ELSpiritNode.h"

@implementation ELSpiritNode{
    NSArray *data;
    UIImage *base;
}

-(instancetype)init{
    if (self = [super init]) {
        data =@[@{@"name":@"enemy3_down6",@"frame":@"1,762,166,261"},@{@"name":@"enemy3_hit",@"frame":@"169,765,169,258"},@{@"name":@"enemy3_n1",@"frame":@"340,765,169,258"},@{@"name":@"enemy3_n2",@"frame":@"511,765,169,258"},@{@"name":@"enemy3_down1",@"frame":@"1,499,165,261"},@{@"name":@"enemy3_down2",@"frame":@"1,236,165,261"},@{@"name":@"enemy3_down5",@"frame":@"682,763,166,260"},@{@"name":@"enemy3_down3",@"frame":@"850,763,165,260"},@{@"name":@"hero1",@"frame":@"1,60,204,174"},@{@"name":@"enemy3_down4",@"frame":@"168,499,165,261"},@{@"name":@"hero1_protect1",@"frame":@"335,589,204,174"},@{@"name":@"hero2",@"frame":@"207,147,204,174"},@{@"name":@"hero_blowup_n1",@"frame":@"374,413,204,174"},@{@"name":@"hero_blowup_n2",@"frame":@"413,237,204,174"},@{@"name":@"hero_blowup_n3",@"frame":@"413,61,204,174"},@{@"name":@"bomb",@"frame":@"1,1,63,57"},@{@"name":@"enemy2",@"frame":@"541,664,69, 99"},@{@"name":@"hero_blowup_n4",@"frame":@"612,587,204,174"},@{@"name":@"hero_protect_disapper_n1",@"frame":@"818,587,204,174"},@{@"name":@"hero_protect_disapper_n2",@"frame":@"619,411,204,174"},@{@"name":@"hero_protect_disapper_n3",@"frame":@"619,235,204,174"},@{@"name":@"enemy2_hit",@"frame":@"825,486,69,99"},@{@"name":@"ufo2",@"frame":@"619,126,60,107"},@{@"name":@"enemy2_down1",@"frame":@"825,389,69,95"},@{@"name":@"enemy2_down2",@"frame":@"896,490,69,95"},@{@"name":@"enemy2_down3",@"frame":@"681,138,69,95"},@{@"name":@"enemy2_down4",@"frame":@"825,292,69,95"},@{@"name":@"ufo1",@"frame":@"896,400,58,88"},@{@"name":@"enemy1_down1",@"frame":@"207,94,57,51"},@{@"name":@"enemy1_down2",@"frame":@"66,7,57,51"},@{@"name":@"enemy1_down3",@"frame":@"541,611,57,51"},@{@"name":@"enemy1_down4",@"frame":@"619,73,57,51"},@{@"name":@"game_pause_nor",@"frame":@"752,188,60,45"},@{@"name":@"game_pause_pressed",@"frame":@"825,245,60,45"},@{@"name":@"enemy1",@"frame":@"896,355,57,43"},@{@"name":@"bullet1",@"frame":@"168,300,9,21"},@{@"name":@"bullet2",@"frame":@"335,566,9,21"}];
        base = [UIImage imageNamed:@"shoot"];
    }
    return self;
}

+(instancetype)getShareInstance{
    static dispatch_once_t once;
    static ELSpiritNode *_Spirit;
    dispatch_once(&once, ^{
        _Spirit = [[ELSpiritNode alloc]init];
    });
    return _Spirit;
}

-(UIImage *)getByName:(NSString *)name{
    for (NSDictionary *item in data) {
        if ([item[@"name"] isEqualToString:name]) {
            NSString *temp = item[@"frame"];
            NSArray *tmps = [temp componentsSeparatedByString:@","];
            CGRect rect = CGRectMake([tmps[0] intValue], [tmps[1] intValue], [tmps[2] intValue], [tmps[3] intValue]);
            CGImageRef imageRef = CGImageCreateWithImageInRect([base CGImage], rect);
            UIImage * img = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            return img;
        }
    }
    return nil;
}


@end

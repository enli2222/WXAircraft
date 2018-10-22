//
//  ELSpiritNode.h
//  WXAircraft
//
//  Created by enli on 2018/10/20.
//  Copyright © 2018年 enli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELSpiritNode : NSObject

+(instancetype)getShareInstance;
-(UIImage *)getByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

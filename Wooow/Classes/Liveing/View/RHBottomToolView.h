//
//  RHBottomToolView.h
//  Wooow
//
//  Created by zero on 2016/11/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LiveToolType) {
    LiveToolTypePublicTalk,
    LiveToolTypePrivateTalk,
    LiveToolTypeGift,
    LiveToolTypeRank,
    LiveToolTypeShare,
    LiveToolTypeClose
};

@interface RHBottomToolView : UIView
@property(nonatomic, copy)void (^clickToolBlock)(LiveToolType type);

@end

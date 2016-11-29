//
//  RHTopSeletedView.h
//  哇呜
//
//  Created by zero on 16/7/14.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HomeType) {
    HomeTypeHot, //直播
    HomeTypeSignd,
    HomeTypeNew, // 艺人
    HomeTypeCare, // 关注
    HomeTypeHotStar
};

@interface RHTopSeletedView : UIView

/** 选中了 */
@property(nonatomic, copy)void (^selectedBlock)(HomeType type);
/** 下划线 */
@property (nonatomic, weak, readonly)UIView *underLine;
/** 设置滑动选中的按钮 */
@property(nonatomic, assign) HomeType selectedType;

@end

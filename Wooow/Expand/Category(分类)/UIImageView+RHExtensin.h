//
//  UIImageView+RHExtensin.h
//  哇呜
//
//  Created by zero on 16/7/20.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RHExtensin)
// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;
@end

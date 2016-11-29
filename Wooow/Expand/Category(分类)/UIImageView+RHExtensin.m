//
//  UIImageView+RHExtensin.m
//  哇呜
//
//  Created by zero on 16/7/20.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "UIImageView+RHExtensin.h"

@implementation UIImageView (RHExtensin)
// 播放GIF
- (void)playGifAnim:(NSArray *)images
{
    if (!images.count) {
        return;
    }
    //动画图片数组
    self.animationImages = images;
    //执行一次完整动画所需的时长
    self.animationDuration = 0.5;
    //动画重复次数, 设置成0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}
// 停止动画
- (void)stopGifAnim
{
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}
@end

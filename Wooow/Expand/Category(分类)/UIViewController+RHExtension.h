//
//  UIViewController+RHExtension.h
//  哇呜
//
//  Created by zero on 16/7/20.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RHExtension)

/** Gif加载状态 */
@property(nonatomic, weak) UIImageView *gifView;

/**
 *  显示GIF加载动画
 *
 *  @param images gif图片数组, 不传的话默认是自带的
 *  @param view   显示在哪个view上, 如果不传默认就是self.view
 */
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view;

/**
 *  取消GIF加载动画
 */
- (void)hideGufLoding;

/**
 *  判断数组是否为空
 *
 *  @param array 数组
 *
 *  @return yes or no
 */
- (BOOL)isNotEmpty:(NSArray *)array;

@end

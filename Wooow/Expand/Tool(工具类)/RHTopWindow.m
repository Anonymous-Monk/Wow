//
//  RHTopWindow.m
//  哇呜
//
//  Created by zero on 16/7/20.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHTopWindow.h"

@implementation RHTopWindow
static UIButton *btn_;

+ (void)initialize
{
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
    [btn addTarget:self action:@selector(windowClick) forControlEvents:UIControlEventTouchUpInside];
    [[self statusBarView] addSubview:btn];
    btn.hidden = YES;
    btn_ = btn;
}

+ (void)show
{
    btn_.hidden = NO;
}

+ (void)hide
{
    btn_.hidden = YES;
}

/**
 获取当前状态栏的方法
 */
+ (UIView *)statusBarView
{
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) statusBar = [object valueForKey:key];
    return statusBar;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    NSLog(@"点击了最顶部...");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
@end

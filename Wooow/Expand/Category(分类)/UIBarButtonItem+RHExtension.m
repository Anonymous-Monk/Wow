//
//  UIBarButtonItem+RHExtension.m
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "UIBarButtonItem+RHExtension.h"

@implementation UIBarButtonItem (RHExtension)
+ (instancetype)rh_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end

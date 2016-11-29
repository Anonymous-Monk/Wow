//
//  UIBarButtonItem+RHExtension.h
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RHExtension)
+ (instancetype)rh_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end

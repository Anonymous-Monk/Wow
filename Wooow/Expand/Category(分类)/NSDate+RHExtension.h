//
//  NSDate+RHExtension.h
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (RHExtension)

- (RHDateItem *)rh_timeIntervalSinceDate:(NSDate *)anotherDate;

- (BOOL)rh_isToday;
- (BOOL)rh_isYesterday;
- (BOOL)rh_isTomorrow;
- (BOOL)rh_isThisYear;
//获取今天周几
- (NSInteger)getNowWeekday;



@end

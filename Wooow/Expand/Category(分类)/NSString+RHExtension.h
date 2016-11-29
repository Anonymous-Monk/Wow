//
//  NSString+RHExtension.h
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RHExtension)

/**
 *  md5加密
 */
+ (NSString*)md5HexDigest:(NSString*)input;
/**
 *  根据文件名计算出文件大小
 */
- (unsigned long long)lx_fileSize;
/**
 *  生成缓存目录全路径
 */
- (instancetype)cacheDir;
/**
 *  生成文档目录全路径
 */
- (instancetype)docDir;
/**
 *  生成临时目录全路径
 */
- (instancetype)tmpDir;

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;

/**
 *  DateTime（时间戳）转时间
 *
 *  @param timestamp 1455690170840
 *
 *  @return 2016-02-17 06:22:50 +0000
 */
+(NSDate*)timestampDate:(NSString*)timestamp;
/**
 *
 *  @param date 2016-02-17 06:22:50 +0000
 *
 *  @return Calendar Year:2016 Month:2 Leap month:no Day:17 Hour:14 Minute:22 Second:50 Weekday:4
 */

+(NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;



@end

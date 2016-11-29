//
//  NSString+RHExtension.m
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "NSString+RHExtension.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (RHExtension)

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (unsigned long long)lx_fileSize
{
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    
    // 文件
    return attrs.fileSize;
}

- (instancetype)cacheDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)docDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)tmpDir
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}

+(NSDate*)timestampDate:(NSString *)timestamp{
    NSString *timestampString = timestamp;
    NSTimeInterval _interval = [timestampString doubleValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    return date;
}
+(NSDateComponents *)getDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}


@end

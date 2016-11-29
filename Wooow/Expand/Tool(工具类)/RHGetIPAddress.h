//
//  RHGetIPAddress.h
//  哇呜
//
//  Created by zero on 16/9/27.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHGetIPAddress : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;


+ (NSString *) getMacAddress;


@end

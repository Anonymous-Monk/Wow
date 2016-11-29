//
//  RHUserHelpTools.h
//  漫途社区
//
//  Created by zero on 16/6/12.
//  Copyright © 2016年 漫涂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface RHUserHelpTools : NSObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSNumber * propertyID;
@property (nonatomic, retain) NSString * propertyPhoneNumber;
@property (nonatomic, retain) NSNumber * splashID;
@property (nonatomic, retain) NSString *userNme;
@property (nonatomic, retain) NSString *password;


+(RHUserHelpTools *)getInstance;
-(void)setupInitKeychain;
-(void)setupDefaultKeychain;
-(void)reset;

@end

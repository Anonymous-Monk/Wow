//
//  RHUserHelpTools.m
//  漫途社区
//
//  Created by zero on 16/6/12.
//  Copyright © 2016年 漫涂. All rights reserved.
//

#import "RHUserHelpTools.h"

#define v_default_userID 0
#define v_default_propertyID 0


static KeychainItemWrapper *userItem = nil;
static RHUserHelpTools *_instance = nil;


@implementation RHUserHelpTools

+(RHUserHelpTools *)getInstance
{
    if (!_instance)
        _instance = [[RHUserHelpTools alloc] init];
    return _instance;
}

-(id)init
{
    if(self = [super init])
    {
        if (!userItem) {
            userItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"User" accessGroup:nil];
        }
    }
    
    return self;
}

-(void)setupInitKeychain{
    NSString *AttrService = [userItem objectForCustKey:(__bridge id)kSecAttrService];
    if ([AttrService isEqualToString:@"mantoto"]) {
        return;
    }
   // [self setupDefaultKeychain];
}

-(void)setupDefaultKeychain{
    [userItem setObject:@"mantoto" custKey:(__bridge id)kSecAttrService];
    self.userID = [NSNumber numberWithInt:v_default_userID];
    self.propertyID = [NSNumber numberWithInt:v_default_propertyID];
}

-(void)reset{
    [userItem resetKeychainItem];
}


#pragma mark - setter

-(NSString *)userNme{
    return [userItem objectForCustKey:(__bridge id)kSecAttrLabel];
}
-(void)setUserNme:(NSString *)newValue{
    [userItem setObject:[NSString stringWithFormat:@"%@",newValue] custKey:(__bridge id)kSecAttrLabel];
}

-(NSString *)password{
    return [userItem objectForCustKey:(__bridge id)kSecAttrComment];
}
-(void)setPassword:(NSString *)newValue{
    [userItem setObject:[NSString stringWithFormat:@"%@",newValue] custKey:(__bridge id)kSecAttrComment];
}



-(NSNumber *)propertyID{
    return [userItem objectForCustKey:(__bridge id)kSecValueData];
}
-(void)setPropertyID:(NSNumber *)newValue{
    [userItem setObject:[NSString stringWithFormat:@"%@",newValue] custKey:(__bridge id)kSecValueData];
}

-(NSNumber *)userID{
     return [userItem objectForCustKey:(__bridge id)kSecAttrAccount];
}

-(void)setUserID:(NSNumber *)newValue{
    [userItem setObject:[NSString stringWithFormat:@"%@",newValue] custKey:(__bridge id)kSecAttrAccount];
}

-(NSString *)token{
      return [userItem objectForCustKey:(__bridge id)kSecAttrGeneric];
}

-(void)setToken:(NSString *)newValue{
      [userItem setObject:newValue custKey:(__bridge id)kSecAttrGeneric];
}


-(NSString *)propertyPhoneNumber{
      return [userItem objectForCustKey:(__bridge id)kSecAttrDescription];
}

-(void)setPropertyPhoneNumber:(NSString *)newValue{
      [userItem setObject:newValue custKey:(__bridge id)kSecAttrDescription];
}


@end

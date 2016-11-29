//
//  RHUserView.h
//  Wooow
//
//  Created by zero on 2016/11/19.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHLiveUserModel.h"
@interface RHUserView : UIView
@property(nonatomic,strong) RHLiveUserModel *userModel; //<<#description#>
@property (nonatomic, copy) void (^closeBlock)();

@end

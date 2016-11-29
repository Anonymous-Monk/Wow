//
//  RHLiveAuthorView.h
//  Wooow
//
//  Created by zero on 2016/11/3.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHHotLiveModel.h"
@interface RHLiveAuthorView : UIView


@property(nonatomic, copy)void (^clickFavAction)(bool selected);
@property(nonatomic,strong) RHHotLiveModel *liveModel; //<<#description#>

@end

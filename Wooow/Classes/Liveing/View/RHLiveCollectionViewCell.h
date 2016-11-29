//
//  RHLiveCollectionViewCell.h
//  Wooow
//
//  Created by zero on 2016/11/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHHotLiveModel.h"

@interface RHLiveCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) RHHotLiveModel *liveModel; //<主播
@property (nonatomic, strong) RHHotLiveModel *relateLive; //<关联主播
@property (nonatomic, weak) UIViewController *parentVc; //<父控制器
@property (nonatomic, copy) void (^clickRelatedLive)(); //<点击关联主播回调
@end

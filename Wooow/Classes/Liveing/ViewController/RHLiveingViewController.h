//
//  RHLiveingViewController.h
//  哇呜
//
//  Created by zero on 16/7/16.
//  Copyright © 2016年 zero. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RHHotLiveModel.h"
@interface RHLiveingViewController : UICollectionViewController

@property(nonatomic,strong) RHHotLiveModel *liveModel; //<<#description#>
@property(nonatomic,strong) NSMutableArray *liveDatas; //<直播数据
@property(nonatomic,assign) NSInteger currentIndex; //<当前索引
@end

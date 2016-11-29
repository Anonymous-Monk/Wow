//
//  RHAdHomeCell.h
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRCarouselView.h"
#import "RHAdHomeModel.h"
@interface RHAdHomeCell : UITableViewCell<XRCarouselViewDelegate>
@property(nonatomic,strong) RHAdHomeModel *adHomeModel;
/** 顶部AD数组 */
@property (nonatomic, strong) NSArray *topADs;
/** 点击图片的block */
@property (nonatomic, copy) void (^imageClickBlock)(RHAdHomeModel *topAD);
@end

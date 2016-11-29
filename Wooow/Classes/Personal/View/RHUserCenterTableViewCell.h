//
//  RHUserCenterTableViewCell.h
//  哇呜
//
//  Created by zero on 16/8/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RHUserCenterItemModel;
@interface RHUserCenterTableViewCell : UITableViewCell
@property (nonatomic,strong) RHUserCenterItemModel  *item; /**< item data*/
@property(nonatomic,assign) CGFloat cellHeight; //<<#description#>

@end

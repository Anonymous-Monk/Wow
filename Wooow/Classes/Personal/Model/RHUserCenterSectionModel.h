//
//  RHUserCenterSectionModel.h
//  哇呜
//
//  Created by zero on 16/8/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHUserCenterSectionModel : NSObject
@property (nonatomic,copy) NSString  *sectionHeaderName; /**< 传空表示分组无名称*/

@property (nonatomic,assign) CGFloat  sectionHeaderHeight; /**<      分组header高度*/

@property (nonatomic,strong) NSArray  *itemArray; /**< item模型数组*/

@property (nonatomic,strong) UIColor  *sectionHeaderBgColor; /**< 背景色*/
@end

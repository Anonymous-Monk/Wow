//
//  RHUserCenterItemModel.h
//  哇呜
//
//  Created by zero on 16/8/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HooUserCenterAccessoryType) {
    HooUserCenterAccessoryTypeNone,                   // don't show any accessory view
    HooUserCenterAccessoryTypeDisclosureIndicator,    // the same with system DisclosureIndicator
    HooUserCenterAccessoryTypeSwitch,                 //  swithch
};


@interface RHUserCenterItemModel : NSObject

@property (nonatomic,copy) NSString  *funcName;     /**<      功能名称*/
@property (nonatomic,strong) UIImage *img;          /**< 功能图片  */
@property (nonatomic,copy) NSString *detailText;    /**< 更多信息-提示文字  */
@property (nonatomic,strong) UIImage *detailImage;  /**< 更多信息-提示图片  */
@property (nonatomic,assign) HooUserCenterAccessoryType  accessoryType;    /**< accessory */
@property (nonatomic,copy) void (^executeCode)(); /**<      点击item要执行的代码*/
@property (nonatomic,copy) void (^switchValueChanged)(BOOL isOn); /**<  HooUserCenterAccessoryTypeSwitch下开关变化 */

@end

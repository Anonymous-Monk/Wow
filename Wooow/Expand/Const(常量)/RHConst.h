//
//  RHConst.h
//  哇呜
//
//  Created by zero on 16/7/14.
//  Copyright © 2016年 zero. All rights reserved.
//

#ifndef RHConst_h
#define RHConst_h

// 首页的选择器的宽度
#define DefaultMargin       5
#define Home_Seleted_Item_W ((RHScreenWidth - 30) / 5.0)


// 屏幕宽/高
#define RHScreenWidth  [UIScreen mainScreen].bounds.size.width
#define RHScreenHeight [UIScreen mainScreen].bounds.size.height

//除去信号区的屏幕的frame
#define RH_APP_FRAME  [[UIScreen mainScreen] bounds]
//应用程序的屏幕高度
#define RH_APP_FRAME_H   [[UIScreen mainScreen] applicationFrame].size.height
//应用程序的屏幕宽度
#define RH_APP_FRAME_W    [[UIScreen mainScreen] applicationFrame].size.width


// View 坐标(x,y)和宽高(width,height)
#define RH_X(v)                    (v).frame.origin.x
#define RH_Y(v)                    (v).frame.origin.y
#define RH_WIDTH(v)                (v).frame.size.width
#define RH_HEIGHT(v)               (v).frame.size.height

#define RH_MinX(v)                 CGRectGetMinX((v).frame)
#define RH_MinY(v)                 CGRectGetMinY((v).frame)

#define RH_MidX(v)                 CGRectGetMidX((v).frame)
#define RH_MidY(v)                 CGRectGetMidY((v).frame)

#define RH_MaxX(v)                 CGRectGetMaxX((v).frame)
#define RH_MaxY(v)                 CGRectGetMaxY((v).frame)

// 系统控件默认高度
#define RHStatusBarHeight        (20.f)

#define RHTopBarHeight           (44.f)
#define RHBottomBarHeight        (49.f)

#define RHCellDefaultHeight      (44.f)

//中英键盘高度
#define RHEnglishKeyboardHeight  (216.f)
#define RHChineseKeyboardHeight  (252.f)



#define kNotifyClickUser @"kNotifyClickUser"



#endif /* RHConst_h */

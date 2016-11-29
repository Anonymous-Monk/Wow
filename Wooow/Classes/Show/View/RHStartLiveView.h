//
//  RHStartLiveView.h
//  Wooow
//
//  Created by zero on 2016/11/19.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PareLiveType) {
    PareLiveTypeClose,
    PareLiveTypeTransCam,
    PareLiveTypeAddPic,
    PareLiveTypeStartLive
};


@interface RHStartLiveView : UIView

@property(nonatomic,copy) void (^clickPareType)(PareLiveType type); //<<#description#>

@end

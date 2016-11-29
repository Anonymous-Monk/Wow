//
//  RHTabBarViewController.m
//  哇呜
//
//  Created by zero on 16/7/19.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHTabBarViewController.h"
#import "RHNavViewController.h"
#import "RHHomeViewController.h"
#import "RHShowViewController.h"
#import "RHPersonalViewController.h"
#import "UIImage+RHExtension.h"

@interface RHTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation RHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setShadowImage:[UIImage new]];

    [self.tabBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:RGBCOLOR(200, 0, 102) ,NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    self.delegate = self;
    [self setup];
}


- (void)setup
{
    [self addChildViewController:[[RHHomeViewController alloc]init] imageNamed:@"首页" seletedImage:@"首页"];
    UIViewController *showTime = [[UIViewController alloc] init];
    showTime.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:showTime imageNamed:@"直播" seletedImage:@"直播"];
    [self addChildViewController:[[RHPersonalViewController alloc] init] imageNamed:@"个人" seletedImage:@"个人"];
}

- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName seletedImage:(NSString *)seletedImage
{
    RHNavViewController *nav = [[RHNavViewController alloc] initWithRootViewController:childController];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *image_sel = [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]];
    childController.tabBarItem.image = [image_sel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    childController.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置图片居中, 这儿需要注意top和bottom必须绝对值一样大
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

    
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-2) {
//        // 判断是否是模拟器
//        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
//            [self showInfo:@"请用真机进行测试, 此模块不支持模拟器测试"];
//            return NO;
//        }
//        
//        // 判断是否有摄像头
//        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//            [self showInfo:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
//            return NO;
//        }
//        
//        // 判断是否有摄像头权限
//        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
//            [self showInfo:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
//            return NO;
//        }
//        
//        // 开启麦克风权限
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
//            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
//                if (granted) {
//                    return YES;
//                }
//                else {
//                    [self showInfo:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
//                    return NO;
//                }
//            }];
//        }
//        
//        ShowTimeViewController *showTimeVc = [UIStoryboard storyboardWithName:NSStringFromClass([ShowTimeViewController class]) bundle:nil].instantiateInitialViewController;
//        [self presentViewController:showTimeVc animated:YES completion:nil];
//        return NO;
        
        RHShowViewController *showVC =[[RHShowViewController alloc]init];
        [self presentViewController:showVC animated:YES completion:nil];
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

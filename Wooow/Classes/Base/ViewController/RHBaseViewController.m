//
//  RHBaseViewController.m
//  哇呜
//
//  Created by zero on 16/7/13.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHBaseViewController.h"
#import "AppDelegate.h"
#import "UIImage+RHExtension.h"
@interface RHBaseViewController ()

@end

@implementation RHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
    statusBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabbarBack"]];
    //[self.navigationController.navigationBar addSubview:statusBarView];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.231 green:0.518 blue:1.000 alpha:1.000]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:RGBCOLOR(200, 0, 102)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

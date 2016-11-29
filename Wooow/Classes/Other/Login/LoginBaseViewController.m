//
//  LoginBaseViewController.m
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "LoginBaseViewController.h"

@interface LoginBaseViewController ()<UITextFieldDelegate>

@end

@implementation LoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.131 green:0.416 blue:0.581 alpha:1.000];
    //self.view.alpha = 0.5;
//    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    backImageView.image = [UIImage imageNamed:@"loginBaseBackImg"];
//    [self.view addSubview:backImageView];
//    [self.view sendSubviewToBack:backImageView];
    
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        [self.view endEditing:YES];
    }
    
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

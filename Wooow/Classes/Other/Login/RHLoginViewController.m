//
//  RHLoginViewController.m
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHLoginViewController.h"
#import "RHRegisterViewController.h"
#import "RHGetCodeViewController.h"
#import "RHTabBarViewController.h"
@interface RHLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *forgetpassLab;

@property (weak, nonatomic) IBOutlet UIButton *keepLoginBtn;
@property(nonatomic,strong) RHUserHelpTools *userTools; //<<#description#>
@end

@implementation RHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _userTools = [RHUserHelpTools getInstance];


      // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
        [self checkIsAutoLogin];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkIsAutoLogin{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        NSLog(@"%@",[AVUser currentUser]);
        RHTabBarViewController *tabVC = [[RHTabBarViewController alloc]init];
        [self presentViewController:tabVC animated:NO completion:nil];
    }else{
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"]) {
            [AVUser logInWithUsernameInBackground:_userTools.userNme password:_passwordTextField.text block:^(AVUser *user, NSError *error) {
                if (user != nil) {
                    NSLog(@"登录成功");
                    _userNameTextField.text = _userTools.userNme;
                    _passwordTextField.text = _userTools.password;
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    RHTabBarViewController *tabVC = [[RHTabBarViewController alloc]init];
                    [self presentViewController:tabVC animated:NO completion:nil];
                } else {
                    NSLog(@"登录失败");
                }
            }];
        }
    }

}

- (IBAction)didClickBackAction:(id)sender {
    
}
- (IBAction)didClickRegisterAction:(id)sender {
    RHRegisterViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RHRegisterViewController"];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)didClickKeepAction:(id)sender {
    self.keepLoginBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keepState"]];
}

- (IBAction)didClickForgetPassword:(id)sender {
    RHGetCodeViewController *getCodeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RHGetCodeViewController"];
    [self.navigationController pushViewController:getCodeVC animated:YES];
}

- (IBAction)didClickLoginAction:(id)sender {

    [AVUser logInWithUsernameInBackground:_userNameTextField.text password:_passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登录成功");
            [_userTools reset];//重置钥匙串内数据
//            _userTools.userNme = _userNameTextField.text;
//            _userTools.password = _passwordTextField.text;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            RHTabBarViewController *tabVC = [[RHTabBarViewController alloc]init];
            [self presentViewController:tabVC animated:NO completion:nil];
        } else {
            NSLog(@"登录失败");
        }
    }];
}

- (IBAction)didClickWXLoginAction:(id)sender {
}
- (IBAction)didClickQQLoginAction:(id)sender {
}
- (IBAction)didClickVisitAction:(id)sender {
    RHTabBarViewController *tabVC = [[RHTabBarViewController alloc]init];
    [self presentViewController:tabVC animated:NO completion:nil];
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

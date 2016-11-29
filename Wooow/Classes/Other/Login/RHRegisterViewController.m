//
//  RHRegisterViewController.m
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHRegisterViewController.h"
@interface RHRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addPhotoBtn;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *authorCode;
@property (weak, nonatomic) IBOutlet UIButton *getPhoneCode;

@end

@implementation RHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addPhotoBtn.layer.borderWidth = 5;
    self.addPhotoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // Do any additional setup after loading the view.
}
- (IBAction)didClickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickRegisterAction:(id)sender {
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = _userName.text;// 设置用户名
    user.password =  _password.text;// 设置密码
    user.email = _email.text;// 设置邮箱
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功");
        } else {
            NSLog(@"失败的原因可能有多种，常见的是用户名已经存在。");
        }
    }];
}
- (IBAction)didClickGetPhoneCodeAction:(id)sender {
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

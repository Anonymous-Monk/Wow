//
//  RHUserInfoViewController.m
//  Wow
//
//  Created by zero on 16/10/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHUserInfoViewController.h"
#import "RHUserCenterTableViewCell.h"
#import "RHUserCenterItemModel.h"
#import "RHUserCenterSectionModel.h"
@interface RHUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSArray *sectionArray; //<<#description#>
@property(nonatomic,strong) UITableView *userCenterTBV; //<<#description#>


@end

@implementation RHUserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSections];
    self.title = @"编辑资料";
    self.userCenterTBV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.userCenterTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userCenterTBV.delegate = self;
    self.userCenterTBV.dataSource = self;
    [self.view addSubview:self.userCenterTBV];
    // Do any additional setup after loading the view.
}


- (void)showAlert:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"点击了" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

#pragma - mark setup
- (void)setupSections
{
    //************************************section1
    RHUserCenterItemModel *item1 = [[RHUserCenterItemModel alloc]init];
    item1.funcName = @"头像";
    item1.detailImage = [UIImage imageNamed:@"icon-new"];
    item1.executeCode = ^{
        NSLog(@"我的头像");
    };
    item1.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    
    RHUserCenterSectionModel *section1 = [[RHUserCenterSectionModel alloc]init];
    section1.sectionHeaderHeight = 14;
    section1.itemArray = @[item1];
    
    //************************************section2
    RHUserCenterItemModel *item2 = [[RHUserCenterItemModel alloc]init];
    item2.funcName = @"昵称";
    item2.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    item2.detailText = [AVUser currentUser].username;
    
    RHUserCenterItemModel *item3 = [[RHUserCenterItemModel alloc]init];
    item3.funcName = @"ID";
    item3.accessoryType = HooUserCenterAccessoryTypeNone;
    item3.executeCode = ^{
        
    };
    
    RHUserCenterItemModel *item4 = [[RHUserCenterItemModel alloc]init];
    item4.funcName = @"性别";
    item4.detailText = @"男";
    item4.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item5 = [[RHUserCenterItemModel alloc]init];
    item5.funcName = @"个性签名";
    item5.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section2 = [[RHUserCenterSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item2,item3,item4,item5];
    
    
    //************************************section3
    RHUserCenterItemModel *item6 = [[RHUserCenterItemModel alloc]init];
    item6.funcName = @"我的头衔";
    item6.detailImage = [UIImage imageNamed:@"icon-new"];
    item6.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item7 = [[RHUserCenterItemModel alloc]init];
    item7.funcName = @"我的等级";
    item7.detailImage = [UIImage imageNamed:@"icon-new"];
    item7.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section3 = [[RHUserCenterSectionModel alloc]init];
    section3.sectionHeaderHeight = 18;
    section3.itemArray = @[item6,item7];
    
    RHUserCenterItemModel *item8 = [[RHUserCenterItemModel alloc]init];
    item8.funcName = @"实名认证";
    item8.detailText = @"暂未实名认证";
    item8.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;

    RHUserCenterItemModel *item9 = [[RHUserCenterItemModel alloc]init];
    item9.funcName = @"绑定手机";
    item9.detailText = @"暂未绑定";
    item9.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;

    RHUserCenterSectionModel *section4 = [[RHUserCenterSectionModel alloc]init];
    section4.sectionHeaderHeight = 18;
    section4.itemArray = @[item8,item9];
    
    self.sectionArray = @[section1,section2,section3,section4];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RHUserCenterSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"userInfo";
    RHUserCenterSectionModel *sectionModel = self.sectionArray[indexPath.section];
    RHUserCenterItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    RHUserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RHUserCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.item = itemModel;
    return cell;
}

#pragma - mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    RHUserCenterSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.sectionHeaderHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RHUserCenterSectionModel *sectionModel = self.sectionArray[indexPath.section];
    RHUserCenterItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    if (itemModel.executeCode) {
        itemModel.executeCode();
    }
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

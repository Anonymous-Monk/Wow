//
//  RHSetViewController.m
//  哇呜
//
//  Created by zero on 16/8/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHSetViewController.h"
#import "RHUserCenterTableViewCell.h"
#import "RHUserCenterItemModel.h"
#import "RHUserCenterSectionModel.h"
@interface RHSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSArray *sectionArray; //<<#description#>
@property(nonatomic,strong) UITableView *userCenterTBV; //<<#description#>

@end

@implementation RHSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSections];
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
    item1.funcName = @"我的余额";
    item1.executeCode = ^{
        NSLog(@"我的余额");
        [self showAlert:@"我的余额"];
    };
    item1.detailText = @"做任务赢大奖";
    item1.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item2 = [[RHUserCenterItemModel alloc]init];
    item2.funcName = @"修改密码";
    item2.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section1 = [[RHUserCenterSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2];
    
    //************************************section2
    RHUserCenterItemModel *item3 = [[RHUserCenterItemModel alloc]init];
    item3.funcName = @"推送提醒";
    item3.accessoryType = HooUserCenterAccessoryTypeSwitch;
    item3.switchValueChanged = ^(BOOL isOn)
    {
        NSLog(@"推送提醒开关状态===%@",isOn?@"open":@"close");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推送提醒" message:isOn?@"open":@"close" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    };
    
    RHUserCenterItemModel *item4 = [[RHUserCenterItemModel alloc]init];
    item4.funcName = @"给我们打分";
    item4.detailImage = [UIImage imageNamed:@"icon-new"];
    item4.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item5 = [[RHUserCenterItemModel alloc]init];
    item5.funcName = @"意见反馈";
    item5.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section2 = [[RHUserCenterSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item3,item4,item5];
    
    
    //************************************section3
    RHUserCenterItemModel *item6 = [[RHUserCenterItemModel alloc]init];
    item6.funcName = @"关于我们";
    item6.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item7 = [[RHUserCenterItemModel alloc]init];
    item7.funcName = @"帮助中心";
    item7.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item8 = [[RHUserCenterItemModel alloc]init];
    item8.funcName = @"清除缓存";
    item8.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section3 = [[RHUserCenterSectionModel alloc]init];
    section3.sectionHeaderHeight = 18;
    section3.itemArray = @[item6,item7,item8];
    
    self.sectionArray = @[section1,section2,section3];
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
    static NSString *identifier = @"setting";
    RHUserCenterSectionModel *sectionModel = self.sectionArray[indexPath.section];
    RHUserCenterItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    RHUserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
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

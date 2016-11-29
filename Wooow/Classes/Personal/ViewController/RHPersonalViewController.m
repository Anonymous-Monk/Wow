//
//  RHPersonalViewController.m
//  哇呜
//
//  Created by zero on 16/10/2.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHPersonalViewController.h"
#import "RHHeaderView.h"
#import "RHUserCenterTableViewCell.h"
#import "RHUserCenterItemModel.h"

#import "RHUserCenterSectionModel.h"
#import "RHSetViewController.h"
#import "RHUserInfoViewController.h"

#import "RHTestCollectionViewController.h"
#import "RHTestTableViewController.h"

@interface RHPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) RHHeaderView *headView; //<<#description#>

@property(nonatomic,strong) NSArray *sectionArray; //<<#description#>
@property(nonatomic,strong) UITableView *userCenterTBV; //<<#description#>

@end

@implementation RHPersonalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"个人中心";
    [self setupSections];
    self.userCenterTBV = [[UITableView alloc]init];
    self.userCenterTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userCenterTBV.delegate = self;
    self.userCenterTBV.dataSource = self;
    [self.view addSubview:self.userCenterTBV];
    [self.userCenterTBV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];

    self.headView = [[RHHeaderView alloc]initWithFrame:CGRectMake(0, 0, RHScreenWidth, 180)];
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [editBtn addTarget:self action:@selector(didTapEditAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.headView);
        make.bottom.mas_equalTo(self.headView.mas_bottom).offset(-50);
        make.left.mas_equalTo(self.headView.mas_left).offset(150);
    }];
    
    
    self.userCenterTBV.tableHeaderView = self.headView;
    
    
}



- (void)setupSections
{
    
    //************************************section1
    RHUserCenterItemModel *item1 = [[RHUserCenterItemModel alloc]init];
    item1.funcName = @"我的资产";
    item1.executeCode = ^{
        NSLog(@"我的资产");
    };
    item1.img = [UIImage imageNamed:@"古钱币"];
    item1.detailText = @"288";
    item1.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    
    RHUserCenterItemModel *item2 = [[RHUserCenterItemModel alloc]init];
    item2.funcName = @"直播间管理";
    item2.img = [UIImage imageNamed:@"管理"];
    item2.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item3 = [[RHUserCenterItemModel alloc]init];
    item3.funcName = @"做任务赢大奖";
    item3.img = [UIImage imageNamed:@"任务"];
    item3.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section1 = [[RHUserCenterSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2,item3];
    
    RHUserCenterItemModel *item5 = [[RHUserCenterItemModel alloc]init];
    item5.funcName = @"我的收益";
    item5.img = [UIImage imageNamed:@"收益"];
    item5.executeCode = ^{
        NSLog(@"我的收益");
    };
    item5.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterItemModel *item6 = [[RHUserCenterItemModel alloc]init];
    item6.funcName = @"游戏中心";
    item6.img = [UIImage imageNamed:@"游戏"];
    item6.executeCode = ^{
        
    };
    item6.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section2 = [[RHUserCenterSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item5,item6];
    
    RHUserCenterItemModel *item7 = [[RHUserCenterItemModel alloc]init];
    item7.funcName = @"设置";
    item7.img = [UIImage imageNamed:@"设置"];
    item7.accessoryType = HooUserCenterAccessoryTypeDisclosureIndicator;
    
    RHUserCenterSectionModel *section3 = [[RHUserCenterSectionModel alloc]init];
    section3.sectionHeaderHeight = 18;
    section3.itemArray = @[item7];
    
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

#pragma mark - Table view delegate
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
    
    if (indexPath.row == 0) {
        RHSetViewController *fontVC = [[RHSetViewController alloc]init];
        fontVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fontVC animated:YES];
    }else if (indexPath.row ==1){
        RHSetViewController *getIpAddressVC = [[RHSetViewController alloc]init];
        getIpAddressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:getIpAddressVC animated:YES];
    }else{
        RHTestTableViewController *setVC = [[RHTestTableViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
}
//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    RHUserCenterSectionModel *sectionModel = [self.sectionArray firstObject];
    CGFloat sectionHeaderHeight = sectionModel.sectionHeaderHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)didTapEditAction{
    RHUserInfoViewController *userInfoVC = [[RHUserInfoViewController alloc]init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
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

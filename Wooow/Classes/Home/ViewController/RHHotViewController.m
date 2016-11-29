//
//  RHHotViewController.m
//  哇呜
//
//  Created by zero on 16/7/14.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHHotViewController.h"
#import "RHLiveingViewController.h"
#import "RHAdWebViewController.h"
#import "RHAdHomeModel.h"
#import "RHHotLiveModel.h"
#import "RHAdHomeCell.h"
#import "RHHotLiveCell.h"
#import <MJRefresh.h>
@interface RHHotViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *hotListTableview; //<<#description#>
@property(nonatomic,strong) NSMutableArray *dataArr; //<<#description#>
@property(nonatomic, strong) NSArray *topADS;
@property(nonatomic, assign) NSUInteger currentPage;
@property(strong,nonatomic) NSMutableSet *showIndexes; // </

@end

static NSString *hotListIdentifier = @"HotLiveCell";
static NSString *adHomeIdentifier = @"HomeADCell";

@implementation RHHotViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _showIndexes = [NSMutableSet set];

    self.currentPage = 1;
    [self getData];
    [self getLiveListData];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    self.hotListTableview = [[UITableView alloc]init];
    [self.hotListTableview registerClass:[RHHotLiveCell class] forCellReuseIdentifier:hotListIdentifier];
    [self.hotListTableview registerClass:[RHAdHomeCell class] forCellReuseIdentifier:adHomeIdentifier];
    self.hotListTableview.delegate = self;
    self.hotListTableview.dataSource = self;
    self.hotListTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.hotListTableview];
    [self.hotListTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(RHScreenHeight - RHTopBarHeight - RHBottomBarHeight - 55);
    }];
    
    self.currentPage = 1;
    self.hotListTableview.mj_header = [RHGifRefreshHeader headerWithRefreshingBlock:^{
        self.dataArr = [NSMutableArray array];
        self.currentPage = 1;
        // 获取顶部的广告
        [self getData];
        [self getLiveListData];
    }];
    
    self.hotListTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self getLiveListData];
    }];
    
    [self.hotListTableview.mj_header beginRefreshing];
    NSLog(@"%f",self.view.frame.size.height);
}

-(void)getData{
    [RHNetworkingTools getWithUrl:@"http://live.9158.com/Living/GetAD" refreshCache:YES params:nil success:^(id response) {
        NSArray *result = response[@"data"];
        if (result != nil) {
            self.topADS = [NSArray new];
            self.topADS = [RHAdHomeModel mj_objectArrayWithKeyValuesArray:result];
            [self.hotListTableview reloadData];
        }else{
            self.currentPage--;
        }
        [self.hotListTableview.mj_header endRefreshing];
        [self.hotListTableview.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        self.currentPage--;
        [self.hotListTableview.mj_header endRefreshing];
        [self.hotListTableview.mj_footer endRefreshing];
        NSLog(@"获取数据失败");
    }];
}

-(void)getLiveListData{
    [RHNetworkingTools getWithUrl:[NSString stringWithFormat:@"http://live.9158.com/Room/GetHotLive_v2?type=1&page=%ld", self.currentPage] refreshCache:YES success:^(id response) {
        NSUInteger codeID = [[(NSDictionary *)response objectForKey:@"code"] integerValue];
        
        if (codeID == 106) {
            self.currentPage--;
            [self.hotListTableview.mj_footer endRefreshing];
            return ;
        }
        NSArray *result = [RHHotLiveModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];

        if (result != nil) {
            [self.dataArr addObjectsFromArray:result];
            [self.hotListTableview reloadData];
        }else{
            self.currentPage--;
        }
        [self.hotListTableview.mj_header endRefreshing];
        [self.hotListTableview.mj_footer endRefreshing];

    } fail:^(NSError *error) {
        NSLog(@"获取数据失败");
        self.currentPage--;
        [self.hotListTableview.mj_header endRefreshing];
        [self.hotListTableview.mj_footer endRefreshing];

    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        RHAdHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:adHomeIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.topADs = self.topADS;
        __weak typeof(self) weakSelf = self;
        [cell setImageClickBlock:^(RHAdHomeModel *topAD) {
            if (topAD.link.length) {
                RHAdWebViewController *adVC = [[RHAdWebViewController alloc]initWithUrlStr:topAD.link];
                adVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:adVC animated:YES];
    
            }
        }];
        return cell;
    }
    RHHotLiveCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RHHotLiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotListIdentifier];
    }
    cell.hotLiveModel = self.dataArr[indexPath.row -1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }else{
        RHLiveingViewController *liveingVC = [[RHLiveingViewController alloc]init];
        liveingVC.liveDatas = self.dataArr;
        liveingVC.currentIndex = indexPath.row - 1;
        [self presentViewController:liveingVC animated:YES completion:nil];

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return 100;
    }
    return RHScreenWidth  + 100 ;
}

//cell开始动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.showIndexes containsObject:indexPath]) {
        [self.showIndexes addObject:indexPath];
        
        cell.layer.transform = CATransform3DTranslate(cell.layer.transform, 300, 0, 0);
        cell.alpha = 0.5;
        [UIView animateWithDuration:0.3 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.alpha = 1;
        } completion:nil];
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

//
//  RHListViewController.m
//  哇呜
//
//  Created by zero on 16/7/14.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHListViewController.h"
#import "RHConst.h"
#import "UIView+Borders.h"
#import "UIView+Animation.h"
#import "RHLiveUserModel.h"
#import "RHListCollectionViewCell.h"
#import "RHLiveingViewController.h"
#import "RHHotLiveModel.h"

#define C_OFFSET 10
#define C_CELLWIDTH ((RHScreenWidth-C_OFFSET*3)/2)
#define C_CELLHEIGHT 233

@interface RHListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UIScrollView *contentScrollview; //<<#description#>
@property(nonatomic,strong) UIView *topView; //<description
@property(nonatomic,strong) UIView *middle1View; //<description
@property(nonatomic,strong) UIView *middle2View; //<description
@property(nonatomic,strong) UIView *bottomView; //<description
@property(nonatomic,strong) UICollectionView *listCollectionView; //<<#description#>
@property(nonatomic,strong) NSMutableArray *dataArr; //<<#description#>
@property(nonatomic,assign) NSInteger currentIndex; //<<#description#>
@end

@implementation RHListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}



-(void)initView{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    _listCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, RHScreenWidth, RHScreenHeight - 150) collectionViewLayout:flow];
    _listCollectionView.backgroundColor = [UIColor whiteColor];
    [_listCollectionView registerClass:[RHListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    [self.view addSubview:_listCollectionView];
    
    _listCollectionView.mj_header = [RHGifRefreshHeader headerWithRefreshingBlock:^{
        _currentIndex = 1;
        [self getData];
    } ];
    _listCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _currentIndex++;
        [self getData];
    }];
    
    [_listCollectionView.mj_header beginRefreshing];
}

-(void)endRefresh{
    [_listCollectionView.mj_header endRefreshing];
    [_listCollectionView.mj_footer endRefreshing];
}

-(void)getData{
    
    [RHNetworkingTools getWithUrl:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", _currentIndex] refreshCache:YES success:^(id response) {
        NSString *statuMsg = response[@"msg"];
        if ([statuMsg isEqualToString:@"fail"]) { // 数据已经加载完毕, 没有更多数据了
            // 恢复当前页
            _currentIndex--;
            [self endRefresh];
        }else{
            [response[@"data"][@"list"] writeToFile:@"/Users/apple/Desktop/user.plist" atomically:YES];
            NSArray *result = [RHLiveUserModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
            if (result.count) {
                [self.dataArr addObjectsFromArray:result];
                [self.listCollectionView reloadData];
                [self endRefresh];
            }
        }
    } fail:^(NSError *error) {
        _currentIndex--;
        [self endRefresh];

    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RHListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;//抗锯齿
    cell.liveUser = _dataArr[indexPath.item];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RHLiveingViewController *liveingVC = [[RHLiveingViewController alloc]init];
    NSMutableArray *array = [NSMutableArray array];
    for (RHLiveUserModel *user in self.dataArr) {
        RHHotLiveModel *live = [[RHHotLiveModel alloc] init];
        live.bigpic = user.photo;
        live.myname = user.nickname;
        live.smallpic = user.photo;
        live.gps = user.position;
        live.useridx = user.useridx;
        live.allnum = arc4random_uniform(2000);
        live.flv = user.flv;
        [array addObject:live];
    }
    liveingVC.liveDatas = array;
    liveingVC.currentIndex = indexPath.item;
    liveingVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:liveingVC animated:YES completion:nil];}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //  return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
    return CGSizeMake(C_CELLWIDTH, C_CELLWIDTH + 30);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(C_OFFSET, C_OFFSET, C_OFFSET, C_OFFSET);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return C_OFFSET;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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

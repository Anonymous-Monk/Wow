//
//  RHHomeViewController.m
//  哇呜
//
//  Created by zero on 16/7/13.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHHomeViewController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"
#import "RHTopSeletedView.h"
#import "RHHotViewController.h"
#import "RHSignStarViewController.h"
#import "RHListViewController.h"
#import "RHCareViewController.h"
#import "RHHotStarViewController.h"
#import "RHRankViewController.h"
#import "PYSearch.h"
@interface RHHomeViewController ()<UIScrollViewDelegate,PYSearchViewControllerDelegate>
/** 顶部选择视图 */
@property(nonatomic, assign) RHTopSeletedView *selectedView;
@property(nonatomic,strong) NinaPagerView *headPageView; //<<#description#>
/** UIScrollView */
@property(nonatomic, weak) UIScrollView *scrollView;
@property(nonatomic,strong) RHHotViewController *hotVC;
@property(nonatomic,strong) RHSignStarViewController *signedVC;
@property(nonatomic,strong) RHListViewController *listVC;
@property(nonatomic,strong) RHCareViewController *careVC;
@property(nonatomic,strong) RHHotStarViewController *hotStarVC; //<<#description#>
@end

@implementation RHHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"星播";
    
    //[self setupHeadView];
    [self setupTopTitleView];
    [self setupSubviews];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftItem)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"排行榜"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightItem)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)didClickLeftItem{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Care「皮卡鹿」�", @"光芒丶小野猫Zoe", @"Angel-虎牙妹", @"凤舞💋小点", @"【喵族】UU", @"喵星人灬Disy", @"厉害了Word翠", @"🙆🙆大兔子🙆�", @"小-白-杨", @"Crazy、惠子💗", @"MS五尺😇", @"女神-G姐姐", @"秋--🙋十三姨", @"秋--最白姐"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索热门主播" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
       // [searchViewController.navigationController pushViewController:[PYTempViewController alloc] animated:YES];
    }];
    // 3. 设置风格
        searchViewController.hotSearchStyle = 4; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default

    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];}
-(void)didClickRightItem{
    RHRankViewController *rankVC = [[RHRankViewController alloc]initWithUrlStr:@"http://live.9158.com/Rank/WeekRank?Random=10"];
    rankVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rankVC animated:YES];
}

- (void)setupHeadView{
    NSArray *colorArray = @[
                            RGBCOLOR(200, 0, 102),
                            RGBCOLOR(185, 10, 102),
                            RGBCOLOR(185, 10, 102)
                            ];
    _headPageView = [[NinaPagerView alloc]initWithTitles:@[@"热门",@"签约",@"红人",@"关注",@"最新",@"同城",@"海外",@"官方"] WithVCs:@[@"RHHotViewController",@"RHSignStarViewController",@"RHHotStarViewController",@"RHCareViewController",@"RHListViewController",@"RHCityViewController",@"RHOverseasViewController",@"RHOfficalViewController"] WithColorArrays:colorArray];
    _headPageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headPageView];
    
}

-(void)setupTopTitleView{
    // 设置顶部选择视图
    RHTopSeletedView *selectedView = [[RHTopSeletedView alloc] initWithFrame:CGRectMake(0, 0, RHScreenWidth, 35)];

    [selectedView setSelectedBlock:^(HomeType type) {
        [self.scrollView setContentOffset:CGPointMake(type * RHScreenWidth, 0) animated:YES];
    }];
    [self.view addSubview:selectedView];
    _selectedView = selectedView;
}

-(void)setupSubviews{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0,35, RHScreenWidth, RHScreenHeight - 148)];
    view.contentSize = CGSizeMake(RHScreenWidth * 5, 0);
    view.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    // 设置分页
    view.pagingEnabled = YES;
    // 设置代理
    view.delegate = self;
    // 去掉弹簧效果
    view.bounces = NO;
    
    CGFloat height = RHScreenHeight - 49;
    
    // 添加子视图
    RHHotViewController *hot = [[RHHotViewController alloc] init];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.height = height;
    [self addChildViewController:hot];
    [view addSubview:hot.view];
    _hotVC = hot;
    
    RHSignStarViewController *signdVC = [[RHSignStarViewController alloc] init];
    signdVC.view.frame = [UIScreen mainScreen].bounds;
    signdVC.view.left = RHScreenWidth;
    signdVC.view.height = height;
    [self addChildViewController:signdVC];
    [view addSubview:signdVC.view];
    _signedVC = signdVC;
    
    RHListViewController *newStar = [[RHListViewController alloc] init];
    newStar.view.frame = [UIScreen mainScreen].bounds;
    newStar.view.left = RHScreenWidth * 2;
    newStar.view.height = height;
    [self addChildViewController:newStar];
    [view addSubview:newStar.view];
    _listVC = newStar;
    
    RHCareViewController *care = [[RHCareViewController alloc]init];
    care.view.frame = [UIScreen mainScreen].bounds;
    care.view.left = RHScreenWidth * 3;
    care.view.height = height;
    [self addChildViewController:care];
    [view addSubview:care.view];
    _careVC = care;
    
    RHHotStarViewController *hotStar = [[RHHotStarViewController alloc] init];
    hotStar.view.frame = [UIScreen mainScreen].bounds;
    hotStar.view.left = RHScreenWidth * 4;
    hotStar.view.height = height;
    [self addChildViewController:hotStar];
    [view addSubview:hotStar.view];
    _hotStarVC = hotStar;
    
    [self.view addSubview:view];
    _scrollView = view;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / RHScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x / RHScreenWidth * (self.selectedView.width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.selectedView.underLine.left = 15 + offsetX;
    if (page == 1 ) {
        self.selectedView.underLine.left = offsetX + 10;
    }else if (page > 1){
        self.selectedView.underLine.left = offsetX + 5;
    }
    self.selectedView.selectedType = (int)(page + 0.5);
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 5; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
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

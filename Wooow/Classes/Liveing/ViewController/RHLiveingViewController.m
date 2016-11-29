//
//  RHLiveingViewController.m
//  哇呜
//
//  Created by zero on 16/7/16.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHLiveingViewController.h"
#import "RHLiveFlowLayout.h"
#import "RHUserView.h"
#import "RHGifRefreshHeader.h"
#import "RHLiveCollectionViewCell.h"
@interface RHLiveingViewController ()
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
@property(nonatomic,strong) RHUserView *userView; //<

@end
static NSString * const reuseIdentifier = @"ALinLiveViewCell";

@implementation RHLiveingViewController

- (instancetype)init{
    return [super initWithCollectionViewLayout:[[RHLiveFlowLayout alloc]init]];
}

- (RHUserView *)userView{
    if (!_userView) {
        _userView = [[RHUserView alloc]init];
        [self.collectionView addSubview:_userView];

        _userView.transform = CGAffineTransformMakeScale(0.01, 0.01);

        [_userView setCloseBlock:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [self.userView removeFromSuperview];
                self.userView = nil;
            }];
        }];

    }
    return _userView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[RHLiveCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    MJRefreshGifHeader *header = [RHGifRefreshHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        self.currentIndex++;
        if (self.currentIndex == self.liveDatas.count) {
            self.currentIndex = 0;
        }
        [self.collectionView reloadData];
    }];
    header.stateLabel.hidden = NO;
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    self.collectionView.mj_header = header;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
    // Do any additional setup after loading the view.
}

- (void)clickUser:(NSNotification *)notify
{
    if (notify.userInfo[@"user"] != nil) {
        RHUserView *user = notify.userInfo[@"user"];
        self.userView.userModel = user;
        [UIView animateWithDuration:0.5 animations:^{
            self.userView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RHLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.parentVc = self;
    cell.liveModel = self.liveDatas[self.currentIndex];
    NSUInteger relateIndex = self.currentIndex;
    if (self.currentIndex + 1 == self.liveDatas.count) {
        relateIndex = 0;
    }else{
        relateIndex += 1;
    }
    cell.relateLive = self.liveDatas[relateIndex];
    [cell setClickRelatedLive:^{
        self.currentIndex += 1;
        [self.collectionView reloadData];
    }];
    return cell;
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

//
//  RHLiveAuthorView.m
//  Wooow
//
//  Created by zero on 2016/11/3.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHLiveAuthorView.h"
#import <UIImageView+WebCache.h>
#import "RHLiveUserModel.h"
#import "CBAutoScrollLabel.h"
@interface RHLiveAuthorView()
@property(nonatomic,strong) UIImageView *authorImageView; //<
@property(nonatomic,strong) CBAutoScrollLabel *authorNameLab; //<
@property(nonatomic,strong) CBAutoScrollLabel *visitNubLab; //<
@property(nonatomic,strong) UIButton *favBtn; //<
@property(nonatomic,strong) UIScrollView *otherLiverView; //<
@property (strong, nonatomic) NSArray *chaoYangUsers;


@end

@implementation RHLiveAuthorView

- (NSArray *)chaoYangUsers{
    if (!_chaoYangUsers) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user.plist" ofType:nil]];
        _chaoYangUsers = [RHLiveUserModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _chaoYangUsers;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupUsersScrollview];

    }
    return self;
}

-(void)setLiveModel:(RHHotLiveModel *)liveModel{
    self.authorNameLab.text = liveModel.myname;
    self.visitNubLab.text = [NSString stringWithFormat:@"%ld人",liveModel.allnum];

    [self.authorImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.smallpic] placeholderImage:[UIImage imageNamed:@"toolbar_live"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
        self.authorImageView.image = image;
    }];

}

- (void)setupUsersScrollview{
    CGFloat width = 35;

    self.otherLiverView.contentSize = CGSizeMake((width + DefaultMargin) * self.chaoYangUsers.count + DefaultMargin, 0);
    CGFloat x = 0;
    for (int i = 0; i<self.chaoYangUsers.count; i++) {
        x = 0 + (DefaultMargin + width) * i;
        UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 5, width, width)];
        userView.backgroundColor = [UIColor redColor];
        userView.layer.cornerRadius = width * 0.5;
        userView.layer.masksToBounds = YES;
        RHLiveUserModel *user = self.chaoYangUsers[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                userView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
            });
        }];
        // 设置监听
        userView.userInteractionEnabled = YES;
        [userView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChangYang:)]];
        userView.tag = i;
        [self.otherLiverView addSubview:userView];
    }

}

- (void)setupSubViews{
    UIView *infoContentView = [[UIView alloc]init];
    infoContentView.backgroundColor = [UIColor grayColor];
    infoContentView.layer.cornerRadius = 20;
    infoContentView.clipsToBounds = YES;
    
    
    self.authorImageView = [[UIImageView alloc]init];
    self.authorImageView.userInteractionEnabled = YES;
    
    self.favBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.favBtn.backgroundColor = [UIColor orangeColor];
    [self.favBtn setTintColor:[UIColor whiteColor]];
    [self.favBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.favBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.favBtn addTarget:self action:@selector(didClickFavAction:) forControlEvents:UIControlEventTouchUpInside];
    self.favBtn.layer.cornerRadius = 12.0f;
    self.favBtn.clipsToBounds = YES;
    
    
    
    self.authorNameLab = [[CBAutoScrollLabel alloc]init];
    self.authorNameLab.font = [UIFont systemFontOfSize:12];
    self.authorNameLab.textColor = [UIColor colorWithRed:0.986 green:0.000 blue:0.219 alpha:1.000];
    self.authorNameLab.labelSpacing = 30;
    self.authorNameLab.pauseInterval = 1.7;
    self.authorNameLab.scrollSpeed = 30;
    self.authorNameLab.textAlignment = NSTextAlignmentCenter;
    self.authorNameLab.fadeLength = 12.f;
    self.authorNameLab.scrollDirection = CBAutoScrollDirectionLeft;
    [self.authorNameLab observeApplicationNotifications];

    
    self.visitNubLab = [[CBAutoScrollLabel alloc]init];
    self.visitNubLab.textColor = [UIColor colorWithRed:0.181 green:0.105 blue:0.507 alpha:1.000];
    self.visitNubLab.font = [UIFont systemFontOfSize:12];
    self.visitNubLab.labelSpacing = 30;
    self.visitNubLab.pauseInterval = 1.7;
    self.visitNubLab.scrollSpeed = 30;
    self.visitNubLab.textAlignment = NSTextAlignmentCenter;
    self.visitNubLab.fadeLength = 12.f;
    self.visitNubLab.scrollDirection = CBAutoScrollDirectionLeft;
    [self.visitNubLab observeApplicationNotifications];

    
    self.otherLiverView = [[UIScrollView alloc]init];
    self.otherLiverView.scrollEnabled = YES;
    self.otherLiverView.showsHorizontalScrollIndicator = NO;
    
    
    [infoContentView addSubview:self.authorImageView];
    [infoContentView addSubview:self.favBtn];
    [infoContentView addSubview:self.authorNameLab];
    [infoContentView addSubview:self.visitNubLab];
    [self addSubview:self.otherLiverView];
    [self addSubview:infoContentView];
    
    
    [infoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@26);
        make.left.mas_equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(RHScreenWidth * 0.53f, 40));
    }];
    
    [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoContentView.mas_top).offset(2.5f);
        make.left.mas_equalTo(infoContentView.mas_left).offset(2.55);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        
    }];
    
    [self.favBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoContentView.mas_top).offset(7.5f);
        make.right.mas_equalTo(infoContentView.mas_right).offset(-5.0f);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    
    [self.authorNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoContentView.mas_top).offset(2.5f);
        make.left.mas_equalTo(self.authorImageView.mas_right).offset(2.5f);
        make.right.mas_equalTo(self.favBtn.mas_left).offset(-2);
        make.height.mas_equalTo(@16);
        
    }];
    
    [self.visitNubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authorNameLab.mas_bottom).offset(2.0f);
        make.left.mas_equalTo(self.authorImageView.mas_right).offset(2.5f);
        make.right.mas_equalTo(self.favBtn.mas_left).offset(-2);
        make.height.mas_equalTo(@16);
        
    }];
    
    
    
    [self.otherLiverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(RHScreenWidth * 0.4f, 40));
        
    }];}

- (void)clickChangYang:(UITapGestureRecognizer *)tapGes
{
    if (tapGes.view == self.authorImageView) {
        RHLiveUserModel *user = [[RHLiveUserModel alloc] init];
        user.nickname = self.liveModel.myname;
        user.photo = self.liveModel.bigpic;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : user}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.chaoYangUsers[tapGes.view.tag]}];
    }
    
}

- (void)didClickFavAction:(UIButton *)btn{
    btn.selected = !btn.selected;

    if (self.clickFavAction) {
        self.clickFavAction(btn.selected);
    }
}


@end

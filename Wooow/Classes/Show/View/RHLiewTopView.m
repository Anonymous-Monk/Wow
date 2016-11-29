//
//  RHLiewTopView.m
//  Wooow
//
//  Created by zero on 2016/11/20.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHLiewTopView.h"
#import "RHLiveUserModel.h"
#import "RHHotLiveModel.h"
#import <UIImageView+WebCache.h>
@interface RHLiewTopView ()
@property(nonatomic,strong) UIImageView *authorImageView; //<
@property(nonatomic,strong) UILabel *authorNameLab; //<
@property(nonatomic,strong) UILabel *visitNubLab; //<

@property(nonatomic,strong) UIScrollView *otherLiverView; //<
@property (strong, nonatomic) NSArray *chaoYangUsers;
@end

@implementation RHLiewTopView

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
    self.authorNameLab.text = @"直播中";
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

    self.authorNameLab = [[UILabel alloc]init];
    
    self.authorNameLab.font = [UIFont systemFontOfSize:12];
    self.authorNameLab.textColor = [UIColor colorWithRed:0.986 green:0.000 blue:0.219 alpha:1.000];
    
    self.visitNubLab = [[UILabel alloc]init];
    self.visitNubLab.textColor = [UIColor colorWithRed:0.181 green:0.105 blue:0.507 alpha:1.000];
    self.visitNubLab.font = [UIFont systemFontOfSize:12];

    self.otherLiverView = [[UIScrollView alloc]init];
    self.otherLiverView.scrollEnabled = YES;
    self.otherLiverView.showsHorizontalScrollIndicator = NO;
    
    self.authorNameLab.text = @"直播中";
    self.visitNubLab.text = @"233人";
    
    UIImage *headImage = [UIImage imageNamed:@"playBtnBack@2x"];
    self.authorImageView.image = [UIImage circleImage:headImage borderColor:[UIColor whiteColor] borderWidth:1.0f ];
    [infoContentView addSubview:self.authorImageView];
    [infoContentView addSubview:self.authorNameLab];
    [infoContentView addSubview:self.visitNubLab];
    [self addSubview:self.otherLiverView];
    [self addSubview:infoContentView];

    
    [infoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@26);
        make.left.mas_equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(RHScreenWidth * 0.3f, 40));
    }];
    
    [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoContentView.mas_top).offset(2.5f);
        make.left.mas_equalTo(infoContentView.mas_left).offset(2.55);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        
    }];
    
    [self.authorNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoContentView.mas_top).offset(2.5f);
        make.left.mas_equalTo(self.authorImageView.mas_right).offset(2.5f);
        make.size.mas_equalTo(CGSizeMake(RHScreenWidth * 0.3f - 40, 16));
        
    }];
    
    [self.visitNubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authorNameLab.mas_bottom).offset(2.0f);
        make.left.mas_equalTo(self.authorImageView.mas_right).offset(2.5f);
        make.size.mas_equalTo(CGSizeMake(RHScreenWidth * 0.3f - 40, 16));
        
    }];
    
    
    
    [self.otherLiverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(RHScreenWidth * 0.6f, 40));
        
    }];
}

- (void)clickChangYang:(UITapGestureRecognizer *)tapGes
{
    if (tapGes.view == self.authorImageView) {
        RHLiveUserModel *user = [[RHLiveUserModel alloc] init];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : user}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.chaoYangUsers[tapGes.view.tag]}];
    }
    
}


@end

//
//  RHHotLiveCell.m
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHHotLiveCell.h"
#import <UIImageView+WebCache.h>


@interface RHHotLiveCell ()
@property(nonatomic,strong) UIView *topContentView;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *titmeLab;
@property(nonatomic,strong) UIButton *moreBtn;
@property(nonatomic,strong) UIView *bottomView; //<
@property(nonatomic,strong) UIImageView *middleImageView; //<
@property(nonatomic,strong) UILabel *desLab; //<
@property(nonatomic,strong) UIButton *actionBtn; //<
@end

@implementation RHHotLiveCell


-(void)setHotLiveModel:(RHHotLiveModel *)hotLiveModel{
    if (_hotLiveModel != hotLiveModel) {
        _hotLiveModel = nil;
        _hotLiveModel = hotLiveModel;
        [self layOutModel];
    }
}

-(void)layOutModel{
    _topContentView = [[UIView alloc]init];
    _headImageView = [[UIImageView alloc]init];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_hotLiveModel.smallpic] placeholderImage:[UIImage imageNamed:@"toolbar_live"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage circleImage:image borderColor:[UIColor blackColor] borderWidth:1];
        self.headImageView.image = image;
    }];
    _nameLab = [[UILabel alloc]init];
    _nameLab.text = _hotLiveModel.myname;
    _nameLab.font = [UIFont systemFontOfSize:13];
    _nameLab.textColor = RGBCOLOR(200, 0, 102);
    _titmeLab = [[UILabel alloc]init];
    _titmeLab.text = _hotLiveModel.userId;
    _titmeLab.font = [UIFont systemFontOfSize:12];
    _titmeLab.textColor = RGBCOLOR(42, 37, 9);
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19_",_hotLiveModel.starlevel]] forState:UIControlStateNormal];
    [_topContentView addSubview:_headImageView];
    [_topContentView addSubview:_nameLab];
    [_topContentView addSubview:_titmeLab];
    [_topContentView addSubview:_moreBtn];
    [self addSubview:_topContentView];
    
    [_topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(60);
    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_topContentView);
        make.left.mas_equalTo(17);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.mas_centerY).offset(-10);
        make.left.mas_equalTo(_headImageView.mas_right).offset(5);
        make.height.mas_equalTo(20);
    }];
    [_titmeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.mas_centerY).offset(10);
        make.left.mas_equalTo(_headImageView.mas_right).offset(5);
        make.height.mas_equalTo(20);
    }];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_topContentView);
        make.right.mas_equalTo(_topContentView.mas_right).offset(-17);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    _bottomView = [[UIView alloc]init];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(40);
    }];
    for (int i = 0; i < 3; i++) {
        UIView *bottomContentView = [[UIView alloc]init];
        bottomContentView.frame = CGRectMake(i * RHScreenWidth / 3, 0, RHScreenWidth / 3, 40);
        UIView *btnView = [[UIView alloc]init];
        //btnView.backgroundColor = [UIColor whiteColor];
        btnView.size = CGSizeMake(bottomContentView.width *3/4, bottomContentView.height * 2 /3);
        btnView.centerY = bottomContentView.centerY;
        btnView.left = bottomContentView.width * 1 /8;
        btnView.tag = 1000 + i;

        [bottomContentView addSubview:btnView];
        self.desLab = [[UILabel alloc]init];
        self.desLab.textColor = [UIColor grayColor];
        self.desLab.font = [UIFont systemFontOfSize:14];
        self.desLab.textAlignment = NSTextAlignmentCenter;
        self.actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnView addSubview:self.desLab];
        [btnView addSubview:self.actionBtn];
        [self setbtnView:btnView];
        [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(btnView);
            make.width.mas_equalTo(btnView.height);
        }];
        [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(btnView);
            make.left.mas_equalTo(self.actionBtn.mas_right);
        }];
        [_bottomView addSubview:bottomContentView];
    }

    _middleImageView = [[UIImageView alloc]init];
    _middleImageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
    [_middleImageView sd_setImageWithURL:[NSURL URLWithString:_hotLiveModel.bigpic] placeholderImage:[UIImage imageNamed:@"cellBack"]];
    [self addSubview:_middleImageView];
    
    [_middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_topContentView.mas_bottom);
        make.bottom.mas_equalTo(_bottomView.mas_top);
        make.height.mas_equalTo(RHScreenWidth);
    }];
    
//    [_middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.mas_equalTo(middleView);
//        make.width.mas_equalTo(RHScreenWidth * 3 / 5);
//    }];
//    
//    UIView *rightView = [[UIView alloc]init];
//   // rightView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rightBack"]];
//    [middleView addSubview:rightView];
//    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.bottom.mas_equalTo(middleView);
//        make.left.mas_equalTo(_middleImageView.mas_right);
//    }];
//    
//    UIImageView *palyImageView = [[UIImageView alloc]init];
//    palyImageView.image = [UIImage circleImage:[UIImage imageNamed:@"playBtnBack"] borderColor:[UIColor purpleColor] borderWidth:2.0f];
//    [rightView addSubview:palyImageView];
//    [palyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(rightView.center);
//        make.size.mas_equalTo(RHScreenWidth * 1 / 5);
//    }];
//    
//    UILabel *tipsLab = [[UILabel alloc]init];
//    tipsLab.center = palyImageView.center;
//    tipsLab.textAlignment = NSTextAlignmentCenter;
//    tipsLab.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
//    tipsLab.font = [UIFont boldSystemFontOfSize:18];
//    tipsLab.text = @"热播中";
//    tipsLab.size = CGSizeMake(RHScreenWidth * 1 / 5 - 5, RHScreenWidth * 1 / 5 - 5);
//    [palyImageView addSubview:tipsLab];
//    
//    UIImageView *levelImageView = [[UIImageView alloc]init];
//    levelImageView.image = [UIImage imageNamed:@"等级"];
//    
//    [rightView addSubview:levelImageView];
//    [levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(rightView.mas_top).offset(10);
//        make.left.mas_equalTo(rightView.mas_left).offset(10);
//        make.size.mas_equalTo(RHScreenWidth * 1 / 13);
//    }];
//    UILabel *levelLab = [[UILabel alloc]init];
//    levelLab.text = [NSString stringWithFormat:@"等级:%ld",_hotLiveModel.starlevel];
//    levelLab.textColor = [UIColor magentaColor];
//    [rightView addSubview:levelLab];
//    [levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(rightView.mas_top).offset(10);
//        make.left.mas_equalTo(levelImageView.mas_right).offset(5);
//        make.height.mas_equalTo(RHScreenWidth * 1 / 14);
//    }];
}

-(void)setbtnView:(UIView *)view{
    switch (view.tag) {
        case 1000:
            self.desLab.text = _hotLiveModel.gps;
            [self.actionBtn setImage:[UIImage imageNamed:@"位置"] forState:UIControlStateNormal];
            break;
        case 1001:
            self.desLab.text = [NSString stringWithFormat:@"%ld",_hotLiveModel.allnum];
            [self.actionBtn setImage:[UIImage imageNamed:@"查看"] forState:UIControlStateNormal];
            break;
        case 1002:
            self.desLab.text = [NSString stringWithFormat:@"%ld",_hotLiveModel.pos];
            [self.actionBtn setImage:[UIImage imageNamed:@"排名"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

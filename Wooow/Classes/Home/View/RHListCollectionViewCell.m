//
//  RHListCollectionViewCell.m
//  哇呜
//
//  Created by zero on 16/8/6.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHListCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface RHListCollectionViewCell ()
@property(nonatomic,strong) UIImageView *userImageView; //<<#description#>
@property(nonatomic,strong) UILabel *nameLab; //<<#description#>
@property(nonatomic,strong) UILabel *addressLab; //<<#description#>
@end


@implementation RHListCollectionViewCell

-(void)setLiveUser:(RHLiveUserModel *)liveUser{
    if (_liveUser != liveUser) {
        _liveUser = nil;
        _liveUser = liveUser;
    }
    [self layoutModel];
}

-(void)layoutModel{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _userImageView = [[UIImageView alloc]init];
    _userImageView.backgroundColor = [UIColor clearColor];
    _userImageView.layer.cornerRadius = 12;
    _userImageView.clipsToBounds = YES;
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_liveUser.photo] placeholderImage:[UIImage imageNamed:@"toolbar_live"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _userImageView.image = image;
    }];
    [self.contentView addSubview:_userImageView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"位置"];
    [self.contentView addSubview:imageView];
    
    _addressLab = [[UILabel alloc]init];
    _addressLab.font = [UIFont systemFontOfSize:14];
    _addressLab.textAlignment = NSTextAlignmentLeft;
    _addressLab.text = _liveUser.position;
    _addressLab.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_addressLab];
    
    _nameLab = [[UILabel alloc]init];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.font = [UIFont systemFontOfSize:16];
    _nameLab.text = _liveUser.nickname;
    _nameLab.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
    [self.contentView addSubview:_nameLab];
    
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.contentView);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userImageView.mas_left).offset(12);
        make.top.mas_equalTo(_userImageView.mas_top).offset(12);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(2);
        make.top.mas_equalTo(_userImageView.mas_top).offset(12);
        make.height.mas_equalTo(20);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(_userImageView);
        make.height.mas_equalTo(40);
    }];
}


@end

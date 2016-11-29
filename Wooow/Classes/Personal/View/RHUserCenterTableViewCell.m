//
//  RHUserCenterTableViewCell.m
//  哇呜
//
//  Created by zero on 16/8/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHUserCenterTableViewCell.h"
#import "RHUserCenterItemModel.h"
#import "UIView+ITTAdditions.h"

#define XBMakeColorWithRGB(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//获取屏幕尺寸
#define XBScreenWidth      [UIScreen mainScreen].bounds.size.width
#define XBScreenHeight     [UIScreen mainScreen].bounds.size.height
#define XBScreenBounds     [UIScreen mainScreen].bounds


//功能图片到左边界的距离
#define XBFuncImgToLeftGap 15

//功能名称字体
#define XBFuncLabelFont 14

//功能名称到功能图片的距离,当功能图片funcImg不存在时,等于到左边界的距离
#define XBFuncLabelToFuncImgGap 15

//指示箭头或开关到右边界的距离
#define XBIndicatorToRightGap 15

//详情文字字体
#define XBDetailLabelFont 12

//详情到指示箭头或开关的距离
#define XBDetailViewToIndicatorGap 13

@interface RHUserCenterTableViewCell()
@property (strong, nonatomic) UILabel *funcNameLabel;
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIImageView *indicator;

@property (nonatomic,strong) UISwitch *aswitch;

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UIImageView *detailImageView;



@end

@implementation RHUserCenterTableViewCell

- (void)setItem:(RHUserCenterItemModel *)item
{
    _item = item;
    [self updateUI];
    
}

- (void)updateUI
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //如果有图片
    if (self.item.img) {
        [self setupImgView];
    }
    //功能名称
    if (self.item.funcName) {
        [self setupFuncLabel];
    }
    
    //accessoryType
    if (self.item.accessoryType) {
        [self setupAccessoryType];
    }
    //detailView
    if (self.item.detailText) {
        [self setupDetailText];
    }
    if (self.item.detailImage) {
        [self setupDetailImage];
    }
    
    //bottomLine
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, XBScreenWidth, 1)];
    line.backgroundColor = XBMakeColorWithRGB(234, 234, 234, 1);
    [self.contentView addSubview:line];
    
}

-(void)setupDetailImage
{
    self.detailImageView = [[UIImageView alloc]initWithImage:self.item.detailImage];
    self.detailImageView.centerY = self.contentView.centerY;
    switch (self.item.accessoryType) {
        case HooUserCenterAccessoryTypeNone:
            self.detailImageView.left = XBScreenWidth - self.detailImageView.width - XBDetailViewToIndicatorGap - 2;
            break;
        case HooUserCenterAccessoryTypeDisclosureIndicator:
            self.detailImageView.left = self.indicator.left - self.detailImageView.width - XBDetailViewToIndicatorGap;
            break;
        case HooUserCenterAccessoryTypeSwitch:
            self.detailImageView.left = self.aswitch.left - self.detailImageView.width - XBDetailViewToIndicatorGap;
            break;
        default:
            break;
    }
    [self.contentView addSubview:self.detailImageView];
}

- (void)setupDetailText
{
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.text = self.item.detailText;
    self.detailLabel.textColor = XBMakeColorWithRGB(142, 142, 142, 1);
    self.detailLabel.font = [UIFont systemFontOfSize:XBDetailLabelFont];
    self.detailLabel.size = [self sizeForTitle:self.item.detailText withFont:self.detailLabel.font];
    self.detailLabel.centerY = self.contentView.centerY;
    
    switch (self.item.accessoryType) {
        case HooUserCenterAccessoryTypeNone:
            self.detailLabel.left = XBScreenWidth - self.detailLabel.width - XBDetailViewToIndicatorGap - 2;
            break;
        case HooUserCenterAccessoryTypeDisclosureIndicator:
            self.detailLabel.left = self.indicator.left - self.detailLabel.width - XBDetailViewToIndicatorGap;
            break;
        case HooUserCenterAccessoryTypeSwitch:
            self.detailLabel.left = self.aswitch.left - self.detailLabel.width - XBDetailViewToIndicatorGap;
            break;
        default:
            break;
    }
    
    [self.contentView addSubview:self.detailLabel];
}


- (void)setupAccessoryType
{
    switch (self.item.accessoryType) {
        case HooUserCenterAccessoryTypeNone:
            break;
        case HooUserCenterAccessoryTypeDisclosureIndicator:
            [self setupIndicator];
            break;
        case HooUserCenterAccessoryTypeSwitch:
            [self setupSwitch];
            break;
        default:
            break;
    }
}

- (void)setupSwitch
{
    [self.contentView addSubview:self.aswitch];
}

- (void)setupIndicator
{
    [self.contentView addSubview:self.indicator];
    
}

- (void)setupImgView
{
    self.imgView = [[UIImageView alloc]initWithImage:self.item.img];
    self.imgView.left = XBFuncImgToLeftGap;
    self.imgView.centerY = self.contentView.centerY;
    [self.contentView addSubview:self.imgView];
}

- (void)setupFuncLabel
{
    self.funcNameLabel = [[UILabel alloc]init];
    self.funcNameLabel.text = self.item.funcName;
    self.funcNameLabel.textColor = XBMakeColorWithRGB(51, 51, 51, 1);
    self.funcNameLabel.font = [UIFont systemFontOfSize:XBFuncLabelFont];
    self.funcNameLabel.size = [self sizeForTitle:self.item.funcName withFont:self.funcNameLabel.font];
    self.funcNameLabel.centerY = self.contentView.centerY;
    self.funcNameLabel.left = CGRectGetMaxX(self.imgView.frame) + XBFuncLabelToFuncImgGap;
    [self.contentView addSubview:self.funcNameLabel];
}

- (CGSize)sizeForTitle:(NSString *)title withFont:(UIFont *)font
{
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil];
    
    return CGSizeMake(titleRect.size.width,
                      titleRect.size.height);
}

- (UIImageView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-arrow1"]];
        _indicator.centerY = self.contentView.centerY;
        _indicator.left = XBScreenWidth - _indicator.width - XBIndicatorToRightGap;
    }
    return _indicator;
}

- (UISwitch *)aswitch
{
    if (!_aswitch) {
        _aswitch = [[UISwitch alloc]init];
        _aswitch.centerY = self.contentView.centerY;
        _aswitch.left = XBScreenWidth - _aswitch.width - XBIndicatorToRightGap;
        [_aswitch addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
    }
    return _aswitch;
}

- (void)switchTouched:(UISwitch *)sw
{
    __weak typeof(self) weakSelf = self;
    self.item.switchValueChanged(weakSelf.aswitch.isOn);
}

@end

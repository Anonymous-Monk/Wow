//
//  RHTopSeletedView.m
//  哇呜
//
//  Created by zero on 16/7/14.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHTopSeletedView.h"
#import "UIImage+RHExtension.h"
@interface RHTopSeletedView ()
@property (nonatomic, weak)UIView *underLine;
@property (nonatomic, strong)UIButton *selectedBtn;
@property (nonatomic, weak)UIButton *hotBtn;
@end


@implementation RHTopSeletedView

- (UIView *)underLine
{
    if (!_underLine) {
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.height-4, Home_Seleted_Item_W + DefaultMargin, 2)];
        underLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
    }
    return self;
}

- (void)setup
{
    UIButton *hotBtn = [self createBtn:@"直播" tag:HomeTypeHot];
    UIButton *signBtn = [self createBtn:@"签约" tag:HomeTypeSignd];
    UIButton *newBtn = [self createBtn:@"艺人" tag:HomeTypeNew];
    UIButton *careBtn = [self createBtn:@"关注" tag:HomeTypeCare];
    UIButton *hotStrBtn = [self createBtn:@"红人" tag:HomeTypeHotStar];
    
    
    [self addSubview:newBtn];
    [self addSubview:signBtn];
    [self addSubview:hotBtn];
    [self addSubview:careBtn];
    [self addSubview:hotStrBtn];
    _hotBtn = hotBtn;
    
    
    
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(newBtn.mas_left).offset(-DefaultMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(signBtn.mas_left).offset(-DefaultMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    
    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newBtn.mas_right).offset(DefaultMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    
    [hotStrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(careBtn.mas_right).offset(DefaultMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    
    
    // 强制更新一次
    [self layoutIfNeeded];
    // 默认选中最热
    [self click:hotBtn];
    // 监听点击"去看最热主播"
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSeeWorld) name:kNotifyToseeBigWorld object:nil];
}

- (void)toSeeWorld
{
    [self click:_hotBtn];
}

- (UIButton *)createBtn:(NSString *)title tag:(HomeType)tag
{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[RGBCOLOR(185, 10, 102) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(200, 0, 102) forState:UIControlStateSelected];
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setSelectedType:(HomeType)selectedType
{
    _selectedType = selectedType;
    self.selectedBtn.selected = NO;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == selectedType) {
            self.selectedBtn = (UIButton *)view;
            ((UIButton *)view).selected = YES;
        }
    }
    
}

// 点击事件
- (void)click:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.underLine.left = btn.left - DefaultMargin * 0.5;
    }];
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag);
    }
}

@end

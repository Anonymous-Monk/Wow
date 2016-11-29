//
//  RHUserView.m
//  Wooow
//
//  Created by zero on 2016/11/19.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHUserView.h"

@interface RHUserView ()
@property(nonatomic,strong) UIButton *closeBtn; //<关闭按钮
@end

@implementation RHUserView


- (instancetype)init{
    if (self = [super init]) {
        self.size = CGSizeMake(RHScreenWidth * 0.9f, RHScreenHeight * 0.55f);
        self.backgroundColor = [UIColor redColor];
        self.centerX = RHScreenWidth / 2;
        self.centerY = RHScreenHeight / 2;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeBtn setImage:[UIImage imageNamed:@"talk_close_40x40"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(didClickCloseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(@-5);
        make.top.mas_equalTo(@5);

    }];
}

- (void)setUserModel:(RHLiveUserModel *)userModel{
    
}

- (void)didClickCloseBtnAction:(UIButton *)btn{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

@end

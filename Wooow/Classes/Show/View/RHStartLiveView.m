//
//  RHStartLiveView.m
//  Wooow
//
//  Created by zero on 2016/11/19.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHStartLiveView.h"
#import "UITextField+RHExtension.h"
@interface RHStartLiveView ()
@property(nonatomic,strong) UIButton *closeBtn; //<关闭按钮
@property(nonatomic,strong) UIButton *startLiveBtn; //<开启直播
@property(nonatomic,strong) UIImageView *backImageView; //<背景占位图
@property(nonatomic,strong) UIButton *addPicBtn; //<添加图片
@property(nonatomic,strong) UITextField *titleTextField; //<直播标题
@property(nonatomic,strong) UIButton *transCarmaBtn; //<摄像头转换

@end

@implementation RHStartLiveView

- (instancetype)init{
    if (self = [super init]) {
        [self setupSubViews];
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

- (void)setupSubViews{
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeBtn setImage:[UIImage imageNamed:@"talk_close_40x40"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(didClickPareType:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn setTintColor:[UIColor whiteColor]];
    self.closeBtn.tag = 1000;
    [self addSubview:self.closeBtn];
    
    self.transCarmaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.transCarmaBtn setImage:[UIImage imageNamed:@"camera_change_40x40"] forState:UIControlStateNormal];
    [self.transCarmaBtn addTarget:self action:@selector(didClickPareType:) forControlEvents:UIControlEventTouchUpInside];
    [self.transCarmaBtn setTintColor:[UIColor whiteColor]];
    self.transCarmaBtn.tag = 1001;
    [self addSubview:self.transCarmaBtn];
    
    self.backImageView = [[UIImageView alloc]init];
    self.backImageView.backgroundColor = [UIColor lightGrayColor];
    self.backImageView.userInteractionEnabled = YES;
    self.backImageView.alpha = 0.3;
    [self addSubview:self.backImageView];
    
    self.addPicBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.addPicBtn setImage:[UIImage imageNamed:@"创建小组_加号"] forState:UIControlStateNormal];
    [self.addPicBtn addTarget:self action:@selector(didClickPareType:) forControlEvents:UIControlEventTouchUpInside];
    [self.addPicBtn setTintColor:[UIColor whiteColor]];
    self.addPicBtn.tag = 1002;
    [self.backImageView addSubview:self.addPicBtn];
    
    self.titleTextField = [[UITextField alloc]init];
    self.titleTextField.placeholder = @"输入直播主题可吸引更多观众";
    [self.titleTextField setRh_placeholderColor:[UIColor whiteColor]];
    self.titleTextField.borderStyle = UITextBorderStyleNone;
    self.titleTextField.textColor = [UIColor whiteColor];
    [self addSubview:self.titleTextField];
    
    self.startLiveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startLiveBtn.backgroundColor = [UIColor orangeColor];
    [self.startLiveBtn setTitle:@"开启直播" forState:UIControlStateNormal];
    [self.startLiveBtn addTarget:self action:@selector(didClickPareType:) forControlEvents:UIControlEventTouchUpInside];
    self.startLiveBtn.tag = 1003;
    [self.startLiveBtn setTintColor:[UIColor whiteColor]];
    [self addSubview:self.startLiveBtn];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.transCarmaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.right.mas_equalTo(self.closeBtn.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.transCarmaBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(@40);
        make.right.mas_equalTo(@-40);
        make.height.mas_equalTo(RHScreenHeight * 0.4);
    }];
    
    [self.addPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.center.mas_equalTo(self.backImageView.center);
    }];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backImageView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.backImageView);
        make.size.mas_equalTo(CGSizeMake(230, 50));
    }];
    
    [self.startLiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTextField.mas_bottom).offset(30);
        make.right.mas_equalTo(@-10);
        make.left.mas_equalTo(@10);
        make.height.mas_equalTo(@50);
    }];
    
}

- (void)didClickPareType:(UIButton *)btn{
    if (self.clickPareType) {
        self.clickPareType(btn.tag - 1000);
    }
}


@end

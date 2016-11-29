//
//  RHHeaderView.m
//  哇呜
//
//  Created by zero on 16/8/7.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHHeaderView.h"
#import "CBAutoScrollLabel.h"
@implementation RHHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
       [self setSubViewWithFrame:frame];
    }
    return self;
}


-(void)setSubViewWithFrame:(CGRect)frame{
    self.backgroundColor = RGBCOLOR(200, 0, 102);

    UIView *headTopView = [[UIView alloc]init];
    headTopView.backgroundColor = [UIColor clearColor];
    [self addSubview:headTopView];
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor =[ UIColor whiteColor];
    [self addSubview:topLine];
    
    UIView *headBottomView = [[UIView alloc]init];
    [self addSubview:headBottomView];


    [headBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(frame.size.width);
        make.height.mas_equalTo(frame.size.height * 0.27f);
        make.bottom.mas_equalTo(@0);
    }];
    [headTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(headBottomView.mas_top);
    }];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(headTopView);
        make.height.mas_equalTo(0.6f);
        make.bottom.mas_equalTo(headTopView.mas_bottom);
    }];
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.image = [UIImage circleImage:[UIImage imageNamed:@"playBtnBack"] borderColor:[UIColor colorWithRed:0.231 green:0.418 blue:0.582 alpha:1.000] borderWidth:3.0f];
    headImageView.backgroundColor = [UIColor clearColor];
    [headTopView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headTopView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.mas_equalTo(headTopView.mas_left).offset(16);
    }];

    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text = [AVUser currentUser].username;
    nameLab.textColor = [UIColor whiteColor];
    [headTopView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@12);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(headImageView.mas_right).offset(10);
        make.right.mas_equalTo(headTopView.mas_right).offset(-20);
    }];
    UIView *progressView = [[UIView alloc]init];
    progressView.backgroundColor = [UIColor whiteColor];
    progressView.layer.cornerRadius = 5;
    progressView.layer.masksToBounds = YES;
    [headTopView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLab.mas_bottom).offset(6);
        make.leftMargin.mas_equalTo(nameLab);
        make.height.mas_equalTo(10);
        make.right.mas_equalTo(headTopView.mas_right).offset(-80);
    }];
    

    
    UILabel *editLab = [[UILabel alloc]init];
    editLab.text = @">";
    editLab.textColor = [UIColor whiteColor];
    editLab.font = [UIFont systemFontOfSize:30];
    [headTopView addSubview:editLab];
    [editLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headTopView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(headTopView.mas_right).offset(-20);
    }];
    
    UILabel *idLab = [[UILabel alloc]init];
    idLab.text = @"ID:233233233";
    idLab.textColor = [UIColor whiteColor];
    [headTopView addSubview:idLab];
    [idLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.mas_equalTo(nameLab);
        make.top.mas_equalTo(progressView.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(headTopView.mas_right).offset(-20);
    }];
    
    CBAutoScrollLabel *desLab = [[CBAutoScrollLabel alloc]init];
    desLab.text = @"这个家伙很懒，什么都没写！";
    desLab.textColor = [UIColor whiteColor];
    desLab.labelSpacing = 30;
    desLab.pauseInterval = 1.7;
    desLab.scrollSpeed = 30;
    desLab.textAlignment = NSTextAlignmentCenter;
    desLab.fadeLength = 12.f;
    desLab.scrollDirection = CBAutoScrollDirectionLeft;
    [desLab observeApplicationNotifications];
    [headTopView addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leftMargin.mas_equalTo(idLab);
        make.top.mas_equalTo(idLab.mas_bottom).offset(8);
        make.right.mas_equalTo(headTopView.mas_right).offset(-20);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor whiteColor];
    [headBottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(headBottomView);
        make.bottom.mas_equalTo(headBottomView.mas_bottom).offset(1);
        make.height.mas_equalTo(0.6f);
    }];
    
    for (int i = 0; i<3; i++) {
        UIView *richView = [[UIView alloc]init];
        richView.tag = i;
        UILabel *nubLab = [[UILabel alloc]init];
        UILabel *titleLab = [[UILabel alloc]init];
        nubLab.textColor = [UIColor whiteColor];
        nubLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:14];
        [richView addSubview:nubLab];
        [richView addSubview:titleLab];
        [headBottomView addSubview:richView];
        [nubLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(richView);
            make.top.mas_equalTo(richView.mas_top).offset(6);
            make.height.mas_equalTo(19.25f);
        }];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(richView);
            make.bottom.mas_equalTo(richView.mas_bottom).offset(-6);
            make.height.mas_equalTo(19.25f);
        }];
        if (i == 0) {
            nubLab.text = @"33";
            titleLab.text = @"关注";
            [richView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(frame.size.width*1/3);
                make.left.top.mas_equalTo(headBottomView);
                make.bottom.mas_equalTo(headBottomView.mas_bottom).offset(-1);
            }];
        }else if (i==2){
            nubLab.text = @"22";
            titleLab.text = @"直播时长";
            [richView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(frame.size.width*1/3);
                make.top.mas_equalTo(headBottomView);
                make.left.mas_equalTo(headBottomView).offset(frame.size.width*2/3);
                make.bottom.mas_equalTo(headBottomView.mas_bottom).offset(-1);
            }];
        }else{
            nubLab.text = @"233";
            titleLab.text = @"粉丝";
            UIView *leftLine = [[UIView alloc]init];
            leftLine.backgroundColor = [UIColor whiteColor];
            UIView *rightLine = [[UIView alloc]init];
            rightLine.backgroundColor = [UIColor whiteColor];
            [richView addSubview:leftLine];
            [richView addSubview:rightLine];
            [richView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(frame.size.width*1/3);
                make.top.mas_equalTo(headBottomView);
                make.left.mas_equalTo(headBottomView).offset(frame.size.width*1/3);
                make.bottom.mas_equalTo(headBottomView.mas_bottom).offset(-1);
            }];
            [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(richView.mas_top).offset(10);
                make.bottom.mas_equalTo(richView.mas_bottom).offset(-10);
                make.left.mas_equalTo(richView);
                make.width.mas_equalTo(0.6f);
            }];
            [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(richView.mas_top).offset(10);
                make.bottom.mas_equalTo(richView.mas_bottom).offset(-10);
                make.right.mas_equalTo(richView);
                make.width.mas_equalTo(0.6f);
            }];
        }
    }

}

-(UIView *)creatViewWithFrame:(CGRect)frame Title:(NSString *)title Number:(NSString *)nub showLine:(BOOL)show{
    UIView *richView = [[UIView alloc]init];
    UILabel *nubLab = [[UILabel alloc]init];
    UILabel *titleLab = [[UILabel alloc]init];
    nubLab.textColor = [UIColor whiteColor];
    nubLab.text = nub;
    nubLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:14];
    [richView addSubview:nubLab];
    [richView addSubview:titleLab];
    
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = [UIColor whiteColor];
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = [UIColor whiteColor];
    [richView addSubview:leftLine];
    [richView addSubview:rightLine];
    
    [nubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(richView);
        make.top.mas_equalTo(richView.mas_top).offset(6);
        make.height.mas_equalTo(19.25f);
    }];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(richView);
        make.bottom.mas_equalTo(richView.mas_bottom).offset(-6);
        make.height.mas_equalTo(19.25f);
    }];
    if (show) {
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(richView.mas_top).offset(10);
            make.bottom.mas_equalTo(richView.mas_bottom).offset(-10);
            make.left.mas_equalTo(richView);
            make.width.mas_equalTo(0.6f);
        }];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(richView.mas_top).offset(10);
            make.bottom.mas_equalTo(richView.mas_bottom).offset(-10);
            make.right.mas_equalTo(richView);
            make.width.mas_equalTo(0.6f);
        }];
    }
    
    return richView;
}




@end

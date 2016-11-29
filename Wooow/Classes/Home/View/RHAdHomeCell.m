//
//  RHAdHomeCell.m
//  哇呜
//
//  Created by zero on 16/7/15.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHAdHomeCell.h"

@interface RHAdHomeModel ()

@end

@implementation RHAdHomeCell

- (void)setTopADs:(NSArray *)topADs
{
    if (_topADs != topADs) {
        _topADs = nil;
        _topADs = topADs;
        NSMutableArray *imageUrls = [NSMutableArray array];
        for (RHAdHomeModel *topAD in topADs) {
            [imageUrls addObject:topAD.imageUrl];
        }

        XRCarouselView *view = [XRCarouselView carouselViewWithImageArray:imageUrls describeArray:nil];
        view.time = 2.0;
        view.delegate = self;
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.contentView);
        }];
    }

}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.topADs[index]);
    }
}

@end

//
//  RHLiveFlowLayout.m
//  Wooow
//
//  Created by zero on 2016/11/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHLiveFlowLayout.h"

@implementation RHLiveFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end

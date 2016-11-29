//
//  OrdrListModel.h
//  哇呜
//
//  Created by zero on 16/7/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ExtendOrder : NSObject
@property(nonatomic,strong) NSString *rec_id; //<<#description#>
/*
 .
 .
 .
 .
 .
 .
 */
@property(nonatomic,strong) NSString *goods_image_url; //<<#description#>
@end

@interface OrdrListModel : NSObject
@property(nonatomic,strong) NSString *order_id; //<<#description#>
@property(nonatomic,strong) NSString *order_sn; //<<#description#>
/*
 .
 .
 .
 .
 */
@property(nonatomic,strong) ExtendOrder *extend_order; //<<#description#>
@property(nonatomic,strong) NSString *is_pay; //<<#description#>
/*
 .
 .
 .
 */
@property(nonatomic,strong) NSString *is_deliver; //<<#description#>
@end


@interface orderGroupModel : NSObject
@property(nonatomic,strong) OrdrListModel *listModel; //<<#description#>
/*
 .
 .
 .
 */
@property(nonatomic,strong) NSString *pay_sn; //<<#description#>
@end



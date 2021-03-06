//
//  GoodsInfoController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ViewController.h"
#import "GoodsListModel.h"
/*** 共用一个福利详情页
 */
typedef enum{
    GoodsType_BirthDay, // 生日福利
    GoodsType_Holiday,  // 节日福利
    GoodsType_Discount,  // 优惠购物
    GoodsType_None  // 其他情况进入
}  GoodsInfoType;

@interface GoodsInfoController : ViewController

@property (nonatomic, assign) GoodsInfoType goodsInfoType;
@property (nonatomic, strong) NSString      *productID;
@property (nonatomic, strong) GoodsListModel *goodsListModel;

@end

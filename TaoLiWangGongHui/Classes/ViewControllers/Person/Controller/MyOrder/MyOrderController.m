//
//  MyOrdelController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//


#define MyOrderExampleCount 3
#define FirstHeadViewHeight 60

#import "MyOrderController.h"
#import "WelfareOrderViewController.h"
#import "OrderDetailViewController.h"
#import "MyOrderDetailViewController.h"
#import "OrderCell.h"

@interface MyOrderController (){
    BOOL isShowWelfareHidden;
}

@end

@implementation MyOrderController

- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isShowWelfareHidden = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return MyOrderExampleCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return isShowWelfareHidden ?90 : 73;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    if(section == 0){
        height = FirstHeadViewHeight;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = nil;
    if (section == 0) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, FirstHeadViewHeight)];
        UIButton *welfareOrders = [UIButton createButton:@selector(orderClicked:) title:@"福利订单" image:nil selectedBgImage:@"goods_gift_selected.png" backGroundImage:@"goods_gift_normal.png" backGroundTapeImage:nil frame:CGRectMake(0, 0, self.view.width/2, 45) tag:100 target:self];
         UIButton *cashOrders = [UIButton createButton:@selector(orderClicked:) title:@"现金订单" image:nil selectedBgImage:@"goods_cash_selected.png" backGroundImage:@"goods_cash_normal.png" backGroundTapeImage:nil frame:CGRectMake(self.view.width/2, 0, self.view.width/2, 45) tag:101 target:self];
        welfareOrders.titleLabel.font = cashOrders.titleLabel.font = [UIFont systemFontOfSize:16];
        welfareOrders.titleEdgeInsets = cashOrders.titleEdgeInsets = UIEdgeInsetsMake(0 , 25, 0, 5);
        if (!isShowWelfareHidden) {
            welfareOrders.selected = YES;
            cashOrders.selected = NO;
        }else{
            welfareOrders.selected = NO;
            cashOrders.selected = YES;
        }
        [headerView addSubview:welfareOrders];
        [headerView addSubview:cashOrders];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (OrderCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Order";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:nil options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell showWelfareViewWithHidden:isShowWelfareHidden withCashViewHidden:!isShowWelfareHidden];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isShowWelfareHidden) {
        OrderDetailViewController *cashOrderVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
        [self.navigationController pushViewController:cashOrderVC animated:YES];
    }else{
        MyOrderDetailViewController *welfareOrderVC = [[MyOrderDetailViewController alloc] initWithNibName:@"WelfareOrderViewController" bundle:nil];
        [self.navigationController pushViewController:welfareOrderVC animated:YES];
    }
}

#pragma mark - Custom Method
- (void)orderClicked:(UIButton *)sender{
    UIButton *button1 = (id)[self.view viewWithTag:100];
    UIButton *button2 = (id)[self.view viewWithTag:101];
    
    if (sender == button1) {
        isShowWelfareHidden = NO;
        [self.tableView reloadData];
    }else if(sender == button2){
        isShowWelfareHidden = YES;
        [self.tableView reloadData];
    }
}

@end
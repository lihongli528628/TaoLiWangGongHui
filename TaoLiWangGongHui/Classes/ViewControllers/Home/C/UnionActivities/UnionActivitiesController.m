//
//  UnionActivitiesController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UnionActivitiesController.h"
#import "ActivitiesDetailController.h"
#import "MessageCell.h"
#import "HomeListModel.h"
@interface UnionActivitiesController ()

@end

@implementation UnionActivitiesController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self changeIsSelfResquestWithBool:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"工会活动";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"navigation_Back.png" backgroundImage:nil target:self action:@selector(back) withRightBarItem:NO];
    self.navigationItem.rightBarButtonItem = nil;
    self.tableView.height = self.view.height - 64;
    
//    [self addHeader];
//    [self addFooter];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeListModel *homeModel = [[HomeListModel alloc] initWithDataDic:self.model[indexPath.row]];

    ActivitiesDetailController *activiteVC = [[ActivitiesDetailController alloc] initWithActivityType:indexPath.row+1 withID:homeModel.activityId];
    activiteVC.navigationItem.title = @"工会活动详情";
    [activiteVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:activiteVC animated:YES];
}

- (void)reloadNewData{
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = (MessageCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    HomeListModel *homeModel = [[HomeListModel alloc] initWithDataDic:self.model[indexPath.row]];
    [cell.goodImage setImageWithURL:[NSURL URLWithString:homeModel.activityPic]];
    cell.goodDescription.text = homeModel.activityTitle;
    return cell;
}

#pragma mark - Request Response
- (void)refreshHeaderView{
    NSDictionary *params = @{
                             @"memberId":[[UserHelper shareInstance] getMemberID],
                             @"pageSize":PAGESIZE,
                             @"pageNo":@"0"
                             };
    [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryActivityList_Url] withView:nil];
}

- (void)refreshFooterView{
    NSDictionary *params = @{
                             @"memberId":[[UserHelper shareInstance] getMemberID],
                             @"pageSize":PAGESIZE,
                             @"pageNo":[NSString stringWithFormat:@"%d",[self.model count]/PAGESIZEINT]
                             };
    [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryActivityList_Url] withView:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

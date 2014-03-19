//
//  SubscribeController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "SubscribeController.h"
#import "SubscribeCell.h"

@interface SubscribeController ()

@end

@implementation SubscribeController

- (id)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订阅管理";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"navigation_Back.png" backgroundImage:nil target:self action:@selector(back)];
    [self commitRequestWithParams:@{
                                    @"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"pageNo": @"0",
                                    @"pageSize":PAGESIZE ,} withUrl:[GlobalRequest articleAction_QuerySubscription_Url]];
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadNewData{
    [self.tableView reloadData];
}

#pragma mark - UITabelView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}

- (SubscribeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"SubscribeName";
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubscribeCell" owner:nil options:nil] lastObject];
    }
    [cell setObject:self.model[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
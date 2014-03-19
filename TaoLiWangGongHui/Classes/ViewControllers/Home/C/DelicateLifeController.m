//
//  DelicateLifeController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "DelicateLifeController.h"
#import "DelicateLifeCell.h"

@interface DelicateLifeController ()

@end

@implementation DelicateLifeController

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
    [super viewDidLoad];
    // 假数据
    self.navigationItem.title = @"精致生活";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self commitRequestWithParams:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"0" ,@"pageNo", 
                                   PAGESIZE,@"pageSize",nil] withUrl:[GlobalRequest activityAction_QueryJokeList_Url]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.model count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.model[indexPath.section];
    return [DelicateLifeCell getCellHeight:dict];
//    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (DelicateLifeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DelicateCell";
    DelicateLifeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DelicateLifeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict = self.model[indexPath.section];
    [cell setObject:dict];
    return cell;
}

@end
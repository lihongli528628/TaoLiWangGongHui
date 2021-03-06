//
//  PersonController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "PersonController.h"
#import "PersonCell.h"
#import "LBHarpy.h"
#import "SIAlertView.h"
@interface PersonController ()

@property (nonatomic, strong) NSMutableArray *cellNameArray;
@property (nonatomic, strong) NSMutableArray *classNameArray;

@end

@implementation PersonController
@synthesize personTableView;
@synthesize cellNameArray, classNameArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+2) style:UITableViewStyleGrouped];
    self.personTableView.backgroundView = [[UIView alloc] init];
    self.personTableView.delegate = self;
    self.personTableView.dataSource = self;
    [self.personTableView setTableFooterView:[[UIView alloc] init]];
    if (isIOS7) {
        self.personTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:self.personTableView];
    
    // 每个cell的文字，形成的一个数组
    cellNameArray = [NSMutableArray arrayWithObjects:
                     @"我的订单",
                     @"配送信息维护",
                     @"用户信息维护",
                     @"意见反馈",
                     @"软件版本信息",
                     @"关于我们", nil];
    classNameArray = [NSMutableArray arrayWithObjects:
                      @"MyOrderController",
                      @"AcceptAddressController",
                      @"UserInfoUpdateViewController",
                      @"FeedbackViewController",
                      @"",
                      @"AboutViewController",nil];
     self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"退出" image:nil target:self action:@selector(logout) font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] withRightBarItem:YES];
}

- (void)logout{
    
    [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"\n" message:@"确认要退出吗？\n\n" cancel:@"取消" others:@"确定"];
    
//    [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"" message:@"确认要退出吗？\n\n"];
//    [self alert2:nil];
//    return;
//    UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"\n确定要退出吗\n\n" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    logoutAlert.delegate = self;
//    [logoutAlert show];
}

#pragma mark - UITableView Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cellNameArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (PersonCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"personCellName";
    PersonCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellName];
    if (!cell) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = [self.cellNameArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    UIImageView *accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png"]];
    accessory.frame = CGRectMake(285, 0, 9, 16);
    accessory.centerY = cell.centerY;
    [cell.contentView addSubview:accessory];
//
    cell.textLabel.textColor = [UIColor colorWithHex:0x49443e];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    if (indexPath.row == 0) {
        cell.customImage.image = [UIImage imageNamed:@"input_Top.png"];
    }else if (indexPath.row == [cellNameArray count] - 1){
        cell.customImage.image = [UIImage imageNamed:@"input_Under.png"];
    }else
        cell.customImage.image = [UIImage imageNamed:@"input_Middle.png"];
    cell.indentationLevel = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {  //检查版本信息
        [LBHarpy checkVersion];
    }else{
        UIViewController *viewController = [[(id)NSClassFromString([self.classNameArray objectAtIndex:indexPath.row]) alloc] init];
        viewController.navigationItem.title = self.cellNameArray[indexPath.row];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)okClicked:(UIButton *)sender{
    NSLog(@"OK Clicked");
    [[UserHelper shareInstance] removeMemberID];
    AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
    [delegate chageLoginVC];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((alertView.tag == 1000) && buttonIndex == 1) {
        [self okClicked:nil];
    }
}

//- (void)alert2:(id)sender{
//
//    SEL sel = @selector(okClicked:);
//    [GlobalHelper showWithTitle:@"\n\n\n\n " withMessage:@"确认要退出吗？\n\n" withCancelTitle:@"取消" withOkTitle:@"确定" withSelector:sel withTarget:self];
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

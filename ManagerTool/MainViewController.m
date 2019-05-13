//
//  MainViewController.m
//  ManagerTool
//
//  Created by 1 on 2019/5/13.
//  Copyright © 2019年 1. All rights reserved.
//

#import "MainViewController.h"
#import "TimeViewController.h"
#import "ChineseSortViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *managerToolArray;
@property (nonatomic, strong) NSArray *toolVCNameArray;

@end

@implementation MainViewController
- (NSArray *)managerToolArray{
    if (!_managerToolArray) {
        _managerToolArray = @[@"时间管理",
                              @"中文排序",];
    }
    return _managerToolArray;
}
- (NSArray *)toolVCNameArray{
    if (!_toolVCNameArray) {
        _toolVCNameArray = @[@"TimeViewController",
                             @"ChineseSortViewController"];
    }
    return _toolVCNameArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理工具";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configTableView];
}
- (void)configTableView{
    float top = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, self.view.bounds.size.width, self.view.bounds.size.height - top) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    /*适配ios11*/
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.scrollIndicatorInsets = tableView.contentInset;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    [self.view addSubview:tableView];
    
}

#pragma mark -------------------- Cell的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.managerToolArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!Cell) {
        Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Cell.textLabel.text = self.managerToolArray[indexPath.row];
    return Cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = self.toolVCNameArray[indexPath.row];
    id vvcc = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vvcc animated:YES];
}
@end

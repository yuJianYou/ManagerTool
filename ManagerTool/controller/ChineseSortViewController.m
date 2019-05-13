//
//  ChineseSortViewController.m
//  ManagerTool
//
//  Created by 1 on 2019/5/13.
//  Copyright © 2019年 1. All rights reserved.
//

#import "ChineseSortViewController.h"
#import "HZXChineseSortTool.h"
#import "UITableView+ZYXIndexTip.h"

@interface ChineseSortViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *provinceNameArray;
@property (nonatomic, strong) NSMutableArray *letterArray;//字母数组
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) UITableView *tableView;
//是否是排序
@property (nonatomic, assign) BOOL isSort;
@end

@implementation ChineseSortViewController
- (NSMutableArray *)provinceNameArray{
    if (!_provinceNameArray) {
        _provinceNameArray = [NSMutableArray array];
    }
    return _provinceNameArray;
}
- (NSMutableArray *)letterArray{
    if (!_letterArray) {
        _letterArray = [NSMutableArray array];
    }
    return _letterArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *sortBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(sortAction)];
    self.navigationItem.rightBarButtonItem = sortBtnItem;
    
    
    _dataSourceArray = [NSArray array];
    
    //获取数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@"plist"];
    _dataSourceArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    [_dataSourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *provinceStr = [NSString stringWithFormat:@"%@",obj[@"State"]];
        [self.provinceNameArray addObject:provinceStr];
    }];
    //排序
    [self configTableView];
    
}
- (void)configTableView{
    float top = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, self.view.bounds.size.width, self.view.bounds.size.height - top) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
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
    if (_isSort) {
        return self.provinceNameArray.count;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isSort) {
        return [self.provinceNameArray[section] count];
    }else{
        return self.provinceNameArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!Cell) {
        Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isSort) {
        Cell.textLabel.text = self.provinceNameArray[indexPath.section][indexPath.row][@"State"];
    }else{
        Cell.textLabel.text = self.provinceNameArray[indexPath.row];
    }
    
    return Cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_isSort) {
        return 30;
    }else{
        return 0.001;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_isSort) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        sectionView.backgroundColor = [UIColor lightGrayColor];
        
        //标题
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100 ,sectionView.bounds.size.height)];
        label.text = [NSString stringWithFormat:@"%@",self.letterArray[section]];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        [sectionView addSubview:label];
        return sectionView;
    }else{
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
#pragma mark 右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.letterArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

///排序事件
- (void)sortAction{
    if (!_isSort) {
        ///字母数组
        NSArray *letterArray = [HZXChineseSortTool IndexArray:self.provinceNameArray];
        [self.letterArray addObjectsFromArray:letterArray];
    }
    //数据源
    [self.provinceNameArray removeAllObjects];
    NSArray *tempArray = [HZXChineseSortTool sortObjectArray:_dataSourceArray Key:@"State"];
    _isSort = YES;
    [self.provinceNameArray addObjectsFromArray:tempArray];
    
    [self.tableView addIndexTip];
    
    
    [self.tableView reloadData];
}
@end

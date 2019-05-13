//
//  TimeViewController.m
//  ManagerTool
//
//  Created by 1 on 2019/5/13.
//  Copyright © 2019年 1. All rights reserved.
//

#import "TimeViewController.h"
#import "HZXTimeManagerTool.h"
@interface TimeViewController ()

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ///获取当前时间戳
    NSString *currentTimestamp = [HZXTimeManagerTool getCurrentTimeTimestampIsMillisecond:NO];
    NSLog(@"***** 当前时间戳为:%@ *****",currentTimestamp);
    
    ///获取当前时间
    NSString *currentTime = [HZXTimeManagerTool getCurrentTime];
    NSLog(@"***** 当前时间为:%@ *****",currentTime);
    
    //date转换成字符串
    NSString *currentTimeStr = [HZXTimeManagerTool changeDateToTimeStrWithDate:[NSDate date]];
    NSLog(@"***** 当前时间为:%@ *****",currentTimeStr);
    
    //date转换成字符串
    NSDate *timeDate = [HZXTimeManagerTool changeTimeStrToDateWithTimeStr:@"2019-5-13 15:16:36"];
    NSLog(@"***** 转换过后时间为:%@ *****",timeDate);
    
}



@end

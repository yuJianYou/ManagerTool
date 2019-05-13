//
//  HZXTimeManagerTool.m
//  ManagerTool
//
//  Created by 1 on 2019/5/13.
//  Copyright © 2019年 1. All rights reserved.
//

#import "HZXTimeManagerTool.h"

static NSString *defaultDateFormatter = @"yyyy-MM-dd HH:mm:ss";


@implementation HZXTimeManagerTool
#pragma mark -------------------- 获取当前时间戳
+ (NSString *)getCurrentTimeTimestampIsMillisecond:(BOOL)millisecond{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = @"";
    if (millisecond) {
        timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    }else{
        timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    }
    return timeSp;
}

#pragma mark -------------------- 获取当前时间
+ (NSString *)getCurrentTime{
    return [HZXTimeManagerTool getCurrentTimeWithDateFormatter:defaultDateFormatter];
}
+ (NSString *)getCurrentTimeWithDateFormatter:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}
#pragma mark -------------------- 获取距离现在过去了多久
+ (NSString *)getPastTimeWithTimeStr:(NSString *)timeStr{
    return [HZXTimeManagerTool getPastTimeWithTimeStr:timeStr WithDateFormatter:defaultDateFormatter];
}
+ (NSString *)getPastTimeWithTimeStr:(NSString *)timeStr WithDateFormatter:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:timeStr];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    NSInteger tempTime = (NSInteger)[current_date timeIntervalSinceDate:newsDateFormatted];
    NSInteger year = tempTime / (3600 * 24 * 30 * 12);
    NSInteger month = tempTime / (3600 * 24 * 30);
    NSInteger days = tempTime / (3600 * 24);
    NSInteger hours = tempTime % (3600 *24 ) / 3600;
    NSInteger minute = tempTime % (3600*24) / 60;
    NSInteger second = tempTime % 60;
    NSString *dateContent;
    if ( year !=0 ){
        dateContent = [NSString stringWithFormat:@"%ld年前",year];
    } else if ( month !=0 ){
        dateContent = [NSString stringWithFormat:@"%ld个月前",month];
    }else if ( days != 0 ){
        dateContent = [NSString stringWithFormat:@"%ld天前",days];
    }else if ( hours != 0 ){
        dateContent = [NSString stringWithFormat:@"%ld小时前",hours];
    }else if ( minute != 0 ){
        dateContent = [NSString stringWithFormat:@"%ld分钟前",minute];
    }else{
        dateContent = [NSString stringWithFormat:@"%ld秒前",second];
    }
    return dateContent;
}
+ (NSString *)getPastTimeWithTimeTimestamp:(NSString *)timestamp{
    NSTimeInterval pastTimeStamp = [timestamp doubleValue];
    NSTimeInterval currentTimeStamp = [[HZXTimeManagerTool getCurrentTimeTimestampIsMillisecond:NO] doubleValue];
    NSInteger tempTime = currentTimeStamp - pastTimeStamp;
    NSInteger year = tempTime / (3600 * 24 * 30 * 12);
    NSInteger month = tempTime / (3600 * 24 * 30);
    NSInteger days = tempTime / (3600 * 24);
    NSInteger hours = tempTime % (3600 *24 ) / 3600;
    NSInteger minute = tempTime % (3600*24) / 60;
    NSInteger second = tempTime % 60;
    NSString *dateContent;
    if ( year !=0 ){
        dateContent = [NSString stringWithFormat:@"%ld年前",year];
    } else if ( month !=0 ){
        dateContent = [NSString stringWithFormat:@"%ld个月前",month];
    }else if ( days != 0 ){
        dateContent = [NSString stringWithFormat:@"%ld天前",days];
    }else if ( hours != 0 ){
        dateContent = [NSString stringWithFormat:@"%ld小时前",hours];
    }else if ( minute != 0 ){
        dateContent = [NSString stringWithFormat:@"%ld分钟前",minute];
    }else{
        dateContent = [NSString stringWithFormat:@"%ld秒前",second];
    }
    return dateContent;
    
    
}
#pragma mark -------------------- 时间转换
//Date转换成字符串
+ (NSString *)changeDateToTimeStrWithDate:(NSDate *)timeDate{
    return [HZXTimeManagerTool changeDateToTimeStrWithDate:timeDate WithDateFormatter:defaultDateFormatter];
}
+ (NSString *)changeDateToTimeStrWithDate:(NSDate *)timeDate WithDateFormatter:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *timeStr = [dateFormatter stringFromDate:timeDate];
    
    return timeStr;
}
//字符串转换成Date
+ (NSDate *)changeTimeStrToDateWithTimeStr:(NSString *)timeStr{
    return [HZXTimeManagerTool changeTimeStrToDateWithTimeStr:timeStr WithDateFormatter:defaultDateFormatter];
}
+ (NSDate *)changeTimeStrToDateWithTimeStr:(NSString *)timeStr WithDateFormatter:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter dateFromString:timeStr];
}
#pragma mark -------------------- 日期比较
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    NSString *dateFormat = defaultDateFormatter;
    return [HZXTimeManagerTool compareOneDay:oneDay withAnotherDay:anotherDay WithDateFormat:dateFormat];
}
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay WithDateFormat:(nonnull NSString *)dateFormat{
 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //前者时间比后者时间长
        return 1;
    }else if (result == NSOrderedAscending){
        //前者时间比后者时间短
        return -1;
    }else{
        //两个时间相等.
        return 0;
    }
}
+ (int)compareOneDayStr:(NSString *)oneDayStr withAnotherDayStr:(NSString *)anotherDayStr{
    return [HZXTimeManagerTool compareOneDayStr:oneDayStr withAnotherDayStr:anotherDayStr WithDateFormat:defaultDateFormatter];
}
+ (int)compareOneDayStr:(NSString *)oneDayStr withAnotherDayStr:(NSString *)anotherDayStr WithDateFormat:(NSString *)dateFormat{
    NSDate *dateA = [HZXTimeManagerTool changeTimeStrToDateWithTimeStr:oneDayStr WithDateFormatter:dateFormat];
    NSDate *dateB = [HZXTimeManagerTool changeTimeStrToDateWithTimeStr:anotherDayStr WithDateFormatter:dateFormat];
    return [HZXTimeManagerTool compareOneDay:dateA withAnotherDay:dateB WithDateFormat:dateFormat];
}
+ (NSComparisonResult)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay WithUnitGranularity:(NSCalendarUnit)unit{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar compareDate:oneDay toDate:anotherDay toUnitGranularity:unit];
}
#pragma mark -------------------- 获取年龄
+ (NSString *)getAgeWithBirthday:(NSString *)birthday{
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSDate *birthdayDate = [HZXTimeManagerTool changeTimeStrToDateWithTimeStr:birthday WithDateFormatter:@"yyyy-MM-dd"];
    NSTimeInterval time = [currentDate timeIntervalSinceDate:birthdayDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}
+ (NSString *)getDetailsAgeWithBirthday:(NSString *)birthday{
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //创建日历(格里高利历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置component的组成部分
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    //按照组成部分格式计算出生日期与现在时间的时间间隔
    NSDate *birthdayDate = [HZXTimeManagerTool changeTimeStrToDateWithTimeStr:birthday WithDateFormatter:@"yyyy-MM-dd"];
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthdayDate toDate:currentDate options:0];
    
    //判断年龄大小,以确定返回格式
    if( [date year] > 0){
        return [NSString stringWithFormat:(@"%ld岁%ld月%ld天"),(long)[date year],(long)[date month],(long)[date day]];
    }else if([date month] >0){
        return [NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]];
    }else if([date day]>0){
        return [NSString stringWithFormat:(@"%ld天"),(long)[date day]];
    }else {
        return @"0天";
    }
}
#pragma mark -------------------- 把空字符串去除
///把空对象字符串转化为空字符串
+ (NSString *)EmptyStringByWhitespaceWithobject:(NSString *)contentStr{
    NSString *str = @"";
    if (contentStr && contentStr.length > 0) {
        str = [contentStr stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    return str;
}
#pragma mark 清空字符串中的空白字符
+ (NSString *)trimStringWithStr:(NSString *)contentStr{
    NSString *trim = [contentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [trim stringByReplacingOccurrencesOfString:@" " withString:@""];
}
+ (BOOL)isEmptyStringWithStr:(NSString *)contentStr{
    NSString *tempStr = [HZXTimeManagerTool EmptyStringByWhitespaceWithobject:[NSString stringWithFormat:@"%@",contentStr]];
    NSString *str = [HZXTimeManagerTool trimStringWithStr:tempStr];
    return (!str || str.length <1  || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@""] || str == nil);
}
@end

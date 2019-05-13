//
//  HZXTimeManagerTool.h
//  ManagerTool
//
//  Created by 1 on 2019/5/13.
//  Copyright © 2019年 1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZXTimeManagerTool : NSObject
#pragma mark -------------------- 获取当前时间戳
/**
 获取当前时间戳  millisecond 是否是毫秒级 YES:毫秒级 NO:秒级
 
 @param millisecond 是否是毫秒级
 @return 当前时间戳
 */
+ (NSString *)getCurrentTimeTimestampIsMillisecond:(BOOL)millisecond;

#pragma mark -------------------- 获取当前时间

/**
 获取当前时间
 
 @return 当前时间
 */
+ (NSString *)getCurrentTime;
+ (NSString *)getCurrentTimeWithDateFormatter:(NSString *)dateFormat;

#pragma mark -------------------- 时间转换

/**
 NSDate转换成字符串
 默认时间格式是  yyyy-MM-dd HH:mm:ss  如果想指定格式请用第二个方法
 
 @param timeDate 时间
 @return 字符串
 */
+ (NSString *)changeDateToTimeStrWithDate:(NSDate *)timeDate;
+ (NSString *)changeDateToTimeStrWithDate:(NSDate *)timeDate WithDateFormatter:(NSString *)dateFormat;


/**
 字符串转换成date
 默认时间格式是  yyyy-MM-dd HH:mm:ss  如果想指定格式请用第二个方法
 
 @param timeStr 字符串
 @return date
 */
+ (NSDate *)changeTimeStrToDateWithTimeStr:(NSString *)timeStr;
+ (NSDate *)changeTimeStrToDateWithTimeStr:(NSString *)timeStr WithDateFormatter:(NSString *)dateFormat;

#pragma mark -------------------- 时间比较
/**
 比较两个日期的大小 -1：表示后者比前者大  0：表示两个日期相同  1：表示前者比后者大
 默认时间格式是  yyyy-MM-dd HH:mm:ss  如果想指定格式请用第二个方法
 
 @param oneDay 一个日期
 @param anotherDay 另一个日期
 @return 返回一个比较值
 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay WithDateFormat:(NSString *)dateFormat;
/**
 比较两个日期的大小 -1：表示后者比前者大  0：表示两个日期相同  1：表示前者比后者大
 默认时间格式是  yyyy-MM-dd HH:mm:ss  如果想指定格式请用第二个方法
 */
+ (int)compareOneDayStr:(NSString *)oneDayStr withAnotherDayStr:(NSString *)anotherDayStr;
+ (int)compareOneDayStr:(NSString *)oneDayStr withAnotherDayStr:(NSString *)anotherDayStr WithDateFormat:(NSString *)dateFormat;
/**
 用日历的方式比较两个日期的大小 -1：表示后者比前者大  0：表示两个日期相同  1：表示前者比后者大
 最后一个参数是一个枚举值  传入比较的单位，例如：比较是否是同一年 传入 NSCalendarUnitYear
 @param oneDay 一个日期
 @param anotherDay 另一个日期
 @param unit 枚举值 例如：比较是否是同一天 传入 NSCalendarUnitDay
 @return 返回一个比较值
 */
+ (NSComparisonResult)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay WithUnitGranularity:(NSCalendarUnit)unit;
#pragma mark -------------------- 获取距离现在过去了多久

/**
 处理时间距离现在过去多久了
 默认时间格式是  yyyy-MM-dd HH:mm:ss  如果想指定格式请用第二个方法
 
 @param timeStr 时间字符串
 @return 处理好的时间
 */
+ (NSString *)getPastTimeWithTimeStr:(NSString *)timeStr;
+ (NSString *)getPastTimeWithTimeStr:(NSString *)timeStr WithDateFormatter:(NSString *)dateFormat;

/**
 处理时间距离现在过去多久了   参数为时间戳
 
 @param timestamp 过去时间的时间戳
 @return 处理好的时间
 */
+ (NSString *)getPastTimeWithTimeTimestamp:(NSString *)timestamp;
#pragma mark -------------------- 获取年龄
/**
 根据出生日期返回年龄的方法
 @param birthday 出生日期
 */
+ (NSString *)getAgeWithBirthday:(NSString *)birthday;
/**
 根据出生日期返回详细的年龄(精确到天)
 @param birthday 出生日期
 */
+ (NSString *)getDetailsAgeWithBirthday:(NSString *)birthday;
@end

NS_ASSUME_NONNULL_END

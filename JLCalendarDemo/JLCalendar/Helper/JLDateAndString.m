//
//  JLDateAndString.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLDateAndString.h"

@implementation JLDateAndString

+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

@end

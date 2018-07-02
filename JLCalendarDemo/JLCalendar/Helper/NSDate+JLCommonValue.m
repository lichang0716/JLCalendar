//
//  NSDate+JLCommonValue.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "NSDate+JLCommonValue.h"

@implementation NSDate (JLCommonValue)

- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

- (NSInteger)firstDayOfMonthWeekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:components];
    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    [weekFormatter setDateFormat:@"EEEE"];
    NSString *weekStr = [weekFormatter stringFromDate:firstDayOfMonthDate];
    return [self indexOfWeekStr:weekStr];
}

- (NSInteger)indexOfWeekStr:(NSString *)str {
    NSArray *weekArr = @[@"Sunday", @"Monday", @"Tuesdaty", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
    __block NSInteger index = -1;
    [weekArr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:str]) {
            index = idx;
            *stop = index != -1;
        }
    }];
    return index;
}

- (NSInteger)totalDayCountInMonth {
    NSRange daysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return daysInMonth.length;
}

- (NSDate *)lastMonth {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *lastMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    return lastMonthDate;

}

- (NSDate *)nextMonth {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = +1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    return nextMonthDate;
}

- (BOOL)dateInPast:(NSDate *)date {
    if ([self laterDate:date] == date) {
        return NO;
    }
    return YES;
}

@end

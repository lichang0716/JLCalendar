//
//  NSDate+JLCommonValue.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JLCommonValue)

- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;
- (NSInteger)firstDayOfMonthWeekday;
- (NSInteger)totalDayCountInMonth;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;
- (BOOL)dateInPast:(NSDate *)date;

@end

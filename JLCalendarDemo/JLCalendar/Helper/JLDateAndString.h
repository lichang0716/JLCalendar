//
//  JLDateAndString.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLDateAndString : NSObject

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSDate *)dateFromString:(NSString *)string;

@end

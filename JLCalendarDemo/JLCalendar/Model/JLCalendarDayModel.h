//
//  JLCalendarDayModel.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLCalenderMonthModel.h"

typedef NS_ENUM(NSUInteger, JLCalendarDaySelectedMode) {
    JLCalendarSelectedModeNone = 0,
    JLCalendarSelectedModeFirst = 1,
    JLCalendarSelectedModeSecond = 2
};

@interface JLCalendarDayModel : NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger yeaer;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) JLCalenderMonthModel *monthModel;
@property (nonatomic, assign) BOOL selectable;
@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, assign) JLCalendarDaySelectedMode selectMode;

@property (nonatomic, copy) NSString *cornerImageName; // 角标图片名称

/**
 是否处于被包括状态
 */
@property (nonatomic, assign, getter=isIncluded) BOOL included;

/**
 该模型处在collection的indexPath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

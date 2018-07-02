//
//  JLCalenderDateManager.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLCalenderDateManager.h"
#import "NSDate+JLCommonValue.h"
#import "JLCalenderMonthModel.h"
#import "JLDateAndString.h"
#import "JLCalendarDayModel.h"
#import "JLCalendarDefine.h"

@interface JLCalenderDateManager ()

@property (nonatomic, strong) NSMutableArray *monthModuleArray;
@property (nonatomic, assign, getter=isRefresh) BOOL refresh;

@end

@implementation JLCalenderDateManager

static JLCalenderDateManager *sharedManager = nil;

+ (JLCalenderDateManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedManager == nil) {
            sharedManager = [[self alloc] init];
            
            sharedManager.monthCount = 2;
            sharedManager.selectedSicneToday = NO;
            sharedManager.minSelectedDays = 1;
            sharedManager.maxSelectedDays = 1;
            sharedManager.shownStopDayStr = @"";
            sharedManager.shownStartDayStr = @"";
        }
    });
    return sharedManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedManager == nil) {
            sharedManager = [super allocWithZone:zone];
        }
    });
    return sharedManager;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

#pragma mark generate date

- (void)getCalenderDateComplete:(completeBlock)complete {
    if (!self.isRefresh && _monthModuleArray.count) {
        if (complete) {
            complete(_monthModuleArray);
        }
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSMutableArray *monthModelArray = [NSMutableArray array];
        NSDate *currentDate;
        if (self.shownStartDayStr.length > 0) {
            currentDate = [JLDateAndString dateFromString:self.shownStartDayStr];
        } else {
            currentDate = [NSDate date];
        }

        NSInteger totalDayCount = [currentDate totalDayCountInMonth];
        NSInteger firstDay = [currentDate firstDayOfMonthWeekday];
        NSInteger year = [currentDate year];
        NSInteger month = [currentDate month];
        NSInteger day = [currentDate day];
        
        NSDate *stopDate;
        if (self.shownStopDayStr.length > 0) {
            stopDate = [JLDateAndString dateFromString:self.shownStopDayStr];
        }
        
        for (NSInteger y = year; y < year + 2; y++) {
            for (NSInteger m = month; m <= 12; m++) {
                JLCalenderMonthModel *monthModel = [[JLCalenderMonthModel alloc] init];
                monthModel.year = y;
                monthModel.month = m;
                monthModel.firstDayWeek = firstDay;
                
                NSMutableArray *dayModelArray = [NSMutableArray array];
                
                NSInteger startPosition = [[JLDateAndString stringFromDate:currentDate] isEqualToString:self.shownStartDayStr] ? day : 1;
                NSInteger stopPosition = [[JLDateAndString stringFromDate:currentDate] isEqualToString:self.shownStopDayStr] ? day : totalDayCount;
                
                for (NSInteger d = startPosition; d < stopPosition+1; d++) {
                    NSString *dateStr = [NSString stringWithFormat:@"%li-%02li-%02li", y, m, d];
                    NSDate *date = [JLDateAndString dateFromString:dateStr];
                    
                    JLCalendarDayModel *dayModel = [[JLCalendarDayModel alloc] init];
                    dayModel.day = d;
                    dayModel.month = m;
                    dayModel.yeaer = y;
                    dayModel.week = (firstDay + d - 1) % 7;
                    dayModel.monthModel = monthModel;
                    dayModel.date = date;
                    dayModel.selectable = YES;
                    // 如果需要从今天才可以开始选择
                    if (self.isSelectedSinceToday) {
                        dayModel.selectable = ![[NSDate date] dateInPast:date];
                    }
                    // 如果是今天
                    if ([[JLDateAndString stringFromDate:[NSDate date]] isEqualToString:[JLDateAndString stringFromDate:date]]) {
                        dayModel.isToday = YES;
                        dayModel.selectable = YES;
                    }
                    
                    // 判断有没有角标
                    if ([self.imageAndDateDic allKeys] > 0) {
                        [[self.imageAndDateDic allKeys] enumerateObjectsUsingBlock:^(NSString *dateStr, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([dateStr isEqualToString:[JLDateAndString stringFromDate:date]]) {
                                dayModel.cornerImageName = [self.imageAndDateDic objectForKey:dateStr];
                            }
                        }];
                    }
                    
                    // 再根据传入的不可选择数据，进行不可选择的判断
                    if (_disabledDateArr.count && dayModel.selectable) {
                        [_disabledDateArr enumerateObjectsUsingBlock:^(NSDate *disabledDate, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSComparisonResult disableResult = [dayModel.date compare:disabledDate];
                            dayModel.selectable = disableResult == NSOrderedSame || !dayModel.selectable ? NO : YES;
                            *stop = !dayModel.selectable;
                        }];
                    } else if (_disabledDaysArr.count && dayModel.selectable) {
                        [_disabledDaysArr enumerateObjectsUsingBlock:^(NSString *disabledDateStr, NSUInteger idx, BOOL * _Nonnull stop) {
                            dayModel.selectable = [disabledDateStr isEqualToString:dateStr] ? NO : YES;
                            *stop = !dayModel.selectable;
                        }];
                    }
                    
                    [dayModelArray addObject:dayModel];
                }
                monthModel.dayModelArray = dayModelArray;
                
                currentDate = [currentDate nextMonth];
                
                if (stopDate && currentDate.month == stopDate.month && currentDate.year == stopDate.year) {
                    currentDate = stopDate;
                }
                totalDayCount = [currentDate totalDayCountInMonth];
                firstDay = [currentDate firstDayOfMonthWeekday];
                day = [currentDate day];
                
                [monthModelArray addObject:monthModel];
                if (monthModelArray.count == _monthCount) break;
            }
            
            month = 1;
            if (monthModelArray.count == _monthCount) break;
        }
        
        if (_monthModuleArray) {
            [_monthModuleArray removeAllObjects];
            [_monthModuleArray addObjectsFromArray:monthModelArray];
        }
        
        if (complete) {
            complete(monthModelArray);
        }
    });
}

- (void)refreshDataComplete:(loadCompleteBlock)complete {
    self.refresh = YES;
    [self getCalenderDateComplete:^(NSMutableArray *monthModelArray) {
        self.refresh = NO;
        if (complete) {
            complete();
        }
    }];
}


@end

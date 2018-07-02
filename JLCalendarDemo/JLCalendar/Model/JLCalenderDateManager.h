//
//  JLCalenderDateManager.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLCalendarDayModel.h"

typedef NS_ENUM(NSUInteger, JLSelectedFailReason) {
    JLSelectedFailReasonDateDisable = 0,
    JLSelectedFailReasonIncludeDateDisable = 1,
    JLSelectedFailReasonDaysCountTooSmall = 2,
    JLSelectedFailReasonDaysCountTooBig = 3
};

typedef void(^selectFailBlock)(JLSelectedFailReason selectedFailReason); // select days fail block
typedef void(^completeBlock)(NSMutableArray *monthModelArray);  // select days scuccess block
typedef void(^returnBlock)(JLCalendarDayModel *firstSelectDayModel, JLCalendarDayModel *secondSelectDayModel);  // select two days result
typedef void(^loadCompleteBlock)(void); // load finish block

// date manager
@interface JLCalenderDateManager : NSObject

@property (nonatomic, strong) NSArray *disabledDaysArr; // 不能被选择的字符串日期数组，格式 "2018-06-28"
@property (nonatomic, strong) NSArray *disabledDateArr; // 不能被选择的 date 日期数组

@property (nonatomic, strong) NSDictionary *imageAndDateDic;  // 显示角标和对应日期的字典，格式 {@"2018-06-28":@"fianlImage", ...}

@property (nonatomic, assign, getter=isSelectedSinceToday) BOOL selectedSicneToday; // 从今天开始可以被选择

@property (nonatomic, copy) NSString *shownStartDayStr; // 显示的开始日期
@property (nonatomic, copy) NSString *shownStopDayStr;  // 显示的最后一天

@property (nonatomic, assign) NSInteger monthCount; // 需要显示几个月份，默认2

@property (nonatomic, assign) NSInteger minSelectedDays;    // 最少需要选择几天
@property (nonatomic, assign) NSInteger maxSelectedDays;    // 最多可以选择几天

@property (nonatomic, assign, getter=isMutibleEnable) BOOL mutibleEnable;   // 是否允许多选

@property (nonatomic, copy) selectFailBlock selectedFail;   // 选择失败回调
@property (nonatomic, copy) returnBlock finishSelect;   // 完成选择回调
@property (nonatomic, copy) loadCompleteBlock loadComplete; // 数据准备完成

@property (nonatomic, strong) JLCalendarDayModel *selectFirstDayModel;  // 选择的第一个日期
@property (nonatomic, strong) JLCalendarDayModel *selectSecondDayModel; // 选择的第二个日期


/**
 singleton object

 @return date manager
 */
+ (JLCalenderDateManager *)sharedManager;

/**
 generate date

 @param complete actions after finish
 */
- (void)getCalenderDateComplete:(completeBlock)complete;

/**
 refresh current data

 @param complete follow action
 */
- (void)refreshDataComplete:(loadCompleteBlock)complete;

/**
 clear all select
 */
- (void)clearSelection;





@end

//
//  JLCalenderController.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLCalendarDayModel.h"

typedef void(^closeBlock)(JLCalendarDayModel *startModel, JLCalendarDayModel *stopModel);

@interface JLCalenderController : UIViewController

@property (nonatomic, copy) NSString *matchStartDateStr; // 比赛开始日期
@property (nonatomic, copy) NSString *matchStopDateStr; // 比赛结束日期
@property (nonatomic, copy) NSArray *datesArrWithoutMatch; //没有比赛的日期
@property (nonatomic, copy) NSString *selectedDate; // 当前选中的日期
@property (nonatomic, copy) NSString *todayTime; // 当天日期

@property (nonatomic, copy) closeBlock closeBlock;

@end

//
//  JLCalenderMonthModel.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JLCalendarDayModel;

@interface JLCalenderMonthModel : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger firstDayWeek;

@property (nonatomic, strong) NSArray<JLCalendarDayModel *> *dayModelArray;

@end

//
//  JLCalenderCollectionView.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLMonthTitleCollectionViewCell.h"
#import "JLCalenderCollectionView.h"


typedef void(^didClickItems)(NSDate *firstDate, NSDate *secondDate);

@interface JLCalenderCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *monthDateArray;

@property (nonatomic, copy) NSString *matchStartDateStr; // 比赛开始日期
@property (nonatomic, copy) NSString *matchStopDateStr; // 比赛结束日期
@property (nonatomic, copy) NSArray *datesArrWithoutMatch; //没有比赛的日期
@property (nonatomic, copy) NSString *selectedDate; // 当前选中的日期
@property (nonatomic, copy) NSString *todayTime; // 当天日期

@property (nonatomic, copy) didClickItems didClickItems;

@property (nonatomic, assign, getter=isLoadComplete) BOOL loadComplete;

@end

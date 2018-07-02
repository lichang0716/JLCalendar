//
//  JLCalendarCell.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JLCalenderDayModel;

@interface JLCalendarCell : UICollectionViewCell

@property (nonatomic, strong) JLCalenderDayModel *dayModel;

@end

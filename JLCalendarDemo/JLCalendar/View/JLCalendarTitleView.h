//
//  JLCalendarTitleView.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/29.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickCloseButton)(void);

@interface JLCalendarTitleView : UIView

@property (nonatomic, copy) clickCloseButton clickCloseButton;

@end

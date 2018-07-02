//
//  JLCalendarMonthTitleView.h
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLCalendarMonthTitleView.h"
#import "JLCalendarDefine.h"

@interface JLCalendarMonthTitleView()

@property (nonatomic, strong) UILabel *monthTitleLabel;

@end

@implementation JLCalendarMonthTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _monthTitleLabel = [[UILabel alloc] init];
    _monthTitleLabel.frame = CGRectMake((CGRectGetWidth(self.frame) - JLCalendarMonthTitleWidth)/2,
                                        (CGRectGetHeight(self.frame) - JLCalendarMonthTitleHeight) / 2,
                                        JLCalendarMonthTitleWidth,
                                        JLCalendarMonthTitleHeight);
    _monthTitleLabel.font = [UIFont systemFontOfSize:JLCalendarMonthTitleFontSize];
    _monthTitleLabel.textColor = JLCalendarMonthTitleFontColor;
    _monthTitleLabel.backgroundColor = JLCalendarMonthTitleBackgroundColor;
    _monthTitleLabel.layer.cornerRadius = JLCalendarMonthTitleHeight / 2.0;
    _monthTitleLabel.layer.masksToBounds = YES;
    _monthTitleLabel.layer.shouldRasterize = YES;
    _monthTitleLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _monthTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_monthTitleLabel];
}

- (void)setMonthTitle:(NSString *)monthTitle {
    _monthTitle = monthTitle;
    _monthTitleLabel.text = monthTitle;
}


@end

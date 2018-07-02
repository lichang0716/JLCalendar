//
//  JLMonthTitleCollectionViewCell.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/29.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLMonthTitleCollectionViewCell.h"
#import "JLCalendarDefine.h"

@interface JLMonthTitleCollectionViewCell()

@property (nonatomic, strong) UILabel *monthTitleLabel;

@end

@implementation JLMonthTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _monthTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _monthTitleLabel.font = [UIFont systemFontOfSize:12];
    _monthTitleLabel.textColor = JLColorWithHex(0x999999);
    _monthTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_monthTitleLabel];
}

- (void)setMonthTitle:(NSString *)monthTitle {
    if (monthTitle.length > 0) {
        _monthTitle = monthTitle;
        _monthTitleLabel.text = monthTitle;
    }
}


@end

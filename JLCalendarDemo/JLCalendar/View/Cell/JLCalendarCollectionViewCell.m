//
//  JLCalendarCollectionViewCell.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/29.
//  Copyright © 2018年 pwnlc. All rights reserved.
//



#define CellLeftAndRightPadding    5.0

#import "JLCalendarCollectionViewCell.h"
#import "JLCalendarDefine.h"

@interface JLCalendarCollectionViewCell()

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UIImageView *conorFlagImageView;

@end

@implementation JLCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = JLColorWithHex(0xFFFFFF);
        self.opaque = YES;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    CGFloat labelLeft = (CGRectGetWidth(self.frame) - 36)/2.0;
    CGFloat labelTop = (CGRectGetHeight(self.frame)-36)/2.0;
    
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, labelTop, 36, 36)];
    _dayLabel.layer.cornerRadius = 18;
    _dayLabel.font = [UIFont systemFontOfSize:15];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dayLabel];
    
    _conorFlagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(labelLeft + 24, labelTop, 24, 12)];
    _conorFlagImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_conorFlagImageView];
}

- (void)setDayModel:(JLCalendarDayModel *)dayModel {
    _dayModel = dayModel;
    if (dayModel) {
        _dayLabel.text = [NSString stringWithFormat:@"%02li", dayModel.day];
        if (!dayModel.selectable) {
            _dayLabel.textColor = JLColorWithHex(0x999999);
            _dayLabel.layer.backgroundColor = JLColorWithHex(0xFFFFFF).CGColor;
        } else if (dayModel.isToday) {
            _dayLabel.textColor = JLColorWithHex(0xF25149);
        } else if (dayModel.included) {
            // 如果是被包括状态
        } else {
            _dayLabel.textColor = JLColorWithHex(0x333333);
            _dayLabel.layer.backgroundColor = JLColorWithHex(0xFFFFFF).CGColor;
        }
        
        if (dayModel.selectMode == JLCalendarSelectedModeFirst ||
            dayModel.selectMode == JLCalendarSelectedModeSecond) {
            _dayLabel.layer.cornerRadius = CGRectGetWidth(_dayLabel.frame)/2.0;
            _dayLabel.layer.backgroundColor = JLColorWithHex(0xE54042).CGColor;
            _dayLabel.clipsToBounds = YES;
            _dayLabel.textColor = JLColorWithHex(0xFFFFFF);
        }
        
        // 显示图片
        if (dayModel.cornerImageName.length > 0) {
            _conorFlagImageView.image = [UIImage imageNamed:dayModel.cornerImageName];
        } else {
            _conorFlagImageView.image = nil;
        }
    } else {
        _dayLabel.text = @"";
        _conorFlagImageView.image = nil;
    }
}

@end

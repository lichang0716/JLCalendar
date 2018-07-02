//
//  JLCalendarWeeksView.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/29.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLCalendarWeeksView.h"
#import "JLCalendarDefine.h"

@interface JLCalendarWeeksView()

@property (nonatomic, strong) NSArray *weekStrArray;

@end

@implementation JLCalendarWeeksView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor =JLColorWithHex(0xF3F3F3);
    
    CGFloat weekTitleHeight = CGRectGetHeight(self.frame);
    CGFloat eachWidth = CGRectGetWidth(self.frame) / 7.0;
    for (int i = 0; i < 7; i ++) {
        UILabel *weekTitleLabel = [[UILabel alloc] init];
        weekTitleLabel.frame = CGRectMake(i * eachWidth, 1, eachWidth, weekTitleHeight-2);
        weekTitleLabel.text = self.weekStrArray[i];
        weekTitleLabel.font = [UIFont systemFontOfSize:13];
        weekTitleLabel.textAlignment = NSTextAlignmentCenter;
        weekTitleLabel.textColor = JLColorWithHex(0x999999);
        [self addSubview:weekTitleLabel];
    }
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
    topLineView.backgroundColor = JLColorWithHex(0xD5D5D5);
    [self addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, weekTitleHeight - 1, CGRectGetWidth(self.frame), 1)];
    topLineView.backgroundColor = JLColorWithHex(0xD5D5D5);
    [self addSubview:bottomLineView];
}

- (NSArray *)weekStrArray {
    if (!_weekStrArray) {
        _weekStrArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    }
    return _weekStrArray;
}

@end

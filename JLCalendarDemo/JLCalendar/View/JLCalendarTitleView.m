//
//  JLCalendarTitleView.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/29.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLCalendarTitleView.h"
#import "JLCalendarDefine.h"

@interface JLCalendarTitleView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeViewButton;

@end

@implementation JLCalendarTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    
    self.backgroundColor = JLColorWithHex(0xFFFFFF);
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-100)/2, 0, 100, CGRectGetHeight(self.frame))];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = JLColorWithHex(0x333333);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"选择日期";
    _titleLabel.layer.masksToBounds = YES;
    [self addSubview:_titleLabel];
    
    _closeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeViewButton.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) - 10, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    _closeViewButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_closeViewButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeViewButton setTitleColor:JLColorWithHex(0x999999) forState:UIControlStateNormal];
    [_closeViewButton addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeViewButton];
}


- (void)closeBtnClicked:(id)sender {
    if (self.clickCloseButton) {
        self.clickCloseButton();
    }
}

@end

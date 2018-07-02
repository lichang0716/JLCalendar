//
//  JLCalenderController.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLCalenderController.h"
#import "JLCalendarTitleView.h"
#import "JLCalendarWeeksView.h"
#import "JLCalendarDefine.h"
#import "JLCalenderCollectionView.h"
#import "JLCalenderDateManager.h"

@interface JLCalenderController ()

@property (nonatomic, strong) JLCalendarTitleView *titleView;
@property (nonatomic, strong) JLCalendarWeeksView *weeksTitleView;
@property (nonatomic, strong) JLCalenderCollectionView *dateCollectionView;

@property (nonatomic, strong) JLCalenderDateManager *dateManager;

@end

@implementation JLCalenderController

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews {
    WeakObj(self);
    _titleView = [[JLCalendarTitleView alloc] initWithFrame:CGRectMake(0, JLScreenHeight - 450, JLScreenWidth, 55)];
    [_titleView setClickCloseButton:^{
        [selfWeak closeAction];
    }];
    [self.view addSubview:_titleView];
    
    _weeksTitleView = [[JLCalendarWeeksView alloc] initWithFrame:CGRectMake(0, JLScreenHeight - 450 + 55, JLScreenWidth, 30)];
    [self.view addSubview:_weeksTitleView];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemWidth = JLScreenWidth / 7.0;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    _dateCollectionView = [[JLCalenderCollectionView alloc] initWithFrame:CGRectMake(0, JLScreenHeight - 450 + 55 + 30, JLScreenWidth, 365) collectionViewLayout:layout];
    [self.view addSubview:_dateCollectionView];
    
    _dateManager = [JLCalenderDateManager sharedManager];
    _dateManager.shownStartDayStr = self.matchStartDateStr;
    _dateManager.shownStopDayStr = self.matchStopDateStr;
    _dateManager.selectedSicneToday = YES;
    _dateManager.disabledDaysArr = self.datesArrWithoutMatch;
    _dateManager.imageAndDateDic = @{@"2018-07-15":@"finalCorner"};
    [_dateManager getCalenderDateComplete:^(NSMutableArray *monthModelArray) {
        if (self.dateCollectionView) {
            self.dateCollectionView.monthDateArray = monthModelArray;
        }
    }];
    
    _dateManager.finishSelect = ^(JLCalendarDayModel *firstSelectDayModel, JLCalendarDayModel *secondSelectDayModel) {
        if (selfWeak.closeBlock) {
            selfWeak.closeBlock(firstSelectDayModel, secondSelectDayModel);
        }
        [selfWeak closeAction];
    };
    
    _dateManager.selectedFail = ^(JLSelectedFailReason selectedFailReason) {
        NSString *failReason = @"";
        if (selectedFailReason == JLSelectedFailReasonDateDisable ||
            selectedFailReason == JLSelectedFailReasonIncludeDateDisable) {
            failReason = @"当前日期不可选";
        } else if (selectedFailReason == JLSelectedFailReasonDaysCountTooSmall) {
            failReason = @"当前选择小于最小区域范围";
        } else if (selectedFailReason == JLSelectedFailReasonDaysCountTooBig) {
            failReason = @"当前选择大于最大区域范围";
        }
        
        // 这里直接进行提示
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self closeAction];
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

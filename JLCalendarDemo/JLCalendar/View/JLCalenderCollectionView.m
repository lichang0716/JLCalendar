//
//  JLCalenderCollectionView.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/28.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "JLCalenderCollectionView.h"
#import "JLCalendarDefine.h"
#import "JLCalenderDateManager.h"
#import "JLCalendarDayModel.h"
#import "JLMonthTitleCollectionViewCell.h"
#import "JLCalendarCollectionViewCell.h"

@interface JLCalenderCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) JLCalenderDateManager *dateManager;

@property (nonatomic, strong) JLCalendarDayModel *selectFirstDay;
@property (nonatomic, strong) JLCalendarDayModel *selectSecondDay;

@property (nonatomic, strong) NSMutableArray *reloadIndexPathArray;
@property (nonatomic, strong) NSMutableArray *includedDayModelArray;

@end

@implementation JLCalenderCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.backgroundColor = JLColorWithHex(0xFFFFFF);
    self.layer.masksToBounds = YES;
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[JLMonthTitleCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JLMonthTitleCollectionViewCell"];
    [self registerClass:[JLCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"JLCalendarCollectionViewCell"];
    
    _dateManager = [JLCalenderDateManager sharedManager];
    
    _reloadIndexPathArray = [NSMutableArray array];
    _includedDayModelArray = [NSMutableArray array];
}

- (void)setMonthDateArray:(NSArray *)monthDateArray {
    if (!monthDateArray) {
        return;
    }
    _monthDateArray = monthDateArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView performWithoutAnimation:^{
            [self reloadData];
        }];
    });
}

#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _monthDateArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    JLCalenderMonthModel *monthModel = _monthDateArray[section];
    NSInteger firstDayModelWeek = [monthModel.dayModelArray[0] week];
    return monthModel.dayModelArray.count + firstDayModelWeek;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JLCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JLCalendarCollectionViewCell" forIndexPath:indexPath];
    JLCalenderMonthModel *monthModel = _monthDateArray[indexPath.section];
    NSInteger firstDayModelWeek = [monthModel.dayModelArray[0] week];
    NSInteger index = indexPath.item - firstDayModelWeek;
    
    if (index < 0) {
        cell.dayModel = nil;
    } else {
        JLCalendarDayModel *dayModel = monthModel.dayModelArray[indexPath.row - firstDayModelWeek];
        dayModel.indexPath = indexPath;
        cell.dayModel = dayModel;
    }
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(JLScreenWidth/7.0, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(JLScreenWidth, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    JLMonthTitleCollectionViewCell *cell = (JLMonthTitleCollectionViewCell *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JLMonthTitleCollectionViewCell" forIndexPath:indexPath];
    JLCalenderMonthModel *monthModel = _monthDateArray[indexPath.section];
    cell.monthTitle = [NSString stringWithFormat:@"%ld年%ld月", monthModel.year, monthModel.month];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JLCalenderMonthModel *monthModel = _monthDateArray[indexPath.section];
    NSInteger firstDayModelWeek = [monthModel.dayModelArray[0] week];
    NSInteger index = indexPath.item - firstDayModelWeek;
    
    if (index < 0) {
        return;
    } else {
        JLCalendarDayModel *dayModel = monthModel.dayModelArray[indexPath.row - firstDayModelWeek];
        [self selectDayModel:dayModel];
    }
}

- (void)selectDayModel:(JLCalendarDayModel *)dayModel {
    if (!dayModel.indexPath) return;
    [_reloadIndexPathArray addObject:dayModel.indexPath];
    // 根据是否允许多选，分别针对各种情况进行判断
    if (_dateManager.isMutibleEnable) {
        
    } else {
        if (dayModel.selectable) {
            if ([_selectFirstDay isEqual:dayModel]) {
                // 如果当前选择的第一天，和此时点击的一样
                
            } else {
                if (_selectFirstDay) {
                    [_reloadIndexPathArray addObject:_selectFirstDay.indexPath];
                    self.selectFirstDay = nil;
                }
                self.selectFirstDay = dayModel;
            }
        } else {
            if (_dateManager.selectedFail) {
                _dateManager.selectedFail(JLSelectedFailReasonDateDisable);
            }
        }
        [self reloadItemsAtIndexPaths:_reloadIndexPathArray];
    }
    
    [_reloadIndexPathArray removeAllObjects];
}

- (void)setSelectFirstDay:(JLCalendarDayModel *)selectFirstDay {
    //传值之前把上一个dayModel属性还原
    _selectFirstDay.selectMode = JLCalendarSelectedModeNone;
    
    _selectFirstDay = selectFirstDay;
    _selectFirstDay.selectMode = JLCalendarSelectedModeFirst;
    
    //在单选模式中 选择了一个日期直接回调
    if (selectFirstDay && !_dateManager.mutibleEnable && _dateManager.finishSelect) {
        _dateManager.finishSelect(selectFirstDay, selectFirstDay);
    }
    
    if (!selectFirstDay) {
        _dateManager.finishSelect(nil, nil);
    }
}


@end

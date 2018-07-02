//
//  ViewController.m
//  JLCalendarDemo
//
//  Created by Chang Li on 2018/6/27.
//  Copyright © 2018年 pwnlc. All rights reserved.
//

#import "ViewController.h"
#import "JLCalenderController.h"
#import "JLDateAndString.h"
#import "JLCalendarDayModel.h"
#import "JLCalendarDefine.h"

@interface ViewController ()

@property (nonatomic, strong) JLCalendarDayModel *startDayModel;
@property (nonatomic, strong) JLCalendarDayModel *stopDayModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectDate:(id)sender {
    JLCalenderController *controller = [[JLCalenderController alloc] init];
    
    controller.matchStartDateStr = @"2018-06-14";
    controller.matchStopDateStr = @"2018-07-15";
    controller.datesArrWithoutMatch = @[@"2018-07-05", @"2018-07-09", @"2018-07-10", @"2018-07-13"];
    controller.todayTime = [JLDateAndString stringFromDate:[NSDate date]];
    WeakObj(self);
    controller.closeBlock = ^(JLCalendarDayModel *startModel, JLCalendarDayModel *stopModel) {
        
        selfWeak.startDayModel = startModel;
        selfWeak.stopDayModel = stopModel;
        NSString *resultTip = [NSString stringWithFormat:@"%@", [JLDateAndString stringFromDate:startModel.date]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Result" message:resultTip delegate:selfWeak cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)showResult:(NSString *)result {
    
}


@end

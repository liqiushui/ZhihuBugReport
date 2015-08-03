//
//  ViewController.m
//  BugReport
//
//  Created by vousaimer on 15-7-25.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "ViewController.h"
#import "BRDrawView.h"
#import "BRNavigationBar.h"
#import "BRBugReportView.h"
#import "BRBugReportEngine.h"

@interface ViewController ()<BRBugReportViewDelegate>

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    BRDrawView *draw = [[BRDrawView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
//    [self.view addSubview:draw];
//    

//    
//
//    BRNavigationBar *bar = [[BRNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    
    BRBugReportView *bugView = [[BRBugReportView alloc] initWithFrame:self.view.bounds];
    UIImage *img = [UIImage imageNamed:@"bug.jpg" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    [bugView setBugImage:img];
    bugView.delegate = self;
    [self.view addSubview:bugView];
}


- (void)BugReportSource:(BRBugReportView *)reportView
    didClickSendWithMsg:(NSString *)descriptionMsg
              withImage:(UIImage *)markBugImg
{
    [[BRBugReportEngine getInstance] sendBug:@{@"image":markBugImg, @"msg":descriptionMsg}];
}


- (void)BugReportSourceClickCancel:(BRBugReportView *)reportView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

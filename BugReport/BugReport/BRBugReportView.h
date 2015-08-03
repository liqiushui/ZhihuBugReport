//
//  BRBugReportView.h
//  BugReport
//
//  Created by vousaimer on 15-7-26.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRNavigationBar.h"
#import "BRDrawView.h"


@class BRBugReportView;

@protocol BRBugReportViewDelegate <NSObject>

- (void)BugReportSource:(BRBugReportView *)reportView
    didClickSendWithMsg:(NSString *)descriptionMsg
              withImage:(UIImage *)markBugImg;


- (void)BugReportSourceClickCancel:(BRBugReportView *)reportView;



@end




@interface BRBugReportView : UIView

@property (nonatomic, weak) id<BRBugReportViewDelegate> delegate;

- (void)setBugImage:(UIImage *)bugImage;

@end

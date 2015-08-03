//
//  BRDrawView.h
//  BugReport
//
//  Created by vousaimer on 15-7-25.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BRDrawView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign, readonly) BOOL isDrawing;

@property (nonatomic, strong) UIImage *bugImage;


- (void)undo;

//编辑之后的图片
- (UIImage *)editedImage;

@end

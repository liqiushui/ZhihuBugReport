//
//  UIBezierPath+Color.m
//  BugReport
//
//  Created by vousaimer on 15-7-25.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "UIBezierPath+Color.h"
#import <objc/runtime.h>


#define KEY_UIBezierPath_COLOR  @"KEY_UIBezierPath_COLOR"


@implementation UIBezierPath (Color)


- (UIColor *)color
{
    return objc_getAssociatedObject(self, KEY_UIBezierPath_COLOR);
}


- (void)setColor:(UIColor *)color
{
    if(color)
    {
        objc_setAssociatedObject(self, KEY_UIBezierPath_COLOR,
                                 color,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end

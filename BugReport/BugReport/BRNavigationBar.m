//
//  BRNavigationBar.m
//  BugReport
//
//  Created by vousaimer on 15-7-26.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "BRNavigationBar.h"

@implementation BRNavigationBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"反馈bug"];
        [self setItems:@[item] animated:NO];
        
        item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                  style:UIBarButtonItemStyleDone target:self
                                                                 action:@selector(cancel:)];
        
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送"
                                                                  style:UIBarButtonItemStyleDone target:self
                                                                 action:@selector(send:)];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

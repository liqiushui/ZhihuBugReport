//
//  BRTabBar.m
//  BugReport
//
//  Created by vousaimer on 15-7-26.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "BRTabBar.h"

@implementation BRTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSMutableArray *itemArr = [[NSMutableArray alloc] init];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"画笔"
                                                           image:nil
                                                   selectedImage:nil];
        [itemArr addObject:item];
        
        item = [[UITabBarItem alloc] initWithTitle:@"描述"
                                             image:nil
                                     selectedImage:nil];
        [itemArr addObject:item];
        
        
        item = [[UITabBarItem alloc] initWithTitle:@"清除"
                                             image:nil
                                     selectedImage:nil];
        [itemArr addObject:item];
        
        [self setItems:itemArr animated:NO];
        
        
        NSDictionary *highlightAttriDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20.0], NSFontAttributeName, [UIColor blueColor], NSForegroundColorAttributeName,nil];
        NSDictionary *normalAttriDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20.0], NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName,nil];
        
        for (UITabBarItem *item in itemArr)
        {
            [item setTitlePositionAdjustment:UIOffsetMake(0, -10)];
            
            [item setTitleTextAttributes:normalAttriDic
                                forState:UIControlStateNormal];
            [item setTitleTextAttributes:highlightAttriDic
                                forState:UIControlStateHighlighted];
        }
        
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

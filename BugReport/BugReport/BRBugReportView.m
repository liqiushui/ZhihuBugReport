//
//  BRBugReportView.m
//  BugReport
//
//  Created by vousaimer on 15-7-26.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "BRBugReportView.h"
#import "BRTabBar.h"
#import "SZTextView.h"


@interface BRBugReportView ()<UITabBarDelegate>

@property (nonatomic, strong) BRDrawView *drawView;
@property (nonatomic, strong) BRNavigationBar *topBar;
@property (nonatomic, strong) BRTabBar *bottomBar;


@property (nonatomic, strong) SZTextView *szTextView;
@property (nonatomic, strong) UIView *backMaskView;

@property (nonatomic, strong) UITabBarItem *selectItem;

@end


@implementation BRBugReportView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addSubview:self.drawView];
        [self addSubview:self.szTextView];
        [self addSubview:self.topBar];
        [self addSubview:self.bottomBar];
        
        [self insertSubview:self.backMaskView belowSubview:self.szTextView];
        
        self.bottomBar.delegate = self;
        
    }
    return self;
}


- (void)dealloc
{
    [self.drawView removeObserver:self forKeyPath:@"isDrawing" context:nil];
}


- (BRDrawView *)drawView
{
    if(_drawView == nil)
    {
        _drawView = [[BRDrawView alloc] initWithFrame:self.bounds];
        _drawView.lineColor = [UIColor redColor];
        _drawView.lineWidth = 3.0;
        [_drawView addObserver:self
                    forKeyPath:@"isDrawing"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    }
    return _drawView;
}


- (BRNavigationBar *)topBar
{
    if(_topBar == nil)
    {
        _topBar = [[BRNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 64)];
        UINavigationItem *item = _topBar.items[0];
        item.leftBarButtonItem.target = self;
        item.leftBarButtonItem.action = @selector(cancel:);
        item.rightBarButtonItem.target = self;
        item.rightBarButtonItem.action = @selector(send:);
        
    }
    return _topBar;
}

- (BRTabBar *)bottomBar
{
    if(_bottomBar == nil)
    {
        _bottomBar = [[BRTabBar alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetHeight(self.bounds) - 50,
                                                                CGRectGetWidth(self.bounds),
                                                                50)];
        [_bottomBar setSelectedItem:_bottomBar.items[0]];
        
        self.selectItem = _bottomBar.items[0];
    }
    return _bottomBar;
}


- (SZTextView *)szTextView
{
    if(_szTextView == nil)
    {
        CGFloat padding = 15;
        CGFloat height = 200;
        _szTextView = [[SZTextView alloc] initWithFrame:CGRectMake(padding,
                                                                  CGRectGetHeight(self.topBar.bounds) - height,
                                                                  CGRectGetWidth(self.frame) - padding*2,
                                                                   height)];
        _szTextView.placeholder = @"在这里输入你的反馈";
        
        _szTextView.layer.cornerRadius = 3;
        _szTextView.clipsToBounds = YES;
        _szTextView.font = [UIFont systemFontOfSize:16];
        
        _backMaskView = [[UIView alloc] initWithFrame:self.bounds];
        _backMaskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _backMaskView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tap:)];
        [_backMaskView addGestureRecognizer:tap];
    }
    return _szTextView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"keypath = %@ , change = %@",keyPath , change);
    
    if([keyPath isEqualToString:@"isDrawing"])
    {
        BOOL isDrawing = [[change valueForKey:@"new"] boolValue];
        [self updateIsDrawing:isDrawing];
    }
}


- (void)updateIsDrawing:(BOOL)isDrawing
{
    [self.topBar setHidden:isDrawing];
    [self.bottomBar setHidden:isDrawing];
}


- (void)setBugImage:(UIImage *)bugImage
{
    self.drawView.bugImage = bugImage;
}


- (void)displayTextInput:(BOOL)shouldHidden
{
    if(!shouldHidden)
    {
        [self.szTextView becomeFirstResponder];
    }
    else
    {
        [self.szTextView resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGFloat height = CGRectGetHeight(self.szTextView.bounds);
                         CGFloat y = shouldHidden?CGRectGetHeight(self.topBar.bounds) - height/2:CGRectGetHeight(self.topBar.bounds) + height/2 + 10;
                         self.szTextView.center = CGPointMake(self.szTextView.center.x, y);
                         
                         self.backMaskView.alpha = shouldHidden?0:1;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    if([item.title isEqualToString:@"清除"])
    {
        [self.drawView undo];
        [tabBar performSelector:@selector(setSelectedItem:)
                     withObject:self.selectItem
                     afterDelay:0.25];
    }
    else if([item.title isEqualToString:@"描述"])
    {
        [self displayTextInput:NO];
    }
    
}

- (void)tap:(id)sender
{
    [self displayTextInput:YES];
    [self.bottomBar setSelectedItem:self.selectItem];
}


- (void)cancel:(id)sender
{
    if([self.delegate respondsToSelector:@selector(BugReportSourceClickCancel:)])
    {
        [self.delegate BugReportSourceClickCancel:self];
    }
}



- (void)send:(id)senderx
{
    if([self.delegate respondsToSelector:@selector(BugReportSource:didClickSendWithMsg:withImage:)])
    {
        [self.delegate BugReportSource:self
                   didClickSendWithMsg:self.szTextView.text
                             withImage:self.drawView.editedImage];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

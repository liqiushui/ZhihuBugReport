//
//  BRDrawView.m
//  BugReport
//
//  Created by vousaimer on 15-7-25.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "BRDrawView.h"
#import "UIBezierPath+Color.h"

@interface BRDrawView ()
{
    CGPoint _previousPoint1;
    CGPoint _previousPoint2;
    CGPoint _currentPoint;
}

@property (nonatomic, strong) NSMutableArray *markPathArr;
@property (nonatomic, strong) UIBezierPath *markPath;

@end

@implementation BRDrawView


- (instancetype)init
{
    if(self = [super init])
    {
        [self commocInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self commocInit];
    }
    return self;
}


- (void)commocInit
{
    
    _markPathArr = [[NSMutableArray alloc] init];
    
    _lineColor = [UIColor whiteColor];
    _lineWidth = 3.0;
    
    [self changePen];

}


- (void)changePen
{
    if(_markPath)
    {
        [_markPathArr addObject:_markPath];
    }
    _markPath = [UIBezierPath bezierPath];
    _markPath.lineWidth = self.lineWidth;
    _markPath.color = self.lineColor;
}


- (void)setLineColor:(UIColor *)lineColor
{
    if(![lineColor isEqual:_lineColor])
    {
        _lineColor = lineColor;
        [self changePen];
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if(!fabsf(_lineWidth - lineWidth) < 0.5)
    {
        _lineWidth = lineWidth;
        [self changePen];
    }
}

- (void)setBugImage:(UIImage *)bugImage
{
    _bugImage = bugImage;
}

- (void)undo
{
    if(self.markPathArr.count > 0)
        [self.markPathArr removeLastObject];
    [self setNeedsDisplay];
}

- (UIImage *)editedImage
{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_bugImage drawInRect:self.bounds];
    
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //历史绘制的历史
    for (UIBezierPath *path in _markPathArr) {
        [path.color setStroke];
        CGContextSetLineWidth(context, path.lineWidth);
        [path stroke];
    }
    
    //设置颜色
    CGContextSetLineWidth(context, self.markPath.lineWidth);
    [self.markPath.color setStroke];
    [self.markPath stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setValue:@(YES) forKey:@"isDrawing"];

    UITouch *touch = [touches anyObject];
    
    _previousPoint1 = [touch previousLocationInView:self];
    _previousPoint2 = [touch previousLocationInView:self];
    _currentPoint = [touch locationInView:self];
    
    [self touchesMoved:touches withEvent:event];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    _previousPoint1 = _previousPoint2;
    _previousPoint2 = [touch previousLocationInView:self];
    _currentPoint = [touch locationInView:self];
    
    CGPoint midPoint1 = CGPointMake((_previousPoint1.x + _previousPoint2.x)/2,
                                    (_previousPoint1.y + _previousPoint2.y)/2);
    CGPoint midPoint2 = CGPointMake((_currentPoint.x + _previousPoint2.x)/2,
                                    (_currentPoint.y + _previousPoint2.y)/2);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, midPoint1.x, midPoint1.y);
    CGPathAddQuadCurveToPoint(path, NULL, _previousPoint2.x, _previousPoint2.y, midPoint2.x, midPoint2.y);
    [self.markPath appendPath:[UIBezierPath bezierPathWithCGPath:path]];
    CGPathRelease(path);
    
    [self setNeedsDisplayInRect:self.bounds];
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changePen];
    [self setValue:@(NO) forKey:@"isDrawing"];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changePen];
    [self setValue:@(NO) forKey:@"isDrawing"];
}




- (void)drawRect:(CGRect)rect
{
    // Drawing code.
    [super drawRect:rect];
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_bugImage drawInRect:self.bounds];
    
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //历史绘制的历史
    for (UIBezierPath *path in _markPathArr) {
        [path.color setStroke];
        CGContextSetLineWidth(context, path.lineWidth);
        [path stroke];
    }
    
    //设置颜色
    CGContextSetLineWidth(context, self.markPath.lineWidth);
    [self.markPath.color setStroke];
    [self.markPath stroke];

    
}


@end

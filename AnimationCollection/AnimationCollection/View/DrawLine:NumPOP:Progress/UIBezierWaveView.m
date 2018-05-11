//
//  UIBezierWaveView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/4/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIBezierWaveView.h"

@implementation UIBezierWaveView{
    CAShapeLayer *_bezierLineLayer;

    
    CGFloat     _axisToViewPadding;
    CGFloat     _xAxisSpacing;
    CGFloat     _yAxisSpacing;

    
    NSArray     *_pointYArray;
    NSMutableArray  *_pointsArray;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSomthing];
    }
    return self;
}

-(void)initSomthing{
    
    self.backgroundColor = [UIColor clearColor];

    NSString *str = @"你好 我想";
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0 ; i<str.length; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _pointYArray = arr.mutableCopy;
    
//    _pointYArray = @[@(1), @(20), @(1), @(2),@(1), @(2), @(1), @(2), @(1), @(2), @(1),@(2)];
    _pointsArray = @[].mutableCopy;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [self drawBezierPath:rect];

}

- (void)drawBezierPath:(CGRect)rect{
    
    _axisToViewPadding = 0;
    _xAxisSpacing = 15;
    _yAxisSpacing = 0;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0 ; i<rect.size.width * 0.25 * 0.27; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _pointYArray = arr.mutableCopy;
    _pointsArray = @[].mutableCopy;

    [_pointYArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger objInter = 1;
        if ([obj respondsToSelector:@selector(integerValue)]) {
            objInter = [obj integerValue];
        }
        if ([obj respondsToSelector:@selector(integerValue)]) {
            objInter = [obj integerValue];
            NSUInteger count = _pointYArray.count - 2;
            if (objInter < 1) {
                objInter = 1;
            } else if (objInter > count) {
                objInter = count;
            }
        }

    CGPoint point = CGPointMake(_xAxisSpacing * idx + _axisToViewPadding + rect.origin.x, rect.origin.y);
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [_pointsArray addObject:value];
    }];
    NSValue *firstPointValue = [NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    [_pointsArray insertObject:firstPointValue atIndex:0];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(rect.size.width, rect.origin.y)];
    [_pointsArray addObject:endPointValue];
    /** 折线路径 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger count = _pointYArray.count - 1;
    for (NSInteger i = 0; i < count; i++) {
        CGPoint p1 = [[_pointsArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[_pointsArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[_pointsArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[_pointsArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [path moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path withRect:rect];
    }
    /** 将折线添加到折线图层上，并设置相关的属性 */
    _bezierLineLayer = [CAShapeLayer layer];
    _bezierLineLayer.path = path.CGPath;
    _bezierLineLayer.strokeColor = [UIColor redColor].CGColor;
    _bezierLineLayer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    _bezierLineLayer.lineWidth = 1;
    _bezierLineLayer.lineCap = kCALineCapRound;
    _bezierLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_bezierLineLayer];
}
- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path withRect:(CGRect)rect{
    CGFloat smooth_value =0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl2_x;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    
    
    
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    [path addCurveToPoint:CGPointMake(x2, rect.origin.y) controlPoint1:CGPointMake(ctrl1_x, rect.origin.y+_xAxisSpacing) controlPoint2:CGPointMake(ctrl2_x, rect.origin.y)];
}



@end

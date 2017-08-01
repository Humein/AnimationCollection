//
//  LineView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/13.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "LineView.h"
#import <POP/POP.h>
#import <SDAutoLayout/SDAutoLayout.h>
@interface LineView()
@property(nonatomic) CAShapeLayer *circleLayer;
@property(nonatomic) CAShapeLayer *circleBGLayer;
- (void)addCircleLayer:(CGRect)frame;
- (void)animateToStrokeEnd:(CGFloat)strokeEnd;
@end
@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCircleLayer:frame];
    }
    return self;
}

#pragma mark - Instance Methods

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}

#pragma mark - Property Setters

- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circleLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

#pragma mark - Private Instance methods

/**
 UIBezierPath和CAShapeLayer画各种图形 +pop 动画
 // 创建基本路径
 + (instancetype)bezierPath;
 // 创建矩形路径
 + (instancetype)bezierPathWithRect:(CGRect)rect;
 // 创建椭圆路径
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
 // 创建圆角矩形
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; // rounds all corners with the same horizontal and vertical radius
 // 创建指定位置圆角的矩形路径
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 // 创建弧线路径
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
 // 通过CGPath创建
 + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;
 */
- (void)addCircleLayer:(CGRect)frame
{
    CGFloat lineWidth = frame.size.height;
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    self.circleBGLayer = [CAShapeLayer layer];
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius * 2, radius * 2);
    
    
    
    
    
    
    // 1   创建指定位置圆角的矩形路径
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                      cornerRadius:radius].CGPath;
    self.circleBGLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
   

//    // 2  直线
//    
//    // 1. 初始化 (UIBezierPath) 路径
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    // 2. 添加起点 moveToPoint:(CGPoint)
//    [path moveToPoint:CGPointMake(0, 0)];
//    // 3. 添加经过点 addLineToPoint:(CGPoint)
//    [path addLineToPoint:CGPointMake(frame.size.width,0)];
//    self.circleLayer.path = path.CGPath;
//    
    

    
    
    self.circleLayer.strokeColor = self.tintColor.CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;
    
    self.circleBGLayer.strokeColor = [UIColor blackColor].CGColor;
    self.circleBGLayer.fillColor = nil;
    self.circleBGLayer.lineWidth = lineWidth;
    self.circleBGLayer.lineCap = kCALineCapRound;
    self.circleBGLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:self.circleBGLayer];
    [self.layer addSublayer:self.circleLayer];

}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
    
    if (strokeEnd >=1) {
        if (_valueBlcok) {
            _valueBlcok(strokeEnd);
        }
    }
}


@end

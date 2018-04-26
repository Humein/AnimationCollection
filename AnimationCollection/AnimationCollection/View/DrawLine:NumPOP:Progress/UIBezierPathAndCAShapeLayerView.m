//
//  UIBezierPathAndCAShapeLayerView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/4/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//
//1. UIBezierPath： UIBezierPath是在 UIKit 中的一个类，继承于NSObject,可以创建基于矢量的路径.此类是Core Graphics框架关于path的一个OC封装。使用此类可以定义常见的圆形、多边形等形状 。我们使用直线、弧（arc）来创建复杂的曲线形状。每一个直线段或者曲线段的结束的地方是下一个的开始的地方。每一个连接的直线或者曲线段的集合成为subpath。一个UIBezierPath对象定义一个完整的路径包括一个或者多个subpaths。
//2. CAShapeLayer： 继承于CALayer。 每个CAShapeLayer对象都代表着将要被渲染到屏幕上的一个任意的形状(shape)。具体的形状由其path(类型为CGPathRef)属性指定。 普通的CALayer是矩形，所以需要frame属性。CAShapeLayer它本身没有形状，它的形状来源于其属性path 。CAShapeLayer有不同于CALayer的属性，它从CALayer继承而来的属性在绘制时是不起作用的。

#import "UIBezierPathAndCAShapeLayerView.h"

@implementation UIBezierPathAndCAShapeLayerView
- (instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        [self test];

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    // Drawing code
}
-(void)test{
    self.backgroundColor = [UIColor grayColor];
    //设置画笔颜色 曲线
    [[UIColor redColor]set];
    
    //
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth =2;
    
    
    [path moveToPoint:CGPointMake(0, 310)];
    [path addCurveToPoint:CGPointMake(370, 310) controlPoint1:CGPointMake(0, 210) controlPoint2:CGPointMake(150, 410)];
    
    [path stroke];
    
    CAShapeLayer *circleBGLayer = [CAShapeLayer layer];
    circleBGLayer.path = path.CGPath;
    circleBGLayer.strokeColor = [UIColor blackColor].CGColor;
    circleBGLayer.fillColor = nil;
    circleBGLayer.lineWidth = path.lineWidth;
    circleBGLayer.lineCap = kCALineCapRound;
    circleBGLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:circleBGLayer];
    
    
}



@end

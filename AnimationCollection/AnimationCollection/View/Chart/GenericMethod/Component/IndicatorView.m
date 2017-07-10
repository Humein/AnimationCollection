//
//  IndicatorView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/7/6.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "IndicatorView.h"
#import "ZFConst.h"
@implementation IndicatorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

-(void)addIndicatorView:(NSString *)LineName withPointsStyle:(NSString *)pointsStyle withColorName:(UIColor *)colorName andIndex:(int)index{


//
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 30*(index+1))];
    [path addLineToPoint:CGPointMake(50,30*(index+1))];

    
    CAShapeLayer *LineLayer = [CAShapeLayer layer];
    LineLayer.fillColor = colorName.CGColor;
    LineLayer.strokeColor = colorName.CGColor;
    LineLayer.lineWidth = 2;
    LineLayer.lineCap = kCALineCapRound;
    LineLayer.lineJoin = kCALineJoinRound;
    LineLayer.path = path.CGPath;

    
    
//    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*(index+1)+7, 120, 12)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = colorName;
    label.text = pointsStyle;
    
   
//    
    UIBezierPath * bezierView;
    
    if ([pointsStyle isEqualToString:PointsCircle]) {
         bezierView = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 30*(index+1)-5, 10, 10)];

        
    }else if([pointsStyle isEqualToString:PointsSquare]){
         bezierView = [UIBezierPath bezierPathWithRect:CGRectMake(20, 30*(index+1)-5, 10, 10)];

    }

    CAShapeLayer *StyleLayer = [CAShapeLayer layer];
    StyleLayer.fillColor = colorName.CGColor;
    StyleLayer.strokeColor = colorName.CGColor;
    StyleLayer.path = bezierView.CGPath;
    
    
    [self.layer addSublayer:LineLayer];
    [self.layer addSublayer:StyleLayer];
    [self addSubview:label];
}
@end

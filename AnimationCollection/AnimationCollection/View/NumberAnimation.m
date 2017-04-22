//
//  NumberAnimation.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/21.
//  Copyright © 2017年 xinxin. All rights reserved.
//
#import "NumberAnimation.h"
#import "POPNumberAnimation.h"
@interface NumberAnimation ()<POPNumberAnimationDelegate>
{
//   转盘 跑马灯 抽奖
}
@property (nonatomic, strong) POPNumberAnimation *numberAnimation;
@property (nonatomic, strong) UILabel            *label;
@end
@implementation NumberAnimation
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView:frame];
    }
    return self;
}

-(void)makeView:(CGRect)frame{
//    self.backgroundColor = [UIColor redColor];
    _label               = [[UILabel alloc] initWithFrame:frame];
    _label.text = @"0";
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
    
    
    
    
    self.numberAnimation          = [[POPNumberAnimation alloc] init];
    self.numberAnimation.delegate = self;
    [self.numberAnimation stopAnimation];

}
#pragma mark - pop Delegate
- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
    
    NSString *numberString = [NSString stringWithFormat:@"%.1f", currentValue ];
    _label.textColor = [self numColorWithValue:currentValue / 100.f];
    _label.text = numberString;
 
}
#pragma mark - Private method
- (void)configNumberAnimation{
    
    self.numberAnimation.fromValue      = 0;
    self.numberAnimation.toValue        = 100;
    self.numberAnimation.duration       = 2.f;
    self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    [self.numberAnimation saveValues];
    [self.numberAnimation startAnimation];
    
}
- (UIColor *)numColorWithValue:(CGFloat)value {
    
    return [UIColor colorWithRed:value green:0 blue:0 alpha:1.f];
}

@end

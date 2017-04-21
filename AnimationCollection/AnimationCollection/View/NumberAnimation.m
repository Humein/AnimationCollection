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
  
}
@property (nonatomic, strong) POPNumberAnimation *numberAnimation;
@end
@implementation NumberAnimation
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
    }
    return self;
}

-(void)makeView{
    self.backgroundColor = [UIColor whiteColor];
    self.numberAnimation          = [[POPNumberAnimation alloc] init];
    self.numberAnimation.delegate = self;
    [self.numberAnimation stopAnimation];

}
#pragma mark - pop Delegate
- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
    
    NSString *numberString = [NSString stringWithFormat:@"%.f", currentValue ];

//    moduleView.ModuleScore.text = numberString;
 
}
#pragma mark - Private method
- (void)configNumberAnimation{
    
    self.numberAnimation.fromValue      = 0;
    self.numberAnimation.toValue        = 100;
    self.numberAnimation.duration       = 2.f;
    self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    [self.numberAnimation saveValues];
    
}

@end

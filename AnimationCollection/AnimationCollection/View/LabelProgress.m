//
//  LabelProgress.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/22.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "LabelProgress.h"
#import "UIView+Frame.h"
@interface LabelProgress()
@property (nonatomic, strong)  UIView   *upView;
@property (nonatomic, strong)  UILabel  *upLabel;
@property (nonatomic, strong)  UIView   *downView;
@property (nonatomic, strong)  UILabel  *downLabel;

@end
@implementation LabelProgress
/*
 给upView的frame值做动画才是label能够混色显示的核心
 
 upView(红色背景)   ===>  upLabel(白色底字)
 |                       |
 |                       |
 |                       |
 |                       |
 downView(白色背景) ===> downLabel(红色底字)
 
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView:frame];
    }
    return self;
}
-(void)makeView:(CGRect)frame{
        // 上面一层{
    {
    // 红色背景
    _upView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 17)];
    _upView.center              = self.middlePoint;
    _upView.layer.cornerRadius  = 2.f;
    _upView.backgroundColor     = [UIColor redColor];
    _upView.layer.masksToBounds = YES; // 核心(不让subview显示超出范围)
    [self addSubview:_upView];
    
    // 白色底字
    _upLabel                    = [[UILabel alloc] initWithFrame:_upView.bounds];
    _upLabel.font               = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
    _upLabel.text               = @"iOS Label Programmer";
    _upLabel.textColor          = [UIColor whiteColor];
    _upLabel.textAlignment      = NSTextAlignmentCenter;
    [_upView addSubview:_upLabel];
    }
    
    // 下面一层
    {
        // 白色背景
        _downView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 17)];
        _downView.center              = self.middlePoint;
        _downView.layer.cornerRadius  = 2.f;
        _downView.backgroundColor     = [UIColor whiteColor];
        [self addSubview:_downView];
        
        // 红色底字
        _downLabel                    = [[UILabel alloc] initWithFrame:_downView.bounds];
        _downLabel.textColor          = [UIColor redColor];
        _downLabel.font               = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
        _downLabel.text               = @"iOS Label Programmer";
        _downLabel.textAlignment = NSTextAlignmentCenter;
        [_downView addSubview:_downLabel];
        
        _downView.layer.borderWidth = 0.5f;
        _downView.layer.borderColor = [UIColor redColor].CGColor;
    }
    

    // 显示上面一层
    [self bringSubviewToFront:_upView];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action)
                                                userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
}
-(void)action{
    __weak typeof(self) weakSelf = self;
    NSLog(@"1");
    [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:3.f initialSpringVelocity:0 options:0 animations:^{
        
        weakSelf.upView.width = arc4random() % 220;

    } completion:nil];
}
- (CGPoint)middlePoint {
    
    return CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
}



@end

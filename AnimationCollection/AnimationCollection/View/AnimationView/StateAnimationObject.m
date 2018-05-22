//
//  StateAnimationObject.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "StateAnimationObject.h"
#import <POP.h>
@interface StateAnimationObject()<UIGestureRecognizerDelegate,POPAnimationDelegate>{
    CGRect _frame;
    NSDictionary *_infoDic;
}
// 内容容器
@property (nonatomic,strong) UIView *contentView;
// 展示容器
@property (nonatomic,strong) UIView *containerView;
@end

@implementation StateAnimationObject
-(instancetype)initWithFrame:(CGRect)frame bringTheinfo:(NSDictionary *)infoDic{
    self = [super init];
    if(self)
    {
        _frame = frame.size.height ?  frame : CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 44);
        _infoDic = infoDic ? [infoDic copy] : @{@"messsage":@"nihao",@"goldScore":@"520"};
        
        [self addSubviews];
    }
    return self;
    
}


-(void)addSubviews{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *containerView = [[UIView alloc] initWithFrame:keyWindow.frame];
    containerView.userInteractionEnabled = NO;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewClick)];
//    tap.delegate = self;
//    [containerView addGestureRecognizer:tap];
    containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    
    
    _contentView = [[UIView alloc] initWithFrame:_frame];
    _contentView.backgroundColor =  [UIColor yellowColor];
    
    
    
    
    UILabel * noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, keyWindow.frame.size.width, 44)];
    noteLabel.text = [NSString stringWithFormat:@"任务完成,获得%@金币和%@成长值",_infoDic[@"messsage"],_infoDic[@"goldScore"]];
    noteLabel.textColor = [UIColor whiteColor];
    noteLabel.font = [UIFont systemFontOfSize:15];
    noteLabel.backgroundColor = [UIColor redColor];
    noteLabel.numberOfLines = 0;
    noteLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:noteLabel];
    //    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(_contentView);
    //    }];
    
    
    
    
    [containerView addSubview:_contentView];

    


    
   
    self.containerView = containerView;

}



#pragma mark ---PrivateMethod

- (void)containerViewClick {
    [self dismiss];
}


- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.containerView];
    [keyWindow bringSubviewToFront:self.containerView];
    
    
    POPBasicAnimation *animPosition= [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animPosition.toValue = @(_contentView.center.y+_frame.size.height);
    animPosition.duration = 0.3f;
    animPosition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    POPBasicAnimation *animPositionOut= [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animPositionOut.toValue = @(_contentView.center.y-_frame.size.height);
    animPositionOut.duration = 0.5f;
    animPositionOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animPositionOut.delegate = self;
    
    [_contentView pop_addAnimation:animPosition forKey:@"position"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_contentView pop_addAnimation:animPositionOut forKey:@"position"];

    });
    
    
}


- (void)pop_animationDidStart:(POPAnimation *)anim
{
//    NSLog(@"动画开始时候调用");
}

- (void)pop_animationDidReachToValue:(POPAnimation *)anim
{
//    NSLog(@"将要达到toValue值是调用");
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
//    NSLog(@"动画完成时调用");
    [self dismiss];
}

- (void)pop_animationDidApply:(POPAnimation *)anim
{
//    NSLog(@"动画执行过程中一直调用");
}


- (void)dismiss {
    [_contentView pop_removeAllAnimations];
    [self.containerView removeFromSuperview];
    // [self removeFromSuperview];
}

- (void)dealloc
{
    [self dismiss];
    NSLog(@"----此无法内部---销毁");
}
@end

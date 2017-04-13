//
//  ViewController.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/13.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
@interface ViewController ()
{
    CGFloat _i;
}
@property(nonatomic) LineView *circleView;
- (void)addCircleView;
- (void)addSlider;
- (void)sliderChanged:(UISlider *)slider;
@property (nonatomic, strong) NSTimer  *timer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCircleView];
    [self addSlider];
    [self addButtonAction];
}

#pragma mark - Private Instance methods

- (void)addCircleView
{
    CGRect frame = CGRectMake(0.f, 0.f, 200.f, 200.f);
    self.circleView = [[LineView alloc] initWithFrame:frame];
    self.circleView.strokeColor = [UIColor brownColor];
    self.circleView.center = self.view.center;
    
    [self.view addSubview:self.circleView];
}

- (void)addSlider
{
    UISlider *slider = [UISlider new];
    slider.value = 0.1f;
    slider.tintColor = [UIColor brownColor];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    NSDictionary *views = NSDictionaryOfVariableBindings(slider, _circleView);
    
    
    //    自动布局
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_circleView]-(40)-[slider]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[slider]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.circleView setStrokeEnd:slider.value animated:NO];
}

-(void)addButtonAction{
    UIButton *sh = [[UIButton alloc]initWithFrame:CGRectMake(60, 100, 40, 40)];
    sh.backgroundColor = [UIColor redColor];
    [self.view addSubview:sh];
    [sh addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
}

-(void)change{
    
    //     [self.circleView setStrokeEnd:100 animated:YES];
    
    //    __weak typeof(self) weakSelf = self;
    _i = 0.01f;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action)
                                            userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
-(void)action{
    //    UIView animateWithDuration:(NSTimeInterval) animations:<#^(void)animations#>
    NSLog(@"1");
    _i = _i + 0.01f;
    [self.circleView setStrokeEnd:_i animated:YES];
}

- (void)sliderChanged:(UISlider *)slider
{
    [self.circleView setStrokeEnd:slider.value animated:YES];
}
-(void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

@end

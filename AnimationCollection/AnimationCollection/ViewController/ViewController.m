//
//  ViewController.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/13.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
#import "ModalViewController.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "NumberAnimation.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
    CGFloat _i;
}
@property(nonatomic,strong) LineView *circleView;
@property(nonatomic,strong) NumberAnimation *NumberView;
- (void)addCircleView;
- (void)addSlider;
- (void)sliderChanged:(UISlider *)slider;
@property (nonatomic, strong) NSTimer  *timer;
@end

@implementation ViewController
#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCircleView];
    [self addSlider];
    [self addChangeProgressButtonAction];
    [self addModalButtonAction];
    [self POPNumberAnimation];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [_timer invalidate];
    _timer = nil;
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator initWithWidth:0];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}
#pragma mark - Private Instance methods

- (void)addCircleView
{
    CGRect frame = CGRectMake(0.f, 0.f, 300.f, 10.f);
    self.circleView = [[LineView alloc] initWithFrame:frame];
    self.circleView.strokeColor = [UIColor brownColor];
    self.circleView.center = self.view.center;
    [self.view addSubview:self.circleView];
    self.circleView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 100)
    .leftSpaceToView(self.view, 10)
    .widthIs(300)
    .heightIs(10);
}

- (void)addSlider
{
    UISlider *slider = [UISlider new];
    slider.value = 0.1f;
    slider.tintColor = [UIColor brownColor];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    slider.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view, 100)
    .widthIs(200)
    .heightIs(10);
    
    [self.circleView setStrokeEnd:slider.value animated:NO];
}


-(void)addChangeProgressButtonAction{
    UIButton *sh = [[UIButton alloc]initWithFrame:CGRectMake(60, 100, 40, 40)];
    sh.backgroundColor = [UIColor redColor];
    sh.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    [sh setTitle:@"Progress" forState:UIControlStateNormal];
    [sh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sh];
    sh.sd_layout
    .topSpaceToView(self.circleView, 100)
    .leftSpaceToView(self.view, 20)
    .widthIs(40)
    .heightIs(40);
    [sh addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
}
-(void)addModalButtonAction{
//    CGRect frame = CGRectMake(0.f, 0.f, 60.f, 30.f);
    UIButton *sh = [[UIButton alloc]initWithFrame:CGRectMake(60, 100, 40, 40)];
    sh.backgroundColor = [UIColor grayColor];
    sh.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    [sh setTitle:@"modal" forState:UIControlStateNormal];
    [self.view addSubview:sh];
    sh.sd_layout
    .topSpaceToView(self.circleView, 100)
    .leftSpaceToView(self.view, 80)
    .widthIs(40)
    .heightIs(40);
    [sh addTarget:self action:@selector(modal:) forControlEvents:UIControlEventTouchDown];
}


-(void)POPNumberAnimation{
    CGRect frame = CGRectMake(0.f, 0.f, 60.f, 30.f);
    self.NumberView = [[NumberAnimation alloc]initWithFrame:frame];
    self.NumberView.backgroundColor = [UIColor whiteColor];
    [self.NumberView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNumber:)]];
    [self.view addSubview:self.NumberView];
    self.NumberView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.circleView, 100)
    .widthIs(frame.size.width)
    .heightIs(frame.size.height);
}

#pragma mark -Action
-(void)change{
    
    //     [self.circleView setStrokeEnd:100 animated:YES];
    
    //    __weak typeof(self) weakSelf = self;
    _i = 0.01f;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action)
                                            userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    

    
}
-(void)modal:(id)sender{
    ModalViewController *modalViewController = [[ModalViewController alloc]init];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
//    [self.navigationController pushViewController:modalViewController animated:YES];
    [self.navigationController presentViewController:modalViewController
                                            animated:YES
                                          completion:NULL];
}
-(void)action{
    //    UIView animateWithDuration:(NSTimeInterval) animations:<#^(void)animations#>
    NSLog(@"1");
    _i = _i + 0.1f;
    [self.circleView setStrokeEnd:_i animated:YES];
}

-(void)clickNumber:(UITapGestureRecognizer *)gestureRecognizer{
    UIView *viewClicked=[gestureRecognizer view];
    //    DLog(@"viewClicked===%ld",(long)viewClicked.tag);
    [self.NumberView configNumberAnimation];
   
}

- (void)sliderChanged:(UISlider *)slider
{
    [_timer setFireDate:[NSDate distantFuture]];
    [self.circleView setStrokeEnd:slider.value animated:YES];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_timer setFireDate:[NSDate date]];
}
-(void)dealloc
{
//    [_timer invalidate];
//    _timer = nil;
}

@end

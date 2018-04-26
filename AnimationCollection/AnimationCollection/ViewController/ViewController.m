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
#import "PopViewController.h"
#import "AnimationViewController.h"
#import <POP/POP.h>
#import "UIBezierPathAndCAShapeLayerView.h"
#import "UIBezierWaveView.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate,UIPopoverPresentationControllerDelegate>
{
    CGFloat _i;
}
@property(nonatomic,strong) LineView *circleView;
@property(nonatomic,strong) NumberAnimation *NumberView;
@property (nonatomic, strong) PopViewController *itemPopVC;

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
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(popView)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    
    
    [self addCircleView];
    [self addSlider];
    [self addChangeProgressButtonAction];
    [self addModalButtonAction];
    [self POPNumberAnimation];
    [self underLineDraw];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self popView];
}

-(void)popView{
    AnimationViewController *VC = [AnimationViewController new];
    
    [self.navigationController pushViewController:VC animated:YES];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator initWithWidth:22];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}
#pragma mark - Private Instance methods

- (void)addCircleView
{
    CGRect frame = CGRectMake(0.f, 0.f, 30.f, 2.f);
    self.circleView = [[LineView alloc] initWithFrame:frame];
    self.circleView.strokeColor = [UIColor redColor];
    self.circleView.center = self.view.center;

    [self.view addSubview:self.circleView];
    self.circleView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 100)
    .leftSpaceToView(self.view, 10)
    .widthIs(30)
    .heightIs(2);

    
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
    __weak typeof(self) weakSelf = self;
    self.circleView.valueBlcok = ^(CGFloat value) {
        if (value) {
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
        }
    };
    
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
    self.NumberView.tag = 0;
    [self.view addSubview:self.NumberView];
    self.NumberView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.circleView, 100)
    .widthIs(frame.size.width)
    .heightIs(frame.size.height);
    
}

-(void)underLineDraw{

    UIBezierWaveView *BS = [[UIBezierWaveView alloc]initWithFrame:CGRectMake(0, 264, 200, 60)];
    [self.view addSubview:BS];
    

}

#pragma mark -Action
-(void)change{
    
    //     [self.circleView setStrokeEnd:100 animated:YES];
    
    //    __weak typeof(self) weakSelf = self;
    _i = 0.01f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action)
                                            userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    

    
}
-(void)modal:(id)sender{
    ModalViewController *modalViewController = [[ModalViewController alloc]init];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController presentViewController:modalViewController
                                            animated:YES
                                          completion:NULL];
}
-(void)action{
    //    UIView animateWithDuration:(NSTimeInterval) animations:<#^(void)animations#>
    NSLog(@"1");
    _i = _i + 0.1f;
    [self.circleView setStrokeEnd:_i animated:YES];
    
    
//    UIPopoverPresentationController
    
 
    
}
-(void)popOver{
    //初始化 VC
    self.itemPopVC = [[PopViewController alloc] init];
    // 设置大小
//    self.itemPopVC.preferredContentSize = CGSizeMake(50, 30);
    // 设置 Sytle
    self.itemPopVC.modalPresentationStyle = UIModalPresentationPopover;
    //可以指示小箭头颜色
    self.itemPopVC.popoverPresentationController.backgroundColor = [UIColor grayColor];
    //设置依附的按钮
//    self.itemPopVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    // 需要通过 sourceView 来判断位置的
    self.itemPopVC.popoverPresentationController.sourceView = self.NumberView;
    // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
    // 这个可以 通过 Point 或  Size 调试位置
    self.itemPopVC.popoverPresentationController.sourceRect = self.NumberView.bounds;
    // 箭头方向
    self.itemPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    // 设置代理
    self.itemPopVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.itemPopVC animated:YES completion:nil];
  

    //content尺寸
    self.itemPopVC.preferredContentSize = CGSizeMake(400, 400);
}

#pragma mark popOverDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone; //不适配
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;   //点击蒙版popover消失， 默认YES
}




-(void)clickNumber:(UITapGestureRecognizer *)gestureRecognizer{
    UIView *viewClicked=[gestureRecognizer view];
    NSLog(@"viewClicked===%ld",(long)viewClicked.tag);
    [self popOver];
    [self.NumberView configNumberAnimation];
   
}

- (void)sliderChanged:(UISlider *)slider
{
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.circleView setStrokeEnd:slider.value animated:YES];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.timer setFireDate:[NSDate date]];
}
-(void)dealloc
{
//    [_timer invalidate];
//    _timer = nil;
}

@end

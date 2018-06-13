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
#import "RadarChartViewController.h"
#import "PopTableView.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate,UIPopoverPresentationControllerDelegate,PopViewControllerDelegate,MatchesSwitchMdoelCellDelegate>
{
    CGFloat _i;
}
@property(nonatomic,strong) LineView *circleView;
@property(nonatomic,strong) NumberAnimation *NumberView;
@property (nonatomic, strong) PopViewController *itemPopVC;
@property (nonatomic, strong) UITextView *textLabel;

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
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self popView];
}

-(void)popView{
    
    [self popOver];
    return;
    

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
    return [PresentingAnimator initWithWidth:0];
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

    self.textLabel  = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 500)];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.scrollEnabled = NO;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.text = @"文字文字文字文字文字文字文字文字文字文字";
    [self.view addSubview:self.textLabel];

    
    UIBezierWaveView *BS1 = [[UIBezierWaveView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    CGRect rect1 = CGRectMake(0, 0 + 30, self.textLabel.text.length * 10, 5);
//    CGRect rect2 = CGRectMake(100, 170, self.view.frame.size.width*0.5, 5);
//    CGRect rect3 = CGRectMake(0, 180, self.view.frame.size.width*0.5, 5);
//    CGRect rect4 = CGRectMake(180, 190, self.view.frame.size.width*0.25, 5);
//    CGRect rect5 = CGRectMake(180, 200, self.view.frame.size.width*0.25, 5);
//    CGRect rect6 = CGRectMake(180, 210, self.view.frame.size.width*0.25-50, 5);
//    CGRect rect7 = CGRectMake(180, 220, self.view.frame.size.width*0.25, 5);
//    CGRect rect8 = CGRectMake(180, 230, self.view.frame.size.width*0.25, 5);
//    CGRect rect9 = CGRectMake(180, 240, self.view.frame.size.width*0.25+20, 5);
    
    
    
    NSMutableArray *rectArray = [NSMutableArray arrayWithObjects:[NSValue valueWithCGRect:rect1], nil];
   
        
    for (NSValue *rect in rectArray){
        
        [BS1 drawBezierPath:[rect CGRectValue]];
    }
    
    

    [self.textLabel addSubview:BS1];

//使用drowRect绘制简单图形
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置绘制地区的颜色
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    //设置绘制的位置和大小
    CGContextFillRect(context, CGRectMake(0, 100, 100, 100));
    NSString * text=@"文字";
    UIFont * font=[UIFont systemFontOfSize:14];
    //设置文字的位置
    [text drawAtPoint:CGPointMake(0, 200) withAttributes:font.fontDescriptor.fontAttributes];
    UIImage * img=[UIImage imageNamed:@"pen"];
    [img drawInRect:CGRectMake(0, 300, 100, 100)];
    

    


}


//- (void)doSomething {
//    NSMutableArray *collection = @[].mutableCopy;
//    for (int i = 0; i < 10e6; ++i) {
//        @autoreleasepool {
//            NSString *str = [NSString stringWithFormat:@"hi + %d", i];
//            [collection addObject:str];
//        }
//    }
//    NSLog(@"finished!");
//}

//- (void)doSomething {
//    int count = 0;
//    NSMutableArray *collection = @[].mutableCopy;
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//    for (int i = 0; i < 10e6; ++i) {
//        NSString *str = [NSString stringWithFormat:@"hi + %d", i];
//        [collection addObject:str];
//        if (++count == 100) {
//            /** 每一百次倾倒一次池子 */
//            [pool drain];
//            count = 0;
//        }
//    }
//    /** 用来倾倒当i的个数不是100的倍数时，比如读取数据库数据时,数据总数为不确定值 */
//    [pool drain];
//    NSLog(@"finished!");
//}

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

     NSArray *arr = @[@"1",@"2",@"3",@"1",@"2",@"3"];
     PopTableView *pooView = [[PopTableView alloc]initWithFrame:CGRectMake(80,64, 258*0.5, arr.count * 30+20) dataSource:arr withBGView:@"弹窗"];
      pooView.delegate = self;
     [pooView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [pooView dismiss];
    });
    
    
    
}

#pragma mark popOverDelegate

-(void)cellClick:(MatchesSwitchMdoel *)viewModel{
    RadarChartViewController *radarChartView = [RadarChartViewController new];
    AnimationViewController *VC = [AnimationViewController new];

    NSString *stTmp = [NSString stringWithFormat:@"%@",viewModel];
    NSInteger state = [stTmp integerValue];
    switch (state) {
        case 1:
            [self.navigationController pushViewController:radarChartView animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:VC animated:YES];
            break;
        case 3:
            [self underLineDraw];

//            [self modal:nil];
            break;
      
        default:
            break;
    }

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

//
//  AnimationViewController.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/6/27.
//  Copyright © 2017年 xinxin. All rights reserved.
//



/*
 •速度控制函数(CAMediaTimingFunction)
 1.kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
 2.kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
 3.kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
 4.kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
 */


/*
 POPSpringAnimation可配置的属性与默认值为
 springBounciness:4.0    //[0-20] 弹力 越大则震动幅度越大
 springSpeed     :12.0   //[0-20] 速度 越大则动画结束越快
 dynamicsTension :0      //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
 dynamicsFriction:0      //摩擦 同上
 dynamicsMass    :0      //质量 同上
 */


#define Weak_Self __weak typeof(self) weakSelf = self

#import "AnimationViewController.h"
#import <POP.h>
#import "ZFChart.h"
#import "CombobaseView.h"
#import "StateAnimationObject.h"

@interface AnimationViewController ()<ZFGenericChartDataSource, ZFLineChartDelegate>
@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *POPBasicView;
@property(nonatomic,strong)UIView *POPSpringView;
@property(nonatomic,strong)UIView *POPDecayView;
@property(nonatomic,strong)UILabel *NUMLabel;

@property(nonatomic,strong)UIButton *imageBtn;
@property(nonatomic,strong)UIView *btnBackView;
@property (nonatomic, strong)StateAnimationObject *stateView;

@property (nonatomic, strong) ZFLineChart * lineChart;
@end


@implementation AnimationViewController
-(UILabel *)NUMLabel{
    if (!_NUMLabel) {
        _NUMLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 44)];
    }
    return _NUMLabel;
}

-(UIView *)BGView{
    if (!_BGView) {
       _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];

       _BGView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1];
     
        
        
//Basic animations can be used to interpolate values over a specified time period. To use an ease-in ease-out animation to animate a view's alpha from 0.0 to 1.0 over the default duration:
        {
        
//        {
//
//        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//        anim.fromValue = @(0.0);
//        anim.toValue = @(0.5);
//        [_BGView pop_addAnimation:anim forKey:@"fade"];
//            
//        }
//        
        //Spring animations can be used to give objects a delightful bounce. In this example, we use a spring animation to animate a layer's bounds from its current value to (0, 0, 400, 400):
        
        
//        {
//            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//            anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 400, 400)];
//            [_BGView.layer pop_addAnimation:anim forKey:@"size"];
//        }
//        
//        
        //Decay animations can be used to gradually slow an object to a halt. In this example, we decay a layer's positionX from it's current value and velocity 1000pts per second:
        
//        {
//            POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//            anim.velocity = @(1000.);
//            [_BGView.layer pop_addAnimation:anim forKey:@"slide"];
//        }
        
        
        }
        
        
        
//        initBlankView
        
        
        {
//        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
//        popView.backgroundColor = [UIColor whiteColor];
//        [_BGView addSubview:popView];
        
//        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.view.frame.size.width,600)];
//        [popView.layer pop_addAnimation:anim forKey:@"size"];
        }
        
//  initLineChartView
        {
            self.lineChart = [[ZFLineChart alloc] initWithFrame:CGRectMake(20,40, SCREEN_WIDTH-40, 300)];
            self.lineChart.dataSource = self;
            self.lineChart.delegate = self;
//            self.lineChart.topicLabel.text = @"国考";
            self.lineChart.unit = @"分数";
            self.lineChart.topicLabel.textColor = ZFBlack;
            self.lineChart.isShowSeparate = YES;
            self.lineChart.isResetAxisLineMinValue = YES;
            self.lineChart.isResetAxisLineMaxValue = YES;
            self.lineChart.isShadow = NO;
            self.lineChart.isShowAxisArrows = NO;

//          self.lineChart.isShowAxisLineValue = NO;
//          self.lineChart.isShadowForValueLabel = NO;
//            self.lineChart.valueLabelPattern = kPopoverLabelPatternBlank;
            self.lineChart.valueCenterToCircleCenterPadding = 15;
//            self.lineChart.separateColor = [UIColor grayColor];
//            self.lineChart.unitColor = ZFBlack;
//            self.lineChart.backgroundColor = ZFWhite;
            
            
            self.lineChart.axisColor = [UIColor clearColor];
            
//            self.lineChart.axisLineNameColor = ZFBlack;
//            self.lineChart.axisLineValueColor = ZFBlack;
            self.lineChart.xLineNameLabelToXAxisLinePadding = -20;
            
            
         [self setBorderWithView:self.lineChart top:YES left:YES bottom:YES right:YES borderColor:[UIColor redColor] borderWidth:1];
            
            
            
            [_BGView addSubview:self.lineChart];
            
            [self.lineChart strokePath];
            
            
            
        }
        
        
        
        
    }
    return _BGView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Animation";
    self.view.backgroundColor = [UIColor whiteColor];
    self.stateView = [[StateAnimationObject alloc]initWithFrame:CGRectZero bringTheinfo:nil];
    [self.stateView show];

    Weak_Self;
    CombobaseView *comboView = [[CombobaseView alloc]initWithFrame:CGRectMake(20, 84, 264, 264) itemCount:3 itemWidth:41 andModel:nil withCallBack:^(NSInteger tag) {
// 无法销毁
        switch (tag) {
            case 0:
                [weakSelf addBasicView];
                break;
            case 1:
                [weakSelf addSpringView];
                break;
            case 2:
                [weakSelf addDecayView];
                break;
            case 3:
                [weakSelf POPAnimatableProperty];
                break;
            case 4:
//                [weakSelf.stateView show];
//                    {
//                        if (_BGView) {
//                            [self.BGView removeFromSuperview];
//                            self.BGView = nil;
//                        }else{
//                            [self.view addSubview:self.BGView];
//
//                        }
//                    }
                break;
                case 5:
                [self addViewCenterAni];
                break;
            default:
                break;
        }
        
    }];
    [self.view addSubview:comboView];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //POPBasicAnimation
//        [self addBasicView];
    
    
    
    
    
    //POPaddSpringAnimation
//        [self addSpringView];
    
    
    
    // DecayAnimation
//        [self addDecayView];
    
    //POPAnimatableProperty
    //    [self POPAnimatableProperty];
    
    
    
    
    
//    
//    {
//        if (_BGView) {
//            [self.BGView removeFromSuperview];
//            self.BGView = nil;
//        }else{
//            [self.view addSubview:self.BGView];
//            
//        }
//    }
    
    
    
}


#pragma mark -AnimationTest
-(void)addBasicView{
//    POPBasicAnimation使用最广泛 提供固定时间间隔的动画(如淡入淡出效果)
    

    _POPBasicView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _POPBasicView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_POPBasicView];
    
    POPBasicAnimation *animPosition= [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animPosition.toValue = @(_POPBasicView.center.y+64);
    animPosition.duration = 1.3f;
    animPosition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    animPosition.repeatCount = 5;
//    animPosition.removedOnCompletion = YES;

    POPBasicAnimation *animPositionOut= [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    animPositionOut.toValue = @(_POPBasicView.center.y-64);
    animPositionOut.duration = 1.3f;
    animPositionOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    
    POPBasicAnimation *animAlpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animAlpha.fromValue = @(0.0f);
    animAlpha.toValue = @(1.0f);
    animAlpha.duration = 2.0f;
    
    
//    [_POPBasicView pop_addAnimation:animAlpha forKey:@"fade"];
    [_POPBasicView pop_addAnimation:animPosition forKey:@"position"];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_POPBasicView pop_addAnimation:animPositionOut forKey:@"position"];

    });
    
}



-(void)addSpringView{
    
    _POPSpringView = [[UIView alloc]initWithFrame:CGRectMake(50, 264, 64, 64)];
    _POPSpringView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_POPSpringView];
    
//  POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//  anSpring.toValue = @(_POPSpringView.center.x+200);
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    anSpring.toValue =  [NSValue valueWithCGRect:CGRectMake(_POPSpringView.center.x+200, _POPSpringView.center.y+200, _POPSpringView.bounds.size.width, _POPSpringView.bounds.size.height)];
    anSpring.beginTime = CACurrentMediaTime() + 1.0f;
    anSpring.springBounciness = 10.0f;
    [_POPSpringView pop_addAnimation:anSpring forKey:@"position"];
    
    
}



-(void)addDecayView{
    
    _POPDecayView = [[UIView alloc]initWithFrame:CGRectMake(50, 264, 64, 64)];
    _POPDecayView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_POPDecayView];
    
    
    POPDecayAnimation *anDecay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anDecay.velocity = @(500);
    anDecay.beginTime = CACurrentMediaTime() + 1.0f;
    [_POPDecayView pop_addAnimation:anDecay forKey:@"position"];
    
    
//   
//    UILabel *decayNumaber =[[UILabel alloc]initWithFrame:CGRectMake(50, 64, 64, 64)];
//    
//    decayNumaber.textAlignment = NSTextAlignmentCenter;
//    decayNumaber.backgroundColor = [UIColor grayColor];
//    decayNumaber.textColor = [UIColor redColor];
//    
//    decayNumaber.text = @"0";
//    [self.view addSubview:decayNumaber];
//    
//    
//    decayNumaber.text = [NSString stringWithFormat:@"%f",_POPDecayView.bounds.origin.x];
}

-(void)POPAnimatableProperty{
    

    [self.view addSubview:self.NUMLabel];
    
//    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"prop" initializer:^(POPMutableAnimatableProperty *prop) {
//        // read value
//        prop.readBlock = ^(id obj, CGFloat values[]) {
//            
//        };
//        // write value
//        prop.writeBlock = ^(id obj, const CGFloat values[]) {
//            
//        };
//        // dynamics threshold
//        prop.threshold = 0.01;
//    }];
    Weak_Self;

    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            
            weakSelf.NUMLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
        
        //        prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [self.NUMLabel pop_addAnimation:anBasic forKey:@"countdown"];
}


-(void)addViewCenterAni{
    
    {
        if (!_imageBtn) {

            _imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 72, 72)];
            [_imageBtn setImage:[UIImage imageNamed:@"HomeWd"] forState:UIControlStateNormal];
            [_imageBtn setImage:[UIImage imageNamed:@"HomeWd"] forState:UIControlStateHighlighted];
            [_imageBtn addTarget:self action:@selector(addViewSizeAni) forControlEvents:UIControlEventTouchDown];

            _btnBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            _btnBackView.center = _imageBtn.center;
            _btnBackView.backgroundColor = [UIColor greenColor];
        }
        [self.view addSubview:self.btnBackView];
        [self.view addSubview:self.imageBtn];
    }
    


}

-(void)btnAction{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    scaleAnimation.fromValue   = [NSValue valueWithCGPoint:CGPointMake(-SCREEN_WIDTH*0.5, CGRectGetMaxY(_imageBtn.frame)-30)];
    scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*0.5,CGRectGetMaxY(_imageBtn.frame)-30)];
    scaleAnimation.springBounciness    = 10.f;
    [self.btnBackView pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}


-(void)addViewSizeAni{
    POPBasicAnimation *cornerAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    cornerAnim.toValue = @4.f;
    cornerAnim.duration= 0.5f;
//    [self.layer pop_addAnimation:cornerAnim forKey:@"BarReadyStyleCornerAnim"];
    [self.btnBackView.layer removeAllAnimations];

    
    POPBasicAnimation *sizeAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    sizeAnim.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    sizeAnim.toValue = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
    sizeAnim.duration = 0.5f;
    [self.btnBackView.layer pop_addAnimation:sizeAnim forKey:@"BarReadyStyleSizeAnim"];
}

#pragma mark -ChartView

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[
             @[@"66.3",],
             @[@"66.4",]

             ];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"7月20日", @"7月20日"];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFSkyBlue, ZFOrange];
}

- (NSArray *)styleArrayInGenericChart:(ZFGenericChart *)chart{
    return @[PointsCircle
             ,PointsSquare
             ];

}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 100;
}

- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
    return 0;
}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 5;
}

#pragma mark - ZFLineChartDelegate

- (CGFloat)groupWidthInLineChart:(ZFLineChart *)lineChart{
    return 50.f;
}

- (CGFloat)paddingForGroupsInLineChart:(ZFLineChart *)lineChart{
    return 20.f;
}

- (CGFloat)circleRadiusInLineChart:(ZFLineChart *)lineChart{
    
    return 3.f;
}

- (CGFloat)lineWidthInLineChart:(ZFLineChart *)lineChart{
    
    return 1.f;
}

//- (NSArray *)valuePositionInLineChart:(ZFLineChart *)lineChart{
//    return @[@(kChartValuePositionOnTop), @(kChartValuePositionDefalut), @(kChartValuePositionOnBelow)];
//}

- (void)lineChart:(ZFLineChart *)lineChart didSelectCircleAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex circle:(ZFCircle *)circle popoverLabel:(ZFPopoverLabel *)popoverLabel{
    circle.isAnimated = YES;
    //    circle.opacity = 0.5;
    
    [circle strokePath];
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectPopoverLabelAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{

}




- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

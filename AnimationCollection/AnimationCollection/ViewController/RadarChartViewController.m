//
//  RadarChartViewController.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/4/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "RadarChartViewController.h"
#import "ZFChart.h"

@interface RadarChartViewController ()<ZFRadarChartDataSource, ZFRadarChartDelegate>
@property (nonatomic, strong) ZFRadarChart * radarChart;
@property (nonatomic, assign) CGFloat height;
@end

@implementation RadarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    self.radarChart = [[ZFRadarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _height)];
    self.radarChart.dataSource = self;
    self.radarChart.delegate = self;
    self.radarChart.itemFont = [UIFont systemFontOfSize:12.f];
    self.radarChart.isAnimated = YES;
    self.radarChart.isShowSeparate = YES;
    self.radarChart.isShowValue = NO;
    self.radarChart.polygonLineWidth = 1.f;
    self.radarChart.radarLineWidth = 1.f;
    self.radarChart.separateLineWidth = 1.f;
    
    [self.view addSubview:self.radarChart];
    [self.radarChart strokePath];
    
}

#pragma mark - ZFRadarChartDataSource

- (NSArray *)itemArrayInRadarChart:(ZFRadarChart *)radarChart{
    return @[@"19\n 常识判断", @"19\n 常识判断", @"19\n 常识判断",@"19\n 常识判断", @"19\n 常识判断",];
    return @[@"item 1", @"item 2", @"item 3", @"item 4", @"item 5", @"item 6", @"item 7", @"item 8", @"item 9"];
}

- (NSArray *)valueArrayInRadarChart:(ZFRadarChart *)radarChart{
    return @[@"4", @"10", @"4", @"8", @"3.2"];
    return @[@"4", @"10", @"4", @"9", @"7", @"8", @"3.2", @"5", @"8.4"];
}

-(NSArray *)itemColorArrayInRadarChart:(ZFRadarChart *)radarChart{
    return @[ZFRed,ZFBlue,ZFRed,ZFBlue,ZFRed];
}

//-(NSArray *)separateLineColorArrayInRadarChart:(ZFRadarChart *)radarChart{
//    return @[ZFRed,ZFBlue,ZFRed,ZFBlue,ZFRed];
//}

//多组
- (NSArray *)colorArrayInRadarChart:(ZFRadarChart *)radarChart{
    return @[ZFRed];
}

//- (CGFloat)maxValueInRadarChart:(ZFRadarChart *)radarChart{
//    return 0.f;
//}

#pragma mark - ZFRadarChartDelegate

- (CGFloat)radiusForRadarChart:(ZFRadarChart *)radarChart{
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        return (SCREEN_HEIGHT - 100) / 2;
    }else{
        return (SCREEN_WIDTH - 100) / 2;
    }
    
    //    return 100.f;
}

//- (NSUInteger)sectionCountInRadarChart:(ZFRadarChart *)radarChart{
//    return 4;
//}

//- (CGFloat)radiusExtendLengthForRadarChart:(ZFRadarChart *)radarChart itemIndex:(NSInteger)itemIndex{
//    if (itemIndex == 0) {
//        return 50.f;
//    }
//
//    return 25.f;
//}
//
//- (CGFloat)valueRotationAngleForRadarChart:(ZFRadarChart *)radarChart{
//    return 45.f;
//}

- (void)radarChart:(ZFRadarChart *)radarChart didSelectItemLabelAtIndex:(NSInteger)labelIndex{
    NSLog(@"当前点击的下标========%ld", (long)labelIndex);
}


#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.radarChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
        
    }else{
        self.radarChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
        
    }
    
    [self.radarChart strokePath];
}

- (void)setUp{
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.5;
        
    }else{
        //首次进入控制器为竖屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

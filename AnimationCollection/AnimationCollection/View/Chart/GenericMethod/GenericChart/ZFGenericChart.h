//
//  ZFGenericChart.h
//  ZFChartView
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

/// 带坐标轴的数据源

#import <UIKit/UIKit.h>
#import "ZFPopoverLabel.h"
@class ZFGenericChart;

/*********************  ZFChartDataSource(ZFChart数据源方法)  *********************/
@protocol ZFGenericChartDataSource <NSObject>

@required

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart;

/**
 *  名称数据
 *
 *  @return NSArray必须存储NSString类型
 */
- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart;



@optional

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart;

- (NSArray *)styleArrayInGenericChart:(ZFGenericChart *)chart;

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart;

- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart;

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart;

@end;


@interface ZFGenericChart : UIView

@property (nonatomic, weak) id<ZFGenericChartDataSource> dataSource;

/** 主题Label */
@property (nonatomic, strong) UILabel * topicLabel;
/** y轴单位 */
@property (nonatomic, copy) NSString * unit;

/** 单位颜色(默认为黑色) */
@property (nonatomic, strong) UIColor * unitColor;
/** 背景颜色(默认为白色) */
@property (nonatomic, strong) UIColor * backgroundColor;
/** 坐标轴颜色(默认为黑色) */
@property (nonatomic, strong) UIColor * axisColor;
/** y轴(普通图表) 或 x轴(横向图表) 标题颜色(默认为黑色) */
@property (nonatomic, strong) UIColor * axisLineNameColor;
/** y轴(普通图表) 或 x轴(横向图表) value颜色(默认为黑色) */
@property (nonatomic, strong) UIColor * axisLineValueColor;
/** 分割线颜色(默认为浅灰色) */
@property (nonatomic, strong) UIColor * separateColor;
/** y轴(普通图表) 或 x轴(横向图表) valueLabel阴影颜色(默认为浅灰色) */
@property (nonatomic, strong) UIColor * valueLabelShadowColor;
/** 图形bezierPath阴影颜色(默认为浅灰色) */
@property (nonatomic, strong) UIColor * shadowColor;

/** 图表上label字体大小(默认为10.f) */
@property (nonatomic, strong) UIFont * valueOnChartFont;
/** y轴(普通图表) 或 x轴(横向图表) 上名称字体大小(默认为10.f) */
@property (nonatomic, strong) UIFont * axisLineNameFont;
/** y轴(普通图表) 或 x轴(横向图表) 上数值字体大小(默认为10.f) */
@property (nonatomic, strong) UIFont * axisLineValueFont;

/** 图表透明度(范围0 ~ 1, 默认为1.f) */
@property (nonatomic, assign) CGFloat opacity;
/** x轴名称label与x轴之间的距离(默认为0.f)(横向图表无效) */
@property (nonatomic, assign) CGFloat xLineNameLabelToXAxisLinePadding;
/** x轴valueLabel样式(默认为kPopoverLabelPatternPopover) */
@property (nonatomic, assign) kPopoverLabelPattern valueLabelPattern;
/** y轴(普通图表) 或 x轴(横向图表) 数值的显示类型(保留有效小数或显示整数形式，默认为保留有效小数) */
@property (nonatomic, assign) kValueType valueType;

@property (nonatomic, assign) BOOL isResetAxisLineMaxValue;

@property (nonatomic, assign) BOOL isResetAxisLineMinValue;
/** 是否带动画显示(默认为YES，带动画) */
@property (nonatomic, assign) BOOL isAnimated;
/** valueLabel当为气泡样式时，是否带阴影效果(默认为YES) */
@property (nonatomic, assign) BOOL isShadowForValueLabel;
/** 是否显示 y轴(普通图表) 或 x轴(横向图表) 的value(默认为YES，当需要自定义value显示样式时，可设置为NO) */
@property (nonatomic, assign) BOOL isShowAxisLineValue;
/** 是否显示分割线(默认为NO) */
@property (nonatomic, assign) BOOL isShowSeparate;
/** 是否显示坐标轴箭头(默认为YES) */
@property (nonatomic, assign) BOOL isShowAxisArrows;
#pragma mark -addMethod
/** 是否显示line指示器(默认为YES) */
@property (nonatomic, assign) BOOL isShowIndicator;

#pragma mark - 此方法不需理会(Ignore this method)

- (void)commonInit;

@end

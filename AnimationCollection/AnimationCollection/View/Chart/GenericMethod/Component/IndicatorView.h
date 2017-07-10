//
//  IndicatorView.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/7/6.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndicatorView : UIView
/** 存储线的数组 */
@property (nonatomic, strong) NSString * LineName;
/** 存储点类型数组 */
@property (nonatomic, strong) NSString * pointsStyle;
/** 颜色数组 */
@property (nonatomic, strong) UIColor * colorName;
-(void)addIndicatorView:(NSString *)LineName withPointsStyle:(NSString *)pointsStyle withColorName:(UIColor *)colorName andIndex:(int)index;
@end

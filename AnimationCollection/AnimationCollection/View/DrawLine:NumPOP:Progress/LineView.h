//
//  LineView.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/13.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView

@property(nonatomic) UIColor *strokeColor;
@property (nonatomic ,strong) void(^valueBlcok)(CGFloat value);
- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;
@end

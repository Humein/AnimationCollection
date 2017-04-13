//
//  PresentingAnimator.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/13.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PresentingAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/**
    初始化 width 传0默认104.f

 @param width 传0默认104.f
 @return PresentingAnimator
 */
+(instancetype)initWithWidth:(CGFloat)width;
@end

//
//  StateAnimationObject.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StateAnimationObject : NSObject
-(instancetype)initWithFrame:(CGRect)frame bringTheinfo:(NSDictionary *)infoDic;
//弹出
-(void)show;
//消失
-(void)dismiss;
@end

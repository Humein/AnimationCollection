//
//  FeedBackView.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedBackView : NSObject
//回调
@property(nonatomic,copy) void(^confirmBenClick)(NSInteger tag,NSString *feedBack);

- (instancetype)initWithTitle:(NSString *)title withDefaultStar:(NSInteger)star ;
//弹出
-(void)show;
//消失
-(void)dismiss;
@end

//
//  CombobaseView.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/7/11.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock) (NSInteger tag);
@interface CombobaseView : UIView
-(instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)count itemWidth:(CGFloat)itemWidth andModel:(NSArray *)viewModel withCallBack:(ClickBlock)callBack;
//-(void)refreshViewWithViewModel:(NSArray *)viewModel;
@end

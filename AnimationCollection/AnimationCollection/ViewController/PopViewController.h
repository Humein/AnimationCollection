//
//  PopViewController.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/6/21.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopViewControllerDelegate <NSObject>
@required
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@optional

@end
@interface PopViewController : UIViewController
@property (nonatomic, weak) id<PopViewControllerDelegate> PopViewDelegate;

@end

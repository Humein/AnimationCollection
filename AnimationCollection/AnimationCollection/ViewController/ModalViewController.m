//
//  ModalViewController.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/4/13.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "ModalViewController.h"
#import "LabelProgress.h"
#import <SDAutoLayout/SDAutoLayout.h>
@interface ModalViewController ()
@property (nonatomic,strong) LabelProgress *labelProgress;
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, 200, 30);
    self.labelProgress = [[LabelProgress alloc]initWithFrame:frame];
    [self.view addSubview:self.labelProgress];
    
    self.labelProgress.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 40)
    .widthIs(frame.size.width)
    .heightIs(frame.size.height);
    // Do any additional setup after loading the view.
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.labelProgress.timer invalidate];
    self.labelProgress.timer = nil;
    
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

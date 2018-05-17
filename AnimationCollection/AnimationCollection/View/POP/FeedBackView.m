//
//  FeedBackView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "FeedBackView.h"
@interface FeedBackView() <UIGestureRecognizerDelegate>
{

}
// 内容容器
@property (nonatomic,strong) UIView *contentView;
// 展示容器
@property (nonatomic,strong) UIView *containerView;

@end

@implementation FeedBackView
- (instancetype)initWithTitle:(NSString *)title withDefaultStar:(NSInteger)star {
    self = [super init];
    if(self)
    {

        [self addSubviews];
    }
    return self;
    
}

-(void)addSubviews{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *containerView = [[UIView alloc] initWithFrame:keyWindow.frame];
    containerView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewClick)];
    tap.delegate = self;
    [containerView addGestureRecognizer:tap];
    containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    
    
    _contentView = [[UIView alloc] init];
    _contentView.layer.cornerRadius = 8;
    _contentView.clipsToBounds = YES;
    _contentView.backgroundColor =  [UIColor redColor];
    
    [containerView addSubview:_contentView];
    
//    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(containerView.mas_centerY);
//        make.left.equalTo(containerView.mas_left).offset(47);
//        make.right.equalTo(containerView.mas_right).offset(-47);
//        make.height.equalTo(@247);
//    }];
    
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.font = [UIFont systemFontOfSize:15];
    [_contentView addSubview:labelTitle];
//    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_contentView.mas_top).offset(20);
//        make.centerX.mas_equalTo(_contentView.mas_centerX);
//        make.height.mas_equalTo(@15);
//    }];
    
   

    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancleBtn addTarget:self action:@selector(cancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:cancleBtn];
//    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_suggestTextView.mas_bottom).offset(0);
//        make.left.mas_equalTo(_suggestTextView.mas_left).offset(0);
//        make.right.mas_equalTo(lineView.mas_left).offset(0);
//        make.bottom.mas_equalTo(_contentView.mas_bottom).offset(0);
//    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:confirmBtn];
//    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_suggestTextView.mas_bottom).offset(0);
//        make.left.mas_equalTo(lineView.mas_right).offset(0);
//        make.right.mas_equalTo(_contentView.mas_right).offset(0);
//        make.bottom.mas_equalTo(_contentView.mas_bottom).offset(0);
//    }];
    
    
    self.containerView = containerView;
    
}
#pragma mark ---PrivateMethod

- (void)containerViewClick {
    [self dismiss];
}
- (void)cancleBtn:(UIButton *)sender{
    [self dismiss];
}

- (void)confirmBtn:(UIButton *)sender{
    if (_confirmBenClick) {
        _confirmBenClick(@"",@"");
    }
    [self dismiss];
}

#pragma mark ---PublicMethod
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.containerView];
    [keyWindow bringSubviewToFront:self.containerView];
    
}

- (void)dismiss {
    [self.containerView removeFromSuperview];
    // [self removeFromSuperview];
}

- (void)dealloc
{
    [self dismiss];
    NSLog(@"---");
}

@end

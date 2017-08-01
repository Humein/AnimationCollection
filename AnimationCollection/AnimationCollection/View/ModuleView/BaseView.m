//
//  baseView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/7/11.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "BaseView.h"
@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatModule:frame];
    }
    return self;
}
-(void)CreatModule:(CGRect)frame{
    
//    self.ModuleImage = [[UIImageView alloc]initWithFrame:frame];
//    self.ModuleImage.image = [UIImage imageNamed:@"HomeJj"];
//    [self.ModuleImage sizeToFit];
//    [self addSubview:self.ModuleImage];
//    
    self.ModuleScore = [[UILabel alloc]initWithFrame:frame];
    self.ModuleScore.text = @"数";
    self.ModuleScore.font = [UIFont systemFontOfSize:11];
    self.ModuleScore.textAlignment = NSTextAlignmentCenter;
    self.ModuleScore.textColor = [UIColor redColor];
    [self addSubview:self.ModuleScore];
    
    
//    self.ModuleDetail = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,60,20)];
//    self.ModuleDetail.text = @"字";
//    self.ModuleDetail.font = [UIFont systemFontOfSize:11];
//    self.ModuleDetail.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:self.ModuleDetail];

    
    
    
    
}

@end

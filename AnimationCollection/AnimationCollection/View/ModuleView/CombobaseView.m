//
//  CombobaseView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/7/11.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "CombobaseView.h"
#import "BaseView.h"
#import "UIView+SDAutoLayout.h"
@interface CombobaseView()
{
    UIView *_autoMarginViewsContainer;
    NSMutableArray *_temp;
}
@property(nonatomic,strong) BaseView *moduleView;
@property (nonatomic, copy) ClickBlock block;

@end
@implementation CombobaseView

-(instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)count itemWidth:(CGFloat)itemWidth andModel:(NSArray *)viewModel withCallBack:(ClickBlock)callBack{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        [self setupAutoMarginViewsWithCount:count itemWidth:itemWidth withModel:viewModel];
        self.block = callBack;
        
    }
    return self;
}

- (void)setupAutoMarginViewsWithCount:(NSInteger)count itemWidth:(CGFloat)itemWidth withModel:(NSArray *)viewModel
{
    [_autoMarginViewsContainer removeFromSuperview];
    _autoMarginViewsContainer = nil;
    _autoMarginViewsContainer = [UIView new];
    _autoMarginViewsContainer.backgroundColor = [UIColor redColor];
    [self addSubview:_autoMarginViewsContainer];
    
    _temp = [NSMutableArray new];
    
    viewModel = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6" ,nil];
    
    for (int i = 0; i < viewModel.count; i++) {
        self.moduleView = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, itemWidth, itemWidth)];
        self.moduleView.backgroundColor = [UIColor whiteColor];
        [self.moduleView setUserInteractionEnabled:YES];
        self.moduleView.tag = i;
        [self.moduleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)]];
        [_autoMarginViewsContainer addSubview:self.moduleView];
        
        self.moduleView.sd_layout
        .centerXEqualToView(_autoMarginViewsContainer)
        .widthIs(itemWidth)
        .heightIs(itemWidth);
        [_temp addObject:self.moduleView];
        
        if (i < viewModel.count) {
            _moduleView.ModuleScore.text = [viewModel objectAtIndex:i];;
        }
        
    }
    
    
    [_autoMarginViewsContainer setupAutoMarginFlowItems:[_temp copy] withPerRowItemsCount:count itemWidth:itemWidth verticalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    
    
    _autoMarginViewsContainer.sd_layout
    .leftSpaceToView(self, 20)
    .rightSpaceToView(self, 20)
    .topSpaceToView(self, 8);
}
-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizerr{
    
    UIView *viewClicked=[gestureRecognizerr view];
    //    DLog(@"viewClicked===%ld",(long)viewClicked.tag);

    if (self.block) {
//    self.block(self);
      self.block(viewClicked.tag);
    }
}

@end

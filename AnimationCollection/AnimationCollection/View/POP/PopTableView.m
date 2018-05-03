//
//  PopTableView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/2.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PopTableView.h"
@interface PopTableView()<UITableViewDelegate,UITableViewDataSource>
{
    //    UIImageView *_bgImage;
}
@property(nonatomic,copy) NSMutableArray *cellDataSource;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *bgImage;
@property (nonatomic, strong) UIView *maskView;

@end
@implementation PopTableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = YES;
        _tableView.allowsSelection = YES;
        //        _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
    }
    return _tableView;
}







#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = YES;
        //        cell.delegate = self;
    }
    MatchesSwitchMdoel *cellViewModel = [self.cellDataSource objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = UIColorFromRGBA(0x333333, 1);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = cellViewModel.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchesSwitchMdoel *cellViewModel = [self.cellDataSource objectAtIndex:indexPath.row];
    if([self.delegate respondsToSelector:@selector(cellClick:)]){
        [self.delegate cellClick:cellViewModel ];
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

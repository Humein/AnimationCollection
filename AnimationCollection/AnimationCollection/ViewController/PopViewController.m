//
//  PopViewController.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2017/6/21.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "PopViewController.h"
//http://www.jianshu.com/p/2c6f98c35f31
@interface PopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *addArray;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //弹出窗内容
    self.addArray = [[NSMutableArray alloc] initWithObjects:@"扫一扫",@"加好友", @"创建讨论组",@"发送到电脑", @"面对面快传",@"收钱", nil];
    
    [self loadTableView];
}
#pragma mark 创建 tableView
- (void)loadTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tableView];
}
#pragma mark tabelView 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = self.addArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 重写 preferredContentSize, 返回 popover 的大小
/**
 *  此方法,会返回一个由UIKit子类调用后得到的Size ,此size即是完美适应调用此方法的UIKit子类的size
 *  得到此size后, 可以调用 调整弹框大小的方法 **preferredContentSize**配合使用
 *  重置本控制器的大小
 */
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;//
        //返回一个完美适应tableView的大小的 size; sizeThatFits 返回的是最合适的尺寸, 但不会改变控件的大小
        CGSize size = [self.tableView sizeThatFits:tempSize];
        return size;
    }else{
        return [self preferredContentSize];
    }
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

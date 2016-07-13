//
//  LLSameCityViewController.m
//  LLRiseTabBarDemo
//
//  Created by HelloWorld on 10/18/15.
//  Copyright © 2015 melody. All rights reserved.
//

#import "LLSameCityViewController.h"

@interface LLSameCityViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) CGFloat oldOffset;
@end

@implementation LLSameCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%lf",[UIScreen mainScreen].bounds.size.width);
    self.oldOffset = 0;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.SegmentedControl addTarget:self action:@selector(SegmentedControlChange) forControlEvents:UIControlEventValueChanged];
}

- (void)SegmentedControlChange{
    if (self.SegmentedControl.selectedSegmentIndex == 0) {
        self.view.backgroundColor = [UIColor grayColor];
    }
    else{
        self.view.backgroundColor = [UIColor orangeColor];
    }
}

#pragma mark - UITabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    Cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return Cell;
}

#pragma mark - tabbar隐藏
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > self.oldOffset && scrollView.contentOffset.y >= 5) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        //        self.tabBarController.tabBar.hidden = YES;
        [self hideTabBar];
    }
    else{
        //        self.tabBarController.tabBar.hidden = NO;
        [self showTabBar];
    }
    
    self.oldOffset = scrollView.contentOffset.y;//将当前位移变成缓存位移
    
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES)
    { //already hidden
        return;
    }
    [UIView animateWithDuration:0.35
                     animations:^{
                         CGRect tabFrame = self.tabBarController.tabBar.frame;
                         tabFrame.origin.x = 0 - tabFrame.size.width;
                         self.tabBarController.tabBar.frame = tabFrame;
                     }];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)showTabBar {
    if (self.tabBarController.tabBar.hidden == NO)
    { // already showing
        return;
    }
    [UIView animateWithDuration:0.35
                          animations:^{
                              CGRect tabFrame = self.tabBarController.tabBar.frame;
                              tabFrame.origin.x = CGRectGetWidth(tabFrame) + CGRectGetMinX(tabFrame);
                              self.tabBarController.tabBar.frame = tabFrame;
                          }];
    self.tabBarController.tabBar.hidden = NO;
}

@end

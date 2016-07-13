//
//  TraditionalTableViewController.m
//  铁杆
//
//  Created by fengyibo on 15/11/30.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "TraditionalTableViewController.h"
#import "AFNetworking.h"
#import "TraditionalCell.h"
#import "ButtonViewController.h"

@interface TraditionalTableViewController ()

@end

@implementation TraditionalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TraditionalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TraditionalCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TraditionalCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 1) {
        cell.titleLabel.text = @"我要营销推广";
        cell.firstLabel.text = @"微信推广";
        cell.secondLabel.text = @"营销游戏";
        cell.thirdLabel.text = @"吸粉工具";
        cell.fourthLabel.text = @"互动工具";
        cell.firstImageView.image = [UIImage imageNamed:@"en_18"];
        cell.secondImageView.image = [UIImage imageNamed:@"en_17"];
        cell.thirdImageView.image = [UIImage imageNamed:@"en_20"];
        cell.fourthImageView.image = [UIImage imageNamed:@"en_22"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if (indexPath.section == 0) {
        ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
        navi.view.tag = 2;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
        
    [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        buttonVC.modelArray = [NSMutableArray array];
        buttonVC.modelArray = responseObject[@"data"][1][@"tools"];
        //        self.string = [self.modelArray lastObject][@"name"];
        //        NSLog(@"string%@",self.string);
        [buttonVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error:%@",error);
    }];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:NO completion:nil];
    }
    else{
        ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
        navi.view.tag = 3;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
        
        [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"JSON: %@", responseObject);
            buttonVC.modelArray = [NSMutableArray array];
            buttonVC.modelArray = responseObject[@"data"][2][@"tools"];
            //        self.string = [self.modelArray lastObject][@"name"];
            //        NSLog(@"string%@",self.string);
            [buttonVC.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
        }];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:NO completion:nil];
    }
}

@end

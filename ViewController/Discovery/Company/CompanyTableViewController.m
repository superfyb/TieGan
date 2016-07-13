//
//  CompanyTableViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/20.
//  Copyright © 2015年 fengyibo. All rights reserved.
//
#import "ButtonViewController.h"
#import "AFNetworking.h"
#import "CompanyCell.h"
#import "CompanyTableViewController.h"

@interface CompanyTableViewController ()

@end

@implementation CompanyTableViewController

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
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CompanyCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 0) {
        [cell.firstButton addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondButton addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.thirdButton addTarget:self action:@selector(button3:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.section == 1) {
        cell.titleLabel.text = @"我要运营推广";
        cell.firstButtonLabel.text = @"H5营销";
        cell.firstButtonImageView.image = [UIImage imageNamed:@"铁杆高保真图片-11_14"];
        cell.secondButtonLabel.text = @"微信营销";
        cell.secondButtonImageView.image = [UIImage imageNamed:@"铁杆高保真图片-11_13"];
        cell.thirdButtonLabel.text = @"UI设计";
        cell.thirdButtonImageView.image = [UIImage imageNamed:@"铁杆高保真图片-11_17"];
        [cell.firstButton addTarget:self action:@selector(button4:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondButton addTarget:self action:@selector(button5:) forControlEvents:UIControlEventTouchUpInside];
        [cell.thirdButton addTarget:self action:@selector(button6:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (void)button1:(id)sender {
    ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
    navi.view.tag = 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        buttonVC.modelArray = [NSMutableArray array];
        buttonVC.modelArray = responseObject[@"data"][0][@"tools"];
        //        self.string = [self.modelArray lastObject][@"name"];
        //        NSLog(@"string%@",self.string);
        [buttonVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (void)button2:(id)sender {
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
        NSLog(@"Error: %@", error);
    }];

    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (void)button3:(id)sender {
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
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (void)button4:(id)sender {
    ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
    navi.view.tag = 4;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    
    [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        buttonVC.modelArray = [NSMutableArray array];
        buttonVC.modelArray = responseObject[@"data"][3][@"tools"];
        //        self.string = [self.modelArray lastObject][@"name"];
        //        NSLog(@"string%@",self.string);
        [buttonVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (void)button5:(id)sender {
    ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
    navi.view.tag = 5;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    
    [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        buttonVC.modelArray = [NSMutableArray array];
        buttonVC.modelArray = responseObject[@"data"][4][@"tools"];
        //        self.string = [self.modelArray lastObject][@"name"];
        //        NSLog(@"string%@",self.string);
        [buttonVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

- (void)button6:(id)sender {
    ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
    navi.view.tag = 6;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    
    [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        buttonVC.modelArray = [NSMutableArray array];
        buttonVC.modelArray = responseObject[@"data"][5][@"tools"];
        //        self.string = [self.modelArray lastObject][@"name"];
        //        NSLog(@"string%@",self.string);5
        [buttonVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

@end

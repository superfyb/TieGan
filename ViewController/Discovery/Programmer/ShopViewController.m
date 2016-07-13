//
//  ShopViewController.m
//  铁杆
//
//  Created by fengyibo on 15/12/17.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "AFNetworking.h"
#import "ShopViewController.h"
#import "AppCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "RequirementDetailsViewController.h"
#import "RequirementModel.h"

@interface ShopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *classArray;
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSMutableArray *requirementArray;
@property (nonatomic,strong) NSString *lastData_id;
@property (nonatomic,strong) NSArray *imageArray;
@end

@implementation ShopViewController

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"轮播图-3",@"轮播图-4",@"轮播图-5",@"轮播图-6",@"轮播图-1",@"轮播图-2",@"轮播图-7",@"轮播图-8",@"轮播图-9",@"轮播图-10",@"轮播图-11",@"轮播图-12",@"轮播图-13", nil];
    }
    return _imageArray;
}

- (NSMutableArray *)requirementArray{
    if (!_requirementArray) {
        _requirementArray = [NSMutableArray array];
    }
    return _requirementArray;
}

- (NSArray *)iconArray{
    if (!_iconArray) {
        _iconArray = [[NSArray alloc] initWithObjects:@"",@"appIcon",@"",@"",@"",@"shopIcon",@"weChatIcon",@"webIcon",@"projectIcon",@"marketingIcon", nil];
    }
    return _iconArray;
}

- (NSArray *)classArray{
    if (!_classArray) {
        _classArray = [[NSArray alloc] initWithObjects:@"",@"app",@"",@"",@"",@"商城",@"微信",@"网站",@"设计",@"营销", nil];
    }
    return _classArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    //    [self.view layoutSubviews];
    NSLog(@"1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.requirementArray.count;
}

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"5656b9dc55353_1448524252" forHTTPHeaderField:@"Authorization"];
    
    //    NSString *urlStr = @"http://120.26.55.28:5053/v1/req/index?start=jz9pv";
    NSString *urlStr = [NSString stringWithFormat:@"http://120.26.55.28:5053/v1/req/index/5?start=%@",self.lastData_id];
    // NSString *urlStr = [NSString stringWithFormat:@"%@?start=%@",self.category_id,self.lastData_id];
    NSLog(@"url%@",urlStr);
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = (NSArray *)responseObject[@"data"];
        for (int x = 0; x<array.count; x++) {
            requirementModel *model = [[requirementModel alloc] init];
            model.name = responseObject[@"data"][x][@"name"];
            model.cost = [NSString stringWithFormat:@"¥%@",responseObject[@"data"][x][@"cost"]];
            model.period = [NSString stringWithFormat:@"交付周期:%@",responseObject[@"data"][x][@"period"]];
            model.icon_img = [NSString stringWithFormat:@"http://120.26.55.28:5051%@",responseObject[@"data"][x][@"category"][@"icon_img"]];
            model.category_id = responseObject[@"data"][x][@"category"][@"id"];
            model.data_id = responseObject[@"data"][x][@"id"];
            self.lastData_id = model.data_id;
            [self.requirementArray addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)loadNewData{
    [self.requirementArray removeAllObjects];
    self.lastData_id = nil;
    [self loadData];
}

- (void)loadMoreData{
    [self loadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AppCell" owner:self options:nil] lastObject];
    }
    requirementModel *model = self.requirementArray[indexPath.row];
    cell.num.text = [NSString stringWithFormat:@"%ld",5348+indexPath.row];
    cell.name.text = model.name;
    cell.cost.text = model.cost;
    cell.data_id = model.data_id;
    cell.category.text = [self.classArray objectAtIndex:[model.category_id intValue]];
    cell.smallIcon.image = [UIImage imageNamed:[self.iconArray objectAtIndex:[model.category_id intValue]]];
    cell.period.text = model.period;
    NSString *imageName = [self.imageArray objectAtIndex:indexPath.row%13];
    cell.mainImageView.image = [UIImage imageNamed:imageName];
//    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.icon_img]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *urlStr = [NSString stringWithFormat:@"http://120.26.55.28:5053/v1/req/%@",cell.data_id];
    RequirementDetailsViewController *rdVC = [[RequirementDetailsViewController alloc] init];
    rdVC.detailString = urlStr;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rdVC];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];    NSLog(@"hahaha");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 295;
}

@end


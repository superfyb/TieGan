//
//  MyRequirermentsViewController.m
//  铁杆
//
//  Created by fengyibo on 15/12/18.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "AFNetworking.h"
#import "MyRequirermentsViewController.h"
#import "AppCell.h"
#import "MyRequirementCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "RequirementDetailsViewController.h"
#import "RequirementModel.h"
#import "CustomViewController.h"

@interface MyRequirermentsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *classArray;
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSMutableArray *requirementArray;
@property (nonatomic,strong) NSString *lastData_id;
@property (nonatomic,strong) NSArray *imageArray;
@end

@implementation MyRequirermentsViewController

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"轮播图-1",@"轮播图-2",@"轮播图-3",@"轮播图-4",@"轮播图-5",@"轮播图-6",@"轮播图-7",@"轮播图-8",@"轮播图-9",@"轮播图-10",@"轮播图-11",@"轮播图-12",@"轮播图-13", nil];
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
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSString *Authorization = [myDefaults objectForKey:@"Authorization"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
    
    //    NSString *urlStr = @"http://120.26.55.28:5053/v1/req/index?start=jz9pv";
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *user_type = [mydefaults objectForKey:@"user_type"];
    NSString *urlStr;
    if ([user_type  isEqual: @1]) {
        urlStr = [NSString stringWithFormat:@"http://120.26.55.28:5053/v1/users/requirements?start=%@",self.lastData_id];
    }
    else{
        urlStr = [NSString stringWithFormat:@"http://120.26.55.28:5053/v1/users/applies?start=%@",self.lastData_id];
    }
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
    MyRequirementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRequirementCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyRequirementCell" owner:self options:nil] lastObject];
    }
    requirementModel *model = self.requirementArray[indexPath.row];
    cell.requirementName.text = [NSString stringWithFormat:@"项目名称:%@",model.name];
    cell.moneyLabel.text = [NSString stringWithFormat:@"金额:%@  %@",model.cost,model.period];
    cell.data_id = model.data_id;
    NSString *imageName = [self.imageArray objectAtIndex:indexPath.row%13];
    cell.mainImageView.image = [UIImage imageNamed:imageName];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRequirementCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除需求" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
        NSString *Authorization = [myDefaults objectForKey:@"Authorization"];

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
        NSString *reqURL = [NSString stringWithFormat:@"http://120.26.55.28:5053/v1/req/delete/%@",cell.data_id];
        
        [manager POST:reqURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
        }];
    }];

    UIAlertAction *change = [UIAlertAction actionWithTitle:@"更改需求" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
        [mydefaults setObject:@"data_id" forKey:cell.data_id];
        
        CustomViewController *cVC = [[CustomViewController alloc] init];
        cVC.data_id = cell.data_id;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:cVC];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.7;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromLeft;
        [self.view.layer addAnimation:animation forKey:nil];
        [self presentViewController:navi animated:NO completion:nil];
    }];
    
    [alertcontroller addAction:cancel];
    [alertcontroller addAction:delete];
    [alertcontroller addAction:change];
    [self presentViewController:alertcontroller animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 295;
}



@end

//
//  RequirementDetailsViewController.m
//  铁杆
//
//  Created by fengyibo on 15/12/7.
//  Copyright © 2015年 fengyibo. All rights reserved.
//
#import "AppCell.h"
#import "AFNetworking.h"
#import "RequirementDetailsViewController.h"
#import "UIImageView+WebCache.h"
//#import "MBProgressHUD+MJ.h"

@interface RequirementDetailsViewController ()
- (IBAction)JoinRecruit:(id)sender;
@property (nonatomic,strong) NSArray *classArray;
@property (nonatomic,strong) NSArray *iconArray;
@end

@implementation RequirementDetailsViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回上一界面
- (void)back{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)JoinRecruit:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"完成认证可参与招募" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"好的");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:agreeAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AppCell" owner:self options:nil] lastObject];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"5656b9dc55353_1448524252" forHTTPHeaderField:@"Authorization"];
    
    [manager GET:self.detailString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        cell.num.text = [NSString stringWithFormat:@"TG:%ld",5658+indexPath.row];
        cell.name.text = responseObject[@"data"][@"name"];
        cell.cost.text = [NSString stringWithFormat:@"¥%@",responseObject[@"data"][@"cost"]];
        cell.period.text = [NSString stringWithFormat:@"交付周期:%@",responseObject[@"data"][@"period"]];
        cell.category.text = [self.classArray objectAtIndex:[responseObject[@"data"][@"category"][@"id"] intValue]];
        cell.smallIcon.image = [UIImage imageNamed:[self.iconArray objectAtIndex:[responseObject[@"data"][@"category"][@"id"] intValue]]];
        [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.26.55.28:5051%@",responseObject[@"data"][@"category"][@"icon_img"]]]];
        self.title = responseObject[@"data"][@"name"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
    }];

    return cell;
}


@end

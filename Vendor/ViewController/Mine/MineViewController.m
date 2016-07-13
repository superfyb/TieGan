//
//  LLMineViewController.m
//  LLRiseTabBarDemo
//
//  Created by HelloWorld on 10/18/15.
//  Copyright © 2015 melody. All rights reserved.

#import "EaseMob.h"
#import "MineViewController.h"
#import "loginViewController.h"
#import "FeedbackViewController.h"
//#import "MBProgressHUD+MJ.h"
#import "PerfectInformationViewController.h"
#import "CollectViewController.h"
#import "TGConst.h"
#import "AFNetworking.h"
#import "MyRequirermentsViewController.h"
#import "UIImageView+WebCache.h"

#define avatarURL @"http://120.26.55.28:5053/v1/users/avatar"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)PerfectInformation:(id)sender;
- (IBAction)exitLogin:(id)sender;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewWeight;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置头像为圆
    self.headView.layer.cornerRadius = self.headView.frame.size.width / 2;
    self.headView.clipsToBounds = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.exitButton.layer.cornerRadius = 10.0;
    
    UIButton *headViewButton = [[UIButton alloc] init];
    headViewButton.frame = self.headView.bounds;
    self.headView.userInteractionEnabled = YES;
    [headViewButton addTarget:self action:@selector(headViewSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:headViewButton];
    
    [self.backgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sy4"]]];
}

- (void)viewWillAppear:(BOOL)animate{

    [self.tableView reloadData];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;

    //设置用户名
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"用户名:%@",[mydefaults objectForKey:@"Authorization"]);
    if (![[mydefaults objectForKey:@"Authorization"] isEqualToString:@""]) {
//    if(!([mydefaults objectForKey:@"Authorization"] == nil)){
        [self.exitButton setTitle:@"退出登陆" forState:UIControlStateNormal];
        [self.userName setTitle:[mydefaults objectForKey:@"userName"] forState:UIControlStateNormal];
        self.userName.userInteractionEnabled = NO;
        //获取后台头像
        if ([mydefaults objectForKey:@"headImageData"]) {
            NSData *data = [mydefaults objectForKey:@"headImageData"];
            self.headView.image = [UIImage imageWithData:data];
        }
        else{
            NSLog(@"hv%@",[mydefaults objectForKey:@"headViewUrlStr"]);
            if ([[mydefaults objectForKey:@"headViewUrlStr"] isEqualToString:@"http://120.26.55.28:5051"]) {
                [self.headView setImage:[UIImage imageNamed:@"user_head"]];
            }
            else{
                [self.headView sd_setImageWithURL:[NSURL URLWithString:[mydefaults objectForKey:@"headViewUrlStr"]]];
                NSData *data;
                UIImage *image = self.headView.image;
                if (UIImagePNGRepresentation(image) == nil) {
                    data = UIImageJPEGRepresentation(image, 1);
                    NSLog(@"jepg");
                }
                else{
                    data = UIImagePNGRepresentation(image);
                    NSLog(@"png");
                }
                [mydefaults setObject:data forKey:@"headImageData"];
            }
        }
    }
    else{
        [self.exitButton setTitle:@"登陆" forState:UIControlStateNormal];
        [self.userName setTitle:@"请登录" forState:UIControlStateNormal];
        self.userName.userInteractionEnabled = YES;
    }
}

- (void)headViewSelect{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        pickerImage.allowsEditing = YES;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        pickerImage.delegate = self;
//        pickerImage.allowsEditing = NO;
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [alertController addAction:takePhotoAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]                                                                                                         ;
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    }
    else{
        data = UIImagePNGRepresentation(image);
    }
    
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    [mydefaults setObject:data forKey:@"headImageData"];
    
    self.headView.image = image;
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"56700944d825a_1450182980" forHTTPHeaderField:@"Authorization"];
    
    [manager POST:avatarURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:imageData name:@"test.jpg"];
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    if (indexPath.section == 0) {
        NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
        if ([[mydefaults objectForKey:@"Authorization"] isEqualToString:@""]) {
            Cell.detailTextLabel.text = @"请先登陆";
        }
        switch (indexPath.row) {
            case 0:{
                Cell.imageView.image = [UIImage imageNamed:@"界面icon修改 12.14-23"];
                NSNumber *user_type = [mydefaults objectForKey:@"user_type"];
                if ([user_type  isEqual: @1]) {
                    Cell.textLabel.text = @"我发布的悬赏";
                }
                else{
                    Cell.textLabel.text = @"我参与的悬赏";
                }
                }
                break;
            case 1:
                Cell.imageView.image = [UIImage imageNamed:@"界面icon修改 12.14-24"];
                Cell.textLabel.text = @"我的收藏";
                break;
            case 2:
                Cell.imageView.image = [UIImage imageNamed:@"界面icon修改 12.14-25"];
                Cell.textLabel.text = @"推送消息设置";
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                Cell.imageView.image = [UIImage imageNamed:@"界面icon修改 12.14-26"];
                Cell.textLabel.text = @"反馈意见";
                break;
            case 1:
                Cell.imageView.image = [UIImage imageNamed:@"界面icon修改 12.14-27"];
                Cell.textLabel.text = @"铁杆说";
                break;
            case 2:
                Cell.imageView.image = [UIImage imageNamed:@"界面icon修改 12.14-28"];
                Cell.textLabel.text = @"关于铁杆";
                break;
            default:
                break;
        }
    }
    
    Cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//小箭头
    
    return Cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                MyRequirermentsViewController *myRequirementsVC = [[MyRequirermentsViewController alloc] init];
                myRequirementsVC.title = @"我参与的悬赏";
                [self.navigationController pushViewController:myRequirementsVC animated:YES];
                self.navigationController.navigationBarHidden = NO;
                self.tabBarController.tabBar.hidden = YES;
                }
                break;
            case 1:{
                NSArray *class = [NSArray arrayWithObjects:[UITableViewController class],[UITableViewController class], nil];
                NSArray *title = [NSArray arrayWithObjects:@"工具",@"牛人",nil];
                CollectViewController *cVC = [[CollectViewController alloc] initWithViewControllerClasses:class andTheirTitles:title];
                cVC.titleColorSelected = [UIColor whiteColor];
                cVC.titleColorNormal = TGNAVI;
                cVC.progressColor = TGNAVI;
                cVC.menuViewStyle = WMMenuViewStyleFlood;
                cVC.itemsWidths = @[@150,@150];
                cVC.title = @"我的收藏";
                cVC.view.frame = [UIScreen mainScreen].bounds;
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:
                                                cVC];
                CATransition *animation = [CATransition animation];
                animation.duration = 0.3;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = kCATransitionPush;
                animation.subtype = kCATransitionFromRight;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self presentViewController:navi animated:NO completion:nil];
                }
                break;
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:{
                FeedbackViewController *FVC = [[FeedbackViewController alloc] init];
                [self.navigationController pushViewController:FVC animated:YES];
            }
                break;
            case 1:{
                UIViewController *vc = [[UIViewController alloc] init];
                UIWebView *webView = [[UIWebView alloc] init];
                webView.frame = self.view.bounds;
//                webView.delegate = self;
                NSURL *url = [[NSURL alloc] initWithString:@"http://mp.weixin.qq.com/s?__biz=MzI3MDA2OTA3MQ==&mid=400902138&idx=1&sn=1e55eb5fa8811e577decddcbe6ad702b#rd"];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
                [vc.view addSubview:webView];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
                vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
                vc.title = @"铁杆说";
                
                CATransition *animation = [CATransition animation];
                animation.duration = 0.3;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = kCATransitionPush;
                animation.subtype = kCATransitionFromRight;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self presentViewController:navi animated:NO completion:nil];
            }
                break;
            default:
                break;
        }
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (void)back{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - login
- (IBAction)login:(id)sender {
    loginViewController *lgVC = [[loginViewController alloc] init];
    [self.navigationController pushViewController:lgVC animated:YES];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=-22) {
        self.backgroundView.frame = CGRectMake(0, 22+scrollView.contentOffset.y, [UIScreen mainScreen].bounds.size.width, 220-scrollView.contentOffset.y-22-38);
        
        //设置头像为圆
        self.headView.layer.cornerRadius = self.headView.frame.size.width / 2;
            self.headView.clipsToBounds = YES;

        self.headViewHeight.constant = 50-scrollView.contentOffset.y;
        self.headViewWeight.constant = self.headViewHeight.constant;
    }
    else{
        self.headView.layer.cornerRadius = 35;
    }
}

- (IBAction)PerfectInformation:(id)sender {
    PerfectInformationViewController *piVC = [[PerfectInformationViewController alloc] init];
    [self.navigationController pushViewController:piVC animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (IBAction)exitLogin:(id)sender {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error&&info) {
            NSLog(@"退出登录");
        }
    } onQueue:nil];
    if ([self.exitButton.titleLabel.text isEqualToString: @"退出登陆"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
//            if (![[mydefaults objectForKey:@"userName"] isEqualToString:@""]) {
//                [MBProgressHUD showSuccess:@"退出成功"];
//            }
//            [mydefaults setObject:@"" forKey:@"headImageData"];
            [mydefaults removeObjectForKey:@"headImageData"];
            [mydefaults setObject:@"" forKey:@"Authorization"];
            [mydefaults setObject:@"" forKey:@"userName"];
            
            [self.headView setImage:[UIImage imageNamed:@"user_head"]];
            [self.userName setTitle:@"请登录" forState:UIControlStateNormal];
            
            [self viewWillAppear:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return;
        }];
        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self login:nil];
    }
}
@end

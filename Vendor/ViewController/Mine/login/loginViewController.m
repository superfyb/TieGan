//
//  loginViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/16.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "EaseMob.h"
#import "loginViewController.h"
#import "SignUpViewController.h"
#import "ForgetPasswordViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

#define LoginURL @"http://120.26.55.28:5053/v1/users"

@interface loginViewController ()
- (IBAction)SignUp:(id)sender;
- (IBAction)forgetPassword:(id)sender;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(100, 999);
    self.title = @"登陆";
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)SignUp:(id)sender {
    SignUpViewController *suVC = [[SignUpViewController alloc] init];

    [self.navigationController pushViewController:suVC animated:YES];
}

- (IBAction)forgetPassword:(id)sender {
    ForgetPasswordViewController *fpVC = [[ForgetPasswordViewController alloc] init];

    [self.navigationController pushViewController:fpVC animated:YES];
}

- (IBAction)login:(id)sender {
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.phoneNum.text password:self.pwd.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error&&loginInfo) {
            NSLog(@"登录成功");
            //自动登录
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
        }
    } onQueue:nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters = @{@"username":self.phoneNum.text,@"password":self.pwd.text};
    
    [manager POST:LoginURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"data"]) {
            NSLog(@"Success: %@", responseObject[@"data"]);
            //            myDelegate.Authorization = responseObject[@"data"];
            //            myDelegate.userName = self.phoneNum.text;
            NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
            [mydefaults setObject:responseObject[@"data"][@"token"] forKey:@"Authorization"];
            [mydefaults setObject:self.phoneNum.text forKey:@"userName"];
            [mydefaults setObject:responseObject[@"data"][@"user"][@"type"] forKey:@"user_type"];
            [self.navigationController popToRootViewControllerAnimated:YES];
//            [MBProgressHUD showSuccess:@"登录成功"];
            
            NSString *headViewUrlStr = [NSString stringWithFormat:@"http://120.26.55.28:5051%@",responseObject[@"data"][@"user"][@"avatar"]];
            [mydefaults setObject:headViewUrlStr forKey:@"headViewUrlStr"];
        }
        else{
//            [MBProgressHUD showError:@"登录失败"];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"Error: %@", error);
    }];
}

@end

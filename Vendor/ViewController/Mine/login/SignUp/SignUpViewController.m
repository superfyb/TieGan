//
//  SignUpViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/16.
//  Copyright © 2015年 fengyibo. All rights reserved.
//
#import "EaseMob.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "TGConst.h"
#import "SignUpViewController.h"
//#import "MBProgressHUD+MJ.h"
#define tokenURL @"http://120.26.55.28:5053/v1/users/code"
#define signUpURL @"http://120.26.55.28:5053/v1/users/oauth"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *userType_Boss;
@property (weak, nonatomic) IBOutlet UIButton *userType_Developer;
- (IBAction)bossButton:(id)sender;
- (IBAction)developerButton:(id)sender;
- (IBAction)agreeButton:(id)sender;
- (IBAction)agreement:(id)sender;


- (IBAction)showPwd:(id)sender;
- (IBAction)access_token:(id)sender;
- (IBAction)signUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showPwdButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *token;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
//存储需求数据
@property (strong,nonatomic) NSArray *requirementArray;
@end

@implementation SignUpViewController

- (NSArray *)requirementArray{
    if (!_requirementArray) {
        _requirementArray = [NSArray array];
    }
    return _requirementArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机注册";
    
    self.signUpButton.alpha = 0.5;
    [self loadData];
}

#pragma mark - loadData
- (void)loadData{
    
}

#pragma mark - 显示隐藏密码
- (IBAction)bossButton:(id)sender {
    self.userType_Boss.selected = !self.userType_Boss.selected;
    self.userType_Developer.selected = !self.userType_Boss.selected;
}

- (IBAction)developerButton:(id)sender {
    self.userType_Developer.selected = !self.userType_Developer.selected;
    self.userType_Boss.selected = !self.userType_Developer.selected;
}

- (IBAction)agreeButton:(id)sender {
    self.agreeButton.selected = !self.agreeButton.selected;
    if (self.agreeButton.selected) {
        self.signUpButton.userInteractionEnabled = YES;
        self.signUpButton.alpha = 1;
    }
    else{
        self.signUpButton.userInteractionEnabled = NO;
        self.signUpButton.alpha = 0.5;
    }
}

- (IBAction)agreement:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    NSURL *url = [[NSURL alloc] initWithString:@"http://mp.weixin.qq.com/s?__biz=MzI3MDA2OTA3MQ==&mid=400900760&idx=1&sn=f0a3e63e1035f4c8c6fa3fd74e4229ce#rd"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [vc.view addSubview:webView];
    vc.title = @"铁杆服务协议";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showPwd:(id)sender {
    self.passWord.secureTextEntry = !self.passWord.secureTextEntry;
    if (self.passWord.secureTextEntry == YES) {
        [self.showPwdButton setTitle:@"显示" forState:UIControlStateNormal];
    }
    else{
        [self.showPwdButton setTitle:@"隐藏" forState:UIControlStateNormal];
    }
}
//获取验证码
- (IBAction)access_token:(id)sender {
    if ([self.phoneNumber.text isEqualToString:@""]) {
//        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters = @{@"mobile":self.phoneNumber.text};
    
    [manager POST:tokenURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"Success: %@", responseObject);
        //        [MBProgressHUD showSuccess:@"验证码已发送"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"Error: %@", error);
    }];
//    [manager POST:tokenURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@", responseObject);
//        [MBProgressHUD showSuccess:@"验证码已发送"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}

- (IBAction)signUp:(id)sender {
    
    if ([self.phoneNumber.text isEqualToString:@""]) {
//        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    else if ([self.passWord.text isEqualToString:@""]){
//        [MBProgressHUD showError:@"请设置密码"];
        return;
    }
    else if([self.token.text isEqualToString:@""]){
//        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    
    NSString *user_type = @"1";
    if (self.userType_Developer.selected) {
        user_type = @"2";
    }
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.phoneNumber.text password:self.passWord.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功");
        }
    } onQueue:nil];
    
    AFHTTPSessionManager *signUpManager = [AFHTTPSessionManager manager];
    [signUpManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [signUpManager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [signUpManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *parameters2 = @{@"type":@1,@"external_uid":self.phoneNumber.text,@"external_name":self.phoneNumber.text,@"token":@111,@"password":self.passWord.text,@"user_type":user_type};
    
    [signUpManager POST:signUpURL parameters:parameters2 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"data"]) {
            NSLog(@"Success: %@", responseObject[@"data"]);
            NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
            [mydefaults setObject:responseObject[@"data"][@"token"] forKey:@"Authorization"];
            [mydefaults setObject:self.phoneNumber.text forKey:@"userName"];
            [mydefaults setObject:responseObject[@"data"][@"user"][@"type"] forKey:@"user_type"];
            [self.navigationController popToRootViewControllerAnimated:YES];
//            [MBProgressHUD showSuccess:@"注册成功"];
        }
        else{
//            [MBProgressHUD showError:@"注册失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
//    [signUpManager POST:signUpURL parameters:parameters2 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (responseObject[@"data"]) {
//            NSLog(@"Success: %@", responseObject[@"data"]);
//            NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
//            [mydefaults setObject:responseObject[@"data"][@"token"] forKey:@"Authorization"];
//            [mydefaults setObject:self.phoneNumber.text forKey:@"userName"];
//            [mydefaults setObject:responseObject[@"data"][@"user"][@"type"] forKey:@"user_type"];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            [MBProgressHUD showSuccess:@"注册成功"];
//        }
//        else{
//            [MBProgressHUD showError:@"注册失败"];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}
@end

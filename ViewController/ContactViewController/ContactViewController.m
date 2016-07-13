//
//  ContactViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/17.
//  Copyright © 2015年 fengyibo. All rights reserved.
//
#import "AFNetworking.h"
#import "ContactViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
//#import "MBProgressHUD+MJ.h"
//#import "MBProgressHUD+Add.h"
//#define reqURL @"http://120.26.55.28:5053/v1/req"

@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *owner;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)next:(id)sender;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)next:(id)sender {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"requirement.plist"];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:fileName];
  
    
    NSLog(@"%@",data);
    
    NSNumber *categoryID = [NSNumber numberWithInteger:[[data objectForKey:@"category_id"] integerValue]];
    NSLog(@"%@",categoryID);
    if ([categoryID intValue]>=2) {
        categoryID = [NSNumber numberWithInteger:[[data objectForKey:@"category_id"] integerValue]+3];
    }
    
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSString *Authorization = [myDefaults objectForKey:@"Authorization"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
    NSDictionary *parameters = @{@"name":[data objectForKey:@"name"],@"info":[data objectForKey:@"info"],@"category_id":categoryID,@"period":[data objectForKey:@"period"],@"cost":[data objectForKey:@"cost"],@"owner":self.owner.text,@"contact":self.contact.text,@"email":self.email.text,@"reference":@"1"};
    NSString *reqURL;
    if (![self.data_id isEqualToString:@""]) {
        reqURL = [NSString stringWithFormat:@"http://120.26.55.28:5053/v1/req/%@",self.data_id];
        NSLog(@"buweikong%@",self.data_id);
    }
    else{
        reqURL = @"http://120.26.55.28:5053/v1/req";
    }
    
    [manager POST:reqURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"data"][@"id"]){
            NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
            NSArray *arr = [mydefault objectForKey:@"test1"];
            NSMutableArray *marr = [[NSMutableArray alloc] initWithArray:[mydefault objectForKey:@"test2"]];
            
            [marr insertObject:responseObject[@"data"][@"id"] atIndex:marr.count];
            
            [mydefault setObject:arr forKey:@"test1"];
            [mydefault setObject:marr forKey:@"test2"];
            [mydefault synchronize];
            
//            [MBProgressHUD s]
//            [MBProgressHUD showSuccess:@"发布成功"];
        }
        else{
//            [MBProgressHUD showError:@"发布失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end

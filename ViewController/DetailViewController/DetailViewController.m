//
//  DetailViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/17.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "DetailViewController.h"
#import "ContactViewController.h"

@interface DetailViewController ()
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *info;
@property (weak, nonatomic) IBOutlet UITextField *period;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearKeyboard)]];
}
//添加观察者
- (void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
//从通知中心删除观察者
- (void)viewDidDisappear:(BOOL)animated{
    
}

- (void)disappearKeyboard{
    [self.view endEditing:YES];
}
#pragma mark - 弹起放下输入框
- (void)openKeyboard:(NSNotification *)notification{
    //将输入框弹起
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
        self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-keyboardFrame.size.height);
        self.scrollView.contentOffset = CGPointMake(0, 100);
    } completion:nil];
}

- (void)closeKeyboard:(NSNotification *)notification{
    //将输入框放下
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
            self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.scrollView.contentOffset = CGPointMake(0, -64);
    } completion:nil];
}

#pragma mark - 下一步
- (IBAction)next:(id)sender {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"requirement.plist"];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:fileName];
    NSString *category_id = [data objectForKey:@"category_id"];
    NSString *cost = [data objectForKey:@"cost"];
    
    NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
    [reqDic setObject:self.name.text forKey:@"name"];
    [reqDic setObject:self.info.text forKey:@"info"];
    [reqDic setObject:self.period.text forKey:@"period"];
    [reqDic setObject:category_id forKey:@"category_id"];
    [reqDic setObject:cost forKey:@"cost"];
    [reqDic writeToFile:fileName atomically:YES];
    
    ContactViewController *cVC = [[ContactViewController alloc] init];
    cVC.data_id = self.data_id;
    cVC.title = self.title;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    [self.navigationController pushViewController:cVC animated:YES];
}
//- (IBAction)name:(id)sender {
//    [sender resignFirstResponder];
//}

@end

//
//  FeedbackViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/16.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈意见给我们";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

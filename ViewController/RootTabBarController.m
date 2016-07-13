//
//  RootTabBarController.m
//  铁杆
//
//  Created by fengyibo on 16/1/25.
//  Copyright © 2016年 fengyibo. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) UIButton *mainButton;
@property (nonatomic,strong) UITabBar *myTabBar;
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup
- (void) setup{
    //添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    self.delegate = self;
    self.selectedIndex = 0;
    self.mainButton.selected = NO;
    self.tabBar.tintColor = [UIColor colorWithRed:222/255.0 green:78/255.0 blue:22/255.0 alpha:1];
}

#pragma mark - addCenterButton
- (void) addCenterButtonWithImage:(UIImage *)buttonImage selectedImage:(UIImage *)selectedImage{
    self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mainButton addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    self.mainButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //设定button大小为适应图片
    self.mainButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [self.mainButton setImage:buttonImage forState:UIControlStateNormal];
    [self.mainButton setImage:selectedImage forState:UIControlStateSelected];
    
    //去掉选中button时候的阴影
    self.mainButton.adjustsImageWhenHighlighted = NO;
    
    //设置button的center 和 tabbar的center 做对齐操作，同时作出相对上浮
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0) {
        self.mainButton.center = self.tabBar.center;
    }
    else{
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        self.mainButton.center = center;
    }
    [self.view addSubview:self.mainButton];
}

- (void) pressChange:(id)sender{
    self.selectedIndex = 2;
    self.mainButton.selected = YES;
}

#pragma mark - TabBar Delegate
- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (self.selectedIndex == 2) {
        self.mainButton.selected = YES;
    }
    else{
        self.mainButton.selected = NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end







































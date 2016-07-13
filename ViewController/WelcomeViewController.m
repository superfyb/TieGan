//
//  WelcomeViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/10.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "WelcomeViewController.h"
//#import "CYLTabBarControllerConfig.h"
#import "LLTabBar.h"
#import "LLTabBarItem.h"
#import "HomeViewController.h"
#import "DiscoveryViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "FreeViewController.h"
#import "CustomViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate,LLTabBarDelegate,UIActionSheetDelegate>
//存储所有欢迎界面的图片名
@property (nonatomic,strong)NSArray *allImageNames;
@property (nonatomic,strong)UIPageControl *pageControl;
@end

@implementation WelcomeViewController

- (NSArray *)allImageNames{
    if (!_allImageNames) {
        _allImageNames = @[@"Welcome_3.0_1@2x副本",@"Welcome_3.0_2@2x副本",@"Welcome_3.0_3@2x副本"];
    }
    return _allImageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    //设置可显示的区域
    scrollView.frame = [UIScreen mainScreen].bounds;
    //设置内容区域
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*self.allImageNames.count, [UIScreen mainScreen].bounds.size.height);
    //设置滚动视图的内容视图
    //将所有的图片显示到图片视图中，并添加到视图里
    for (NSUInteger i = 0; i<self.allImageNames.count; i++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.allImageNames[i]]];
        CGRect frame = CGRectZero;
        frame.size = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
        frame.origin = CGPointMake(i*scrollView.frame.size.width, 0);
        imageView.frame = frame;
        
        //添加到滚动视图中
        [scrollView addSubview:imageView];
    }
    //设置滚动视图整页滚动
    scrollView.pagingEnabled = YES;
    //设置滚动视图的水平滚动提示不可见
    scrollView.showsHorizontalScrollIndicator = NO;
    //将滚动视图添加到self.view
    [self.view addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/2, [UIScreen mainScreen].bounds.size.height-70, 0, 30);
    //配置pageControl
    pageControl.numberOfPages = self.allImageNames.count;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //取消用户交互
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
    //添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((self.allImageNames.count-1)*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [button addTarget:nil action:@selector(gotoNext:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint p = scrollView.contentOffset;
    NSUInteger index = p.x/self.view.frame.size.width;
    self.pageControl.currentPage = index;
}

-(void)gotoNext:(UIButton *)sender{
//    
//    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
//    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarControllerConfig.tabBarController;
//    [self presentViewController:tabBarControllerConfig.tabBarController animated:YES completion:nil];
    
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    DiscoveryViewController *discoveryViewController = [[DiscoveryViewController alloc] init];
    MessageViewController *messageViewController = [[MessageViewController alloc] init];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[homeViewController, discoveryViewController, messageViewController, mineViewController];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabbarController.tabBar.bounds];
    
    CGFloat normalButtonWidth = ([UIScreen mainScreen].bounds.size.width * 3 / 4) / 4;
    CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
    CGFloat publishItemWidth = ([UIScreen mainScreen].bounds.size.width / 4);
    
    LLTabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"首页"
                                       normalImageName:@"home_normal"
                                     selectedImageName:@"3" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"发现"
                                           normalImageName:@"mycity_normal"
                                         selectedImageName:@"1" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                    title:@"发布"
                                          normalImageName:@"5"
                                        selectedImageName:@"5" tabBarItemType:LLTabBarItemRise];
    [publishItem addTarget:self action:@selector(tabBarDidSelectedRiseButton) forControlEvents:UIControlEventTouchUpInside];
    LLTabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                    title:@"消息"
                                          normalImageName:@"message_normal"
                                        selectedImageName:@"2" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"我的"
                                       normalImageName:@"account_normal"
                                     selectedImageName:@"4" tabBarItemType:LLTabBarItemNormal];
    
    tabBar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
    tabBar.delegate = self;
    
    [tabbarController.tabBar addSubview:tabBar];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = tabbarController;
}

- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}

#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton {
//    NSLog(@"有响应");
//    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//    UIViewController *viewController = tabBarController.selectedViewController;
//
//    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:nil];
//    [actionController addAction:alertAction1];
//    [actionController addAction:alertAction2];
//    [actionController addAction:alertAction3];
//    [viewController presentViewController:actionController animated:YES completion:nil];
    UITabBarController *tabBarController = self.tabBarController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    //遮罩
    self.view.hidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.96];
    self.view.frame = [UIScreen mainScreen].bounds;
    [viewController.view addSubview:self.view];
    //    tabBarController.tabBar.hidden = YES;
    tabBarController.tabBar.alpha = 0.1;
    tabBarController.tabBar.userInteractionEnabled = NO;
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width/2.0)-28.5, [UIScreen mainScreen].bounds.size.height-77, 57, 51);
    [self.view addSubview:cancelButton];
    
    UIButton *freeButton = [[UIButton alloc] init];
    [freeButton addTarget:self action:@selector(freeDevelop) forControlEvents:UIControlEventTouchUpInside];
    [freeButton setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    freeButton.frame = CGRectMake(40, [UIScreen mainScreen].bounds.size.height-250, 100, 100);
    [self.view addSubview:freeButton];
    
    UILabel *freeLabel = [[UILabel alloc] init];
    freeLabel.frame = CGRectMake(40, [UIScreen mainScreen].bounds.size.height-150, 100, 35);
    freeLabel.text = @"免费开发";
    freeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:freeLabel];
    
    UIButton *customButton = [[UIButton alloc] init];
    [customButton addTarget:self action:@selector(customDevelop) forControlEvents:UIControlEventTouchUpInside];
    [customButton setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    customButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-140, [UIScreen mainScreen].bounds.size.height-250, 100, 100);
    [self.view addSubview:customButton];
    
    UILabel *customLabel = [[UILabel alloc] init];
    customLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-140, [UIScreen mainScreen].bounds.size.height-150, 100, 35);
    customLabel.text = @"定制开发";
    customLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:customLabel];
}

- (void)back{
    self.view.hidden = YES;
    
    self.tabBarController.tabBar.alpha = 1;
    self.tabBarController.tabBar.userInteractionEnabled = YES;
}

- (void)freeDevelop{
    [self back];
    UITabBarController *tabBarController = self.tabBarController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    FreeViewController *fVC = [[FreeViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:fVC];
    [viewController presentViewController:navi animated:YES completion:nil];
}

- (void)customDevelop{
    [self back];
    UITabBarController *tabBarController = self.tabBarController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    CustomViewController *cVC = [[CustomViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:cVC];
    
    
    [viewController presentViewController:navi animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
}
@end

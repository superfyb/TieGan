//
//  AppDelegate.m
//  TieGan
//
//  Created by fengyibo on 15/11/10.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "LLTabBar.h"
#import "LLTabBarItem.h"
#import "HomeViewController.h"
#import "DiscoveryViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "CustomViewController.h"
#import "FreeViewController.h"
#import "TGConst.h"
#import "EaseMob.h"
#import "RootTabBarController.h"

@interface AppDelegate ()<LLTabBarDelegate,UIActionSheetDelegate>
@property (nonatomic,strong)UIView *publishView;
@property (nonatomic,strong)UIImageView *addImageView;
@end

@implementation AppDelegate

@synthesize Authorization;

- (UIView *)publishView{
    if (!_publishView) {
        _publishView = [[UIView alloc] init];
    }
    return _publishView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册环信
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"pl#tiegan" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[EaseSDKHelper shareHelper] easemobApplication:application didFinishLaunchingWithOptions:launchOptions appkey:@"pl#tiegan" apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //设置navigationbar
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [UINavigationBar appearance].barTintColor = TGNAVI;
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //判断是否为第一次打开程序
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [self showGuideView];
    }
    else{
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        DiscoveryViewController *discoveryViewController = [[DiscoveryViewController alloc] init];
//        MessageViewController *messageViewController = [[MessageViewController alloc] init];
        EaseConversationListViewController *chatListVC = [[EaseConversationListViewController alloc] init];
        UINavigationController *naviChat = [[UINavigationController alloc] initWithRootViewController:chatListVC];
        MineViewController *mineViewController = [[MineViewController alloc] init];
        UINavigationController *naviMine = [[UINavigationController alloc] initWithRootViewController:mineViewController];
        
        //设置TabBar
        UITabBarController *tabbarController = [[UITabBarController alloc] init];
        tabbarController.viewControllers = @[homeViewController, discoveryViewController, naviChat, naviMine];
        
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        
        LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabbarController.tabBar.bounds];
        
        CGFloat normalButtonWidth = ([UIScreen mainScreen].bounds.size.width * 3 / 4) / 4;
        CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
        CGFloat publishItemWidth = ([UIScreen mainScreen].bounds.size.width / 4);
        
        LLTabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"首页"
                                           normalImageName:@"tabbar_home"
                                         selectedImageName:@"tabbar_home_selected" tabBarItemType:LLTabBarItemNormal];
        LLTabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                         title:@"发现"
                                               normalImageName:@"tabbar_discovery"
                                             selectedImageName:@"tabbar_discovery_selected" tabBarItemType:LLTabBarItemNormal];
        LLTabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                        title:@"发布"
                                              normalImageName:@"post_normal"
                                            selectedImageName:@"post_normal" tabBarItemType:LLTabBarItemRise];
        UIImageView *addImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页-15"]];
        self.addImageView = addImageView;
        addImageView.frame = CGRectMake(19.5, 17, 25, 25);
        [publishItem.imageView addSubview:addImageView];
        
        LLTabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                        title:@"消息"
                                              normalImageName:@"tabbar_message"
                                            selectedImageName:@"tabbar_message_selected" tabBarItemType:LLTabBarItemNormal];
        LLTabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"我的"
                                           normalImageName:@"tabbar_mine"
                                         selectedImageName:@"tabbar_mine_selected" tabBarItemType:LLTabBarItemNormal];
        
        tabBar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
        tabBar.delegate = self;
        [tabbarController.tabBar addSubview:tabBar];
        self.window.rootViewController = tabbarController;
    }
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) showGuideView{
    WelcomeViewController *wvc = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:nil];
    self.window.rootViewController = wvc;
}

- (void) removeGuide{
#warning TODO
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

#pragma mark - LLTabBarDelegate(发布界面)
- (void)tabBarDidSelectedRiseButton {
    self.addImageView.transform = CGAffineTransformMakeRotation(45*M_PI/180.0);
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;

    //发布界面
    self.publishView.hidden = NO;
    self.publishView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.96];
    self.publishView.frame = [UIScreen mainScreen].bounds;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = @"rippleEffect";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = viewController;
    [viewController.view.layer addAnimation:transition forKey:nil];
    [viewController.view addSubview:self.publishView];
    tabBarController.tabBar.alpha = 0.1;
    tabBarController.tabBar.userInteractionEnabled = NO;
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"图标-14"] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width/2.0)-20, [UIScreen mainScreen].bounds.size.height-61, 38, 38);
    [self.publishView addSubview:cancelButton];
    
    UIImageView *addView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页-15"]];
        addView.frame = CGRectMake(6.5, 6.5, 25, 25);
    addView.transform = CGAffineTransformMakeRotation(0);
    [cancelButton addSubview:addView];

    [UIView animateWithDuration:0.2
                         animations:^{
                             addView.transform = CGAffineTransformMakeRotation(45*M_PI/180.0);
                         }];
    
    UIButton *freeButton = [[UIButton alloc] init];
    [freeButton addTarget:self action:@selector(freeDevelop) forControlEvents:UIControlEventTouchUpInside];
    [freeButton setBackgroundImage:[UIImage imageNamed:@"ic_publish_normal"] forState:UIControlStateNormal];
    freeButton.frame = CGRectMake(40, [UIScreen mainScreen].bounds.size.height-250, 100, 100);
    [self.publishView addSubview:freeButton];
    
    UILabel *freeLabel = [[UILabel alloc] init];
    freeLabel.frame = CGRectMake(40, [UIScreen mainScreen].bounds.size.height-150, 100, 35);
    freeLabel.text = @"普通开发";
    freeLabel.textAlignment = NSTextAlignmentCenter;
    [self.publishView addSubview:freeLabel];
    
    UIButton *customButton = [[UIButton alloc] init];
    [customButton addTarget:self action:@selector(customDevelop) forControlEvents:UIControlEventTouchUpInside];
    [customButton setBackgroundImage:[UIImage imageNamed:@"ic_publish_custom"] forState:UIControlStateNormal];
    customButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-140, [UIScreen mainScreen].bounds.size.height-250, 100, 100);
    [self.publishView addSubview:customButton];

    UILabel *customLabel = [[UILabel alloc] init];
    customLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-140, [UIScreen mainScreen].bounds.size.height-150, 100, 35);
    customLabel.text = @"定制开发";
    customLabel.textAlignment = NSTextAlignmentCenter;
    [self.publishView addSubview:customLabel];
}

//返回按钮
- (void)back{
    self.publishView.hidden = YES;
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.addImageView.transform = CGAffineTransformMakeRotation(0);
                     }];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    tabBarController.tabBar.alpha = 1;
    tabBarController.tabBar.userInteractionEnabled = YES;
}

//普通开发
- (void)freeDevelop{
    [self back];
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    FreeViewController *fVC = [[FreeViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:fVC];

    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromLeft;
    [viewController.view.window.layer addAnimation:animation forKey:nil];
    [viewController presentViewController:navi animated:NO completion:nil];
}

//定制开发
- (void)customDevelop{
    [self back];
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    CustomViewController *cVC = [[CustomViewController alloc] init];
    cVC.data_id = @"";
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:cVC];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromLeft;
    [viewController.view.window.layer addAnimation:animation forKey:nil];
    [viewController presentViewController:navi animated:NO completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //进入后台
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    application.applicationIconBadgeNumber = 11;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //App将要从后台反回
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //申请处理时间
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    [self saveContext];
}

#pragma mark - 3d touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"publish"]) {
//        tabBarController.selectedViewController = self
        [self tabBarDidSelectedRiseButton];
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-.TieGan" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TieGan" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TieGan.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end

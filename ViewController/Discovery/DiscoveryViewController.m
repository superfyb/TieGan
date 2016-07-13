//
//  LLSameCityViewController.m
//  LLRiseTabBarDemo
//
//  Created by HelloWorld on 10/18/15.
//  Copyright © 2015 melody. All rights reserved.
//

#import "ShopViewController.h"
#import "MarketingViewController.h"
#import "WeChatViewController.h"
#import "ProjectViewController.h"
#import "ShopViewController.h"
#import "HTML5ViewController.h"
#import "DiscoveryViewController.h"
#import "WMPageController.h"
#import "FreeViewController.h"
#import "loginViewController.h"
#import "TGConst.h"
#import "CompanyTableViewController.h"
#import "GeniusTableViewController.h"
#import "APPTableViewController.h"
#import "ExampleTableViewController.h"
#import "TraditionalTableViewController.h"
#import "AFNetworking.h"
#import "AllClassViewController.h"

@interface DiscoveryViewController ()

@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;
@property (strong,nonatomic) WMPageController *entrepreneurViewController;
@property (strong,nonatomic) WMPageController *programmerViewController;
@end

@implementation DiscoveryViewController

- (WMPageController *)entrepreneurViewController{
    if (!_entrepreneurViewController) {
//        self.ContentView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        NSArray *class = [NSArray arrayWithObjects:[TraditionalTableViewController class],[CompanyTableViewController class],[ExampleTableViewController class], nil];
        NSArray *title = [NSArray arrayWithObjects:@"传统企业",@"创业公司",@"铁杆榜", nil];
        _entrepreneurViewController.view.bounds = self.ContentView.bounds;
        _entrepreneurViewController = [[WMPageController alloc] initWithViewControllerClasses:class andTheirTitles:title];
        _entrepreneurViewController.titleColorSelected = TGNAVI;
        _entrepreneurViewController.menuViewStyle = WMMenuViewStyleLine;
        _entrepreneurViewController.itemsWidths = @[@100,@100,@100];
        NSLog(@"1");
    }
    return _entrepreneurViewController;
}

- (WMPageController *)programmerViewController{
    if (!_programmerViewController) {
        NSArray *class = [NSArray arrayWithObjects:[AllClassViewController class],[WeChatViewController class],[HTML5ViewController class],[APPTableViewController class],[ProjectViewController class],[MarketingViewController class],[ShopViewController class], nil];
        NSArray *title = [NSArray arrayWithObjects:@"所有类型",@"微信开发",@"网站开发",@"APP开发",@"设计",@"营销",@"商城", nil];
        _programmerViewController.view.bounds = self.ContentView.bounds;
        _programmerViewController = [[WMPageController alloc] initWithViewControllerClasses:class andTheirTitles:title];
        _programmerViewController.titleColorSelected = TGNAVI;
        _programmerViewController.menuViewStyle = WMMenuViewStyleLine;
        _programmerViewController.itemsWidths = @[@100,@100,@100,@100,@100,@100,@100];
    }


    return _programmerViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ContentView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    [self.SegmentedControl addTarget:self action:@selector(SegmentedControlChange) forControlEvents:UIControlEventValueChanged];
//    [self.ContentView addSubview:self.entrepreneurViewController.view];
    [self SegmentedControlChange];
}

- (void)SegmentedControlChange{
    if (self.SegmentedControl.selectedSegmentIndex == 0) {
        [self.programmerViewController removeFromParentViewController];
        [self.ContentView addSubview:self.entrepreneurViewController.view];
    }
    else{
        self.programmerViewController.view.frame = self.entrepreneurViewController.view.frame;
        [self.entrepreneurViewController removeFromParentViewController];
        [self.ContentView addSubview:self.programmerViewController.view];
    }
}


@end

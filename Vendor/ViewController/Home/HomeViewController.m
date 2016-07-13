//
//  LLHomeViewController.m
//  LLRiseTabBarDemo
//
//  Created by HelloWorld on 10/18/15.
//  Copyright © 2015 melody. All rights reserved.
//
#import "TGConst.h"
#import "HomeViewController.h"
#import "LLTabBarItem.h"
#import "LLTabBar.h"
#import "ButtonViewController.h"
#import "AFNetworking.h"
#import "JTNumberScrollAnimatedView.h"

@interface HomeViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
- (IBAction)scanButton:(id)sender;
@property (weak,nonatomic) IBOutlet JTNumberScrollAnimatedView *animatedView;
@property (strong,nonatomic) UINavigationController *navi;
/*  按钮位置
 1、APP － 2、商城 － 3、微信
 4、网站 － 5、设计 － 6、营销
 */

- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;
- (IBAction)button6:(id)sender;
- (IBAction)analyzeButton:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height1;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondViewTopToSuperView;
//存储所有欢迎界面的图片名
@property (nonatomic,strong)NSArray *allImageNames;
@property (nonatomic,strong)UIPageControl *pageControl;
@end

@implementation HomeViewController

- (NSArray *)allImageNames{
    if (!_allImageNames) {
        _allImageNames = @[@"sy1",@"656453357937731894",@"sy4",@"sy1"];
    }
    return _allImageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置第一个View的宽高比
    self.imageViewWeight.constant = [UIScreen mainScreen].bounds.size.width*50.0/375.0;
    self.height1.constant = [UIScreen mainScreen].bounds.size.width*186.0/375.0;
    self.height2.constant = [UIScreen mainScreen].bounds.size.width*106.0/375.0;
    self.secondViewTopToSuperView.constant = [UIScreen mainScreen].bounds.size.width*180.0/375.0;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*180.0/375.0);
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3,180);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.contentView addSubview:scrollView];
    
    //轮播图自动切换
    NSTimeInterval timeInterval = 3.0;
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateScrollView) userInfo:nil repeats:YES];

    //设置滚动视图的内容视图
    //将所有的图片显示到图片视图中，并添加到视图里
    for (NSUInteger i = 0; i<self.allImageNames.count; i++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.allImageNames[i]]];
        imageView.contentMode = UIViewContentModeScaleToFill;
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
    [self.contentView addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/2,self.secondViewTopToSuperView.constant-30, 0, 30);
    //配置pageControl
    pageControl.numberOfPages = self.allImageNames.count-1;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //取消用户交互
    pageControl.userInteractionEnabled = NO;
    [self.contentView addSubview:pageControl];
    
    self.animatedView.textColor = [UIColor orangeColor];
    self.animatedView.font = [UIFont boldSystemFontOfSize:19];
    [self.animatedView setValue:@563912];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.animatedView startAnimation];
}

//轮播图小圆点
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint p = scrollView.contentOffset;
    NSUInteger index = p.x/self.view.frame.size.width;
    self.pageControl.currentPage = index;
}

#pragma mark - 轮播图自动滚动
- (void)updateScrollView{
    if (self.scrollView.contentOffset.x == (self.allImageNames.count-1)*[UIScreen mainScreen].bounds.size.width) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    [UIView animateWithDuration:0.5 animations:^{
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x+[UIScreen mainScreen].bounds.size.width, 0);
        if (self.scrollView.contentOffset.x == (self.allImageNames.count-1)*[UIScreen mainScreen].bounds.size.width) {
            self.pageControl.currentPage = 0;
        }
    }];
}

#pragma mark - 六个按钮
/*  按钮位置
 1、APP － 2、商城 － 3、微信
 4、网站 － 5、设计 － 6、营销
 */

//APP
- (IBAction)button1:(id)sender {
    [self setButton:1];
}

//商城
- (IBAction)button2:(id)sender {
    [self setButton:2];
}

//微信
- (IBAction)button3:(id)sender {
    [self setButton:3];
}

//网站
- (IBAction)button4:(id)sender {
    [self setButton:4];
}

//设计
- (IBAction)button5:(id)sender {
    [self setButton:5];
}

//营销
- (IBAction)button6:(id)sender {
    [self setButton:6];
}

- (void) setButton:(NSInteger)i{
    ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:buttonVC];
    navi.view.tag = i;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    
    [manager GET:@"http://120.26.55.28:5053/v1/categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        buttonVC.modelArray = [NSMutableArray array];
        buttonVC.modelArray = responseObject[@"data"][i-1][@"tools"];
        [buttonVC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.25;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:navi animated:NO completion:nil];
}

- (IBAction)analyzeButton:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    NSURL *url = [[NSURL alloc] initWithString:@"http://mp.weixin.qq.com/s?__biz=MzI3MDA2OTA3MQ==&mid=400671134&idx=1&sn=fae870e3e100c8b9f4ed67ac4877129e#rd"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [vc.view addSubview:webView];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.navi = navi;
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    vc.title = @"火爆应用";
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:navi animated:NO completion:nil];
}

- (void)back{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.navi.view.window.layer addAnimation:animation forKey:nil];
    [self.navi dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)scanButton:(id)sender {
}
@end

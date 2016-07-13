//
//  ToolsDetailController.m
//  铁杆
//
//  Created by fengyibo on 15/12/4.
//  Copyright © 2015年 fengyibo. All rights reserved.
//
#import "FreeViewController.h"
#import "ToolsDetailController.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"

@interface ToolsDetailController ()<UIWebViewDelegate>
- (IBAction)selfDevelop:(id)sender;
- (IBAction)crowdsourcing:(id)sender;
- (IBAction)customDevelop:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ToolsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.introduceLabel.text = self.introduceText;
    [self.iconImage sd_setImageWithURL:self.imageUrl];
    
    NSLog(@"%@",self.introduceText);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];

    NSURL *url;
    if ([self.title isEqualToString:@"叮当"]) {
        url = [[NSURL alloc] initWithString:@"http://www.dingdone.com/wap/#slide_2"];
        self.introduceLabel.text = @"从命名到生成，APP创作一气呵成，无需编程，无需设计，无需开发，无需外包";
    }
    else if ([self.title isEqualToString:@"测试兄弟"]){
        url = [[NSURL alloc] initWithString:@"http://testbrother.cn/"];
        self.introduceLabel.text = @"让测试变得更简单，自动测试APP安装，运行，卸载；精准定位BUG。";
    }
    else if ([self.title isEqualToString:@"好应用"]){
        url = [[NSURL alloc] initWithString:@"http://www.okayapps.com/"];
        self.introduceLabel.text = @"让移动开发更简单；强力的开发框架，代码无需从零开发。";
    }
    else if ([self.title isEqualToString:@"小猪cms"]){
        url = [[NSURL alloc] initWithString:@"http://www.pigcms.com/"];
        self.introduceLabel.text = @"云微客小猪微信cms 一站式管理，海量网站模板，独有行业功能，让企业微营销如虎添翼小猪微信cms，1-5天轻松完成建站，1分钟开启微信营销!";
    }
    else if ([self.title isEqualToString:@"易企秀"]){
        url = [[NSURL alloc] initWithString:@"http://eqxiu.com/"];
        self.introduceLabel.text = @"免费H5页面移动微场景应用制作与自营销管家,免费为中小微企业或团队提供H5页面场景应用制作、设计师秀客H5微场景定制、场景推广展示。";
    }
    else{
        url = [[NSURL alloc] initWithString:@"http://xiumi.us/"];
        self.introduceLabel.text = @"一个移动端内容制作和发布平台,提供丰富的模板和好用的体验,让你快速制作出极具新意的内容,打动你的人群!";
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
//    [super dealloc];
    self.webView.delegate = nil;
}

//返回上一界面
- (void)back{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    if ([self.parentViewController.title isEqualToString:@"叮当"]||[self.parentViewController.title isEqualToString:@"测试兄弟"]||[self.parentViewController.title isEqualToString:@"好应用"]||[self.parentViewController.title isEqualToString:@"小猪cms"]||[self.parentViewController.title isEqualToString:@"易企秀"]||[self.parentViewController.title isEqualToString:@"秀米"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self.webView stopLoading];
}

- (IBAction)selfDevelop:(id)sender {
    UIViewController *webVC = [[UIViewController alloc] init];
    if ([self.title isEqualToString:@"叮当"]) {
        webVC.title = @"叮当";
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = self.view.bounds;
        webView.delegate = self;
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.dingdone.com/wap/#slide_2"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        [webVC.view addSubview:webView];
    }
    else{
        webVC.title = @"免费工具";
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = self.view.bounds;
        webView.delegate = self;
        NSURL *url = [[NSURL alloc] initWithString:@"http://mp.weixin.qq.com/s?__biz=MzI3MDA2OTA3MQ==&mid=400609393&idx=1&sn=dbe87229fe82f2b97d377efa5df6bd17#rd"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        [webVC.view addSubview:webView];
    }
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)crowdsourcing:(id)sender {
    FreeViewController *fVC = [[FreeViewController alloc] init];
    fVC.toolsString = self.title;
    [self.navigationController pushViewController:fVC animated:YES];
}

- (IBAction)customDevelop:(id)sender {
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    if ([[mydefaults objectForKey:@"Authorization"] isEqualToString:@""]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:@"tiegan" conversationType:eConversationTypeChat];
        chatController.title = @"铁杆客服";
        [self.navigationController pushViewController:chatController animated:YES];
    }
}
@end

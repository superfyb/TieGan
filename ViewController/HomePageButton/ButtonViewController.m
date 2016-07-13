//
//  ButtonViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/19.
//  Copyright © 2015年 fengyibo. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ButtonViewController.h"
#import "buttonCell.h"
#import "DiscoveryViewController.h"
#import "ToolsDetailController.h"

@interface ButtonViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
//存储所有欢迎界面的图片名
@property (nonatomic,strong)NSArray *allImageNames;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *allCategory;

@end

@implementation ButtonViewController

- (NSArray *)allCategory{
    if (!_allCategory) {
        _allCategory = @[@"APP专区",@"商城专区",@"微信专区",@"网站专区",@"设计专区",@"营销专区"];
    }
    return _allCategory;
}

- (NSArray *)allImageNames{
    if (!_allImageNames) {
        _allImageNames = @[@"127159419405273625",@"656453357937731894",@"754749701278195390",@"127159419405273625"];
    }
    return _allImageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i=1;i<=6;i++) {
        if (self.navigationController.view.tag == i) {
            self.title = self.allCategory[i-1];
        }
    }

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 191);
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3,191);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    //轮播图自动切换
    NSTimeInterval timeInterval = 3.0;
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateScrollView) userInfo:nil repeats:YES];
    
    //设置滚动视图的内容视图
    //将所有的图片显示到图片视图中，并添加到视图里
    for (NSUInteger i = 0; i<self.allImageNames.count; i++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.allImageNames[i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
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
    [self.headView addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/2,159, 0, 30);
    //配置pageControl
    pageControl.numberOfPages = self.allImageNames.count-1;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //取消用户交互
    pageControl.userInteractionEnabled = NO;
    [self.headView addSubview:pageControl];
}

//返回上一界面
- (void)back{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    buttonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"buttonCell" owner:self options:nil] lastObject];
    }
    cell.nameLabel.text = self.modelArray[indexPath.section][@"name"];
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://120.26.55.28:5051%@",self.modelArray[indexPath.section][@"icon_img"]]]];
    cell.introLabel.text = self.modelArray[indexPath.section][@"info"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    buttonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    toolsVC.introduceText = cell.introLabel.text;
    NSLog(@"tool%@",toolsVC.introduceLabel.text);
    toolsVC.title = self.modelArray[indexPath.section][@"name"];
    toolsVC.imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.26.55.28:5051%@",self.modelArray[indexPath.section][@"icon_img"]]];
    [self.navigationController pushViewController:toolsVC animated:YES];
}

@end

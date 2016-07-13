//
//  ExampleTableViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/20.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "ExampleTableViewController.h"
#import "ExampleCell.h"
#import "ToolsDetailController.h"

@interface ExampleTableViewController ()

//存储所有欢迎界面的图片名
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong)NSArray *allImageNames;
@property (nonatomic,strong)UIPageControl *pageControl;

@end

@implementation ExampleTableViewController

- (NSArray *)allImageNames{
    if (!_allImageNames) {
        _allImageNames = @[@"127159419405273625",@"656453357937731894",@"754749701278195390"];
    }
    return _allImageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 191);
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3,191);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
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
    pageControl.numberOfPages = self.allImageNames.count;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //取消用户交互
    pageControl.userInteractionEnabled = NO;
    [self.headView addSubview:pageControl];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint p = scrollView.contentOffset;
    NSUInteger index = p.x/self.view.frame.size.width;
    self.pageControl.currentPage = index;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     ExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExampleCell"];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExampleCell" owner:self options:nil] lastObject];
        if (indexPath.section == 0) {
            [cell.firstButton addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
            [cell.secondButton addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
            [cell.thirdButton addTarget:self action:@selector(button3) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            cell.firstLabel.text = @"小猪cms";
            cell.firstImage.image = [UIImage imageNamed:@"小猪cms(1)"];
            cell.secondLabel.text = @"易企秀";
            cell.secondImage.image = [UIImage imageNamed:@"秀米2"];
            cell.thirdLabel.text = @"秀米";
            cell.thirdImage.image = [UIImage imageNamed:@"易企秀(1)"];
            [cell.firstButton addTarget:self action:@selector(button4) forControlEvents:UIControlEventTouchUpInside];
            [cell.secondButton addTarget:self action:@selector(button5) forControlEvents:UIControlEventTouchUpInside];
            [cell.thirdButton addTarget:self action:@selector(button6) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - button
//叮当
- (void)button1{
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:toolsVC];
    toolsVC.title = @"叮当";
    toolsVC.imageUrl = [NSURL URLWithString:@"http://120.26.55.28:5051/res/upload/2/5d/1448372834.png"];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

//测试兄弟
- (void)button2{
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:toolsVC];
    toolsVC.title = @"测试兄弟";
    toolsVC.imageUrl = [NSURL URLWithString:@"http://120.26.55.28:5051/res/upload/2/37/1448371526.png"];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

//好应用
- (void)button3{
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:toolsVC];
    toolsVC.title = @"好应用";
    toolsVC.imageUrl = [NSURL URLWithString:@"http://120.26.55.28:5051/res/upload/2/f1/1448369931.png"];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

//小猪cms
- (void)button4{
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:toolsVC];
    toolsVC.title = @"小猪cms";
    toolsVC.imageUrl = [NSURL URLWithString:@"http://120.26.55.28:5051/res/upload/2/eb/1450269634.png"];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

//易企秀
- (void)button5{
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:toolsVC];
    toolsVC.title = @"易企秀";
    toolsVC.imageUrl = [NSURL URLWithString:@"http://120.26.55.28:5051/res/upload/2/72/1450269878.png"];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

//秀米
- (void)button6{
    ToolsDetailController *toolsVC = [[ToolsDetailController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:toolsVC];
    toolsVC.title = @"秀米";
    toolsVC.imageUrl = [NSURL URLWithString:@"http://120.26.55.28:5051/res/upload/2/e2/1450264280.png"];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:navi animated:YES completion:nil];
}

@end

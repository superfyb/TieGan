//
//  FreeViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/17.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "FreeViewController.h"
#import "DetailViewController.h"

@interface FreeViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIView *coverView;
@property (strong,nonatomic) NSArray *classArray;
@property (strong,nonatomic) NSArray *timeArray;
@property (strong,nonatomic) NSArray *toolsArray;
@property (strong,nonatomic) NSString *classString;
@property (strong,nonatomic) NSString *timeString;

@end

@implementation FreeViewController

- (NSString *)classString{
    if (!_classString) {
        _classString = [[NSString alloc] init];
    }
    return _classString;
}

- (NSString *)timeString{
    if (!_timeString) {
        _timeString = [[NSString alloc] init];
    }
    return _timeString;
}

- (NSString *)toolsString{
    if (!_toolsString) {
        _toolsString = [[NSString alloc] init];
    }
    return _toolsString;
}

- (NSArray *)toolsArray{
    if (!_toolsArray) {
        _toolsArray = [[NSArray alloc] initWithObjects:@"",@"叮当",@"测试兄弟",@"好应用",@"魔坛",@"微讯",@"易企秀", nil];
    }
    return _toolsArray;
}

- (NSArray *)classArray{
    if (!_classArray) {
        _classArray = [[NSArray alloc] initWithObjects:@"",@"app",@"安卓",@"Java",@"C++",@"UI", nil];
    }
    return _classArray;
}

- (NSArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [[NSArray alloc] initWithObjects:@"",@"1天",@"4天",@"一周",@"两周",@"一个月", nil];
    }
    return _timeArray;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.frame = [UIScreen mainScreen].bounds;
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self.view addSubview:_coverView];
    }
    _coverView.hidden = NO;
    return _coverView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollview.contentSize = CGSizeMake(10, 950);
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.title = @"普通开发";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"项目类型";
        if ([self.classString isEqualToString:@""]) {
            cell.detailTextLabel.text = @"请选择";
        }
        else{
            cell.detailTextLabel.text = self.classString;
        }
    }
    else if(indexPath.row == 1){
        cell.textLabel.text = @"项目周期";
        if ([self.timeString isEqualToString:@""]) {
            cell.detailTextLabel.text = @"请选择";
        }
        else{
            cell.detailTextLabel.text = self.timeString;
        }
    }
    else{
        cell.textLabel.text = @"使用工具";
        if ([self.toolsString isEqualToString:@""]) {
            cell.detailTextLabel.text = @"请选择";
        }
        else{
            cell.detailTextLabel.text = self.toolsString;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIPickerView *classPicker = [[UIPickerView alloc] init];
    if (indexPath.row == 0) {
        classPicker.tag = 1;
    }
    else if(indexPath.row == 1){
        classPicker.tag = 3;
    }
    else{
        classPicker.tag = 2;
    }
    classPicker.backgroundColor = [UIColor whiteColor];
    classPicker.delegate = self;
    classPicker.dataSource = self;
    classPicker.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-200, [UIScreen mainScreen].bounds.size.width, 200);
    [self.coverView addSubview:classPicker];
    
    UIView *cancelView = [[UIView alloc] init];
    cancelView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-250, [UIScreen mainScreen].bounds.size.width, 50);
    cancelView.backgroundColor = [UIColor whiteColor];
    cancelView.alpha = 1;
    [self.coverView addSubview:cancelView];
    
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.frame = CGRectMake(10, 10, 60, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelButton];
    
    UIButton *finishButton = [[UIButton alloc] init];
    finishButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-70, 10, 60, 30);
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:finishButton];
}

- (void)cancel{
    self.coverView.hidden = YES;
}

- (void)finish{
    self.coverView.hidden = YES;
    [self.tableView reloadData];
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return 5;
    }
    else if(pickerView.tag == 3){
        return 6;
    }
    else{
        return 6;
    }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    if (pickerView.tag == 1) {
        return [self.classArray objectAtIndex:row];
    }
    else if(pickerView.tag == 3){
        return [self.timeArray objectAtIndex:row];
    }
    else{
        return [self.toolsArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if (pickerView.tag == 1) {
        self.classString = [self.classArray objectAtIndex:row];
    }
    else if(pickerView.tag == 3){
        self.timeString = [self.timeArray objectAtIndex:row];
    }
    else{
        self.toolsString = [self.toolsArray objectAtIndex:row];
    }
    
}

- (IBAction)next:(id)sender {
    DetailViewController *dVC = [[DetailViewController alloc] init];
    dVC.title = self.title;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    [self.navigationController pushViewController:dVC animated:YES];
}
@end


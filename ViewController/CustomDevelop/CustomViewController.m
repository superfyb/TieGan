//
//  CustomViewController.m
//  TieGan
//
//  Created by fengyibo on 15/11/16.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "CustomViewController.h"
#import "DetailViewController.h"

@interface CustomViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIView *coverView;
@property (strong,nonatomic) NSArray *classArray;
@property (strong,nonatomic) NSArray *timeArray;
@property (strong,nonatomic) NSArray *moneyArray;
@property (strong,nonatomic) NSString *classString;
@property (strong,nonatomic) NSString *timeString;
@property (strong,nonatomic) NSString *moneyString;
@property (strong,nonatomic) UIPickerView *classPicker;
@end

@implementation CustomViewController

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

- (NSString *)moneyString{
    if (!_moneyString) {
        _moneyString = [[NSString alloc] init];
    }
    return _moneyString;
}

- (NSArray *)classArray{
    if (!_classArray) {
        _classArray = [[NSArray alloc] initWithObjects:@"",@"app",@"商城",@"微信",@"网站",@"设计",@"营销", nil];
    }
    return _classArray;
}

- (NSArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [[NSArray alloc] initWithObjects:@"",@"1天",@"4天",@"一周",@"两周",@"一个月", nil];
    }
    return _timeArray;
}

- (NSArray *)moneyArray{
    if (!_moneyArray) {
        _moneyArray = [[NSArray alloc] initWithObjects:@"",@"1万以下",@"1-3万",@"3-5万",@"5万以上", nil];
    }
    return _moneyArray;
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
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.title = @"定制开发";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    
    NSLog(@"presenting%@",self.navigationController.parentViewController.title);
}

- (void)back{
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
        cell.textLabel.text = @"项目预算";
        if ([self.moneyString isEqualToString:@""]) {
            cell.detailTextLabel.text = @"请选择";
        }
        else{
            cell.detailTextLabel.text = self.moneyString;
        }
    }
    else{
        cell.textLabel.text = @"项目周期";
        if ([self.timeString isEqualToString:@""]) {
            cell.detailTextLabel.text = @"请选择";
        }
        else{
            cell.detailTextLabel.text = self.timeString;
        }
    }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIPickerView *classPicker = [[UIPickerView alloc] init];
    self.classPicker = classPicker;
    if (indexPath.row == 0) {
        classPicker.tag = 1;
    }
    else if(indexPath.row == 1){
        classPicker.tag = 2;
    }
    else{
        classPicker.tag = 3;
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
    if (self.classPicker.tag == 1) {
        self.classString = [self.classArray objectAtIndex:[self.classPicker selectedRowInComponent:0]];
//        self.classString = [NSString stringWithFormat:@"%ld",[self.classPicker selectedRowInComponent:0]];

    }
    else if (self.classPicker.tag == 2) {
        self.moneyString = [self.moneyArray objectAtIndex:[self.classPicker selectedRowInComponent:0]];
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//        NSString *fileName = [path stringByAppendingPathComponent:@"requirement.plist"];
//        NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
//        [reqDic setObject:self.moneyString forKey:@"cost"];
//        [reqDic writeToFile:fileName atomically:YES];
    }
    else{
        self.timeString = [self.timeArray objectAtIndex:[self.classPicker selectedRowInComponent:0]];
    }
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
        return 7;
    }
    else if(pickerView.tag == 2){
        return 5;
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
    else if(pickerView.tag == 2){
        return [self.moneyArray objectAtIndex:row];
    }
    else{
        return [self.timeArray objectAtIndex:row];
    }
}

- (IBAction)next:(id)sender {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"requirement.plist"];
    NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
    [reqDic setObject:[NSString stringWithFormat:@"%ld",[self.classArray indexOfObject:self.classString]] forKey:@"category_id"];
    [reqDic setObject:self.moneyString forKey:@"cost"];

    NSLog(@"%@",self.classString);
    [reqDic writeToFile:fileName atomically:YES];
    
    DetailViewController *dVC = [[DetailViewController alloc] init];
    dVC.data_id = self.data_id;
    dVC.title = self.title;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    [self.navigationController pushViewController:dVC animated:YES];
}
@end

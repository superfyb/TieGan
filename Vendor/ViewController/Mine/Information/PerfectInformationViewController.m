//
//  PerfectInformationViewController.m
//  铁杆
//
//  Created by fengyibo on 15/12/7.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "AFNetworking.h"

#define profileURL @"http://120.26.55.28:5053/v1/users/profile"

@interface PerfectInformationViewController ()
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *phoneNumField;
@property (nonatomic,strong)UITextField *emailField;
@property (nonatomic,strong)UITextField *qqField;
@property (nonatomic,strong)UITextField *placeField;

@property (nonatomic,strong)NSArray *abilityArray;
@property (nonatomic,strong)NSArray *stateArray;
@property (nonatomic,strong)NSArray *yearsArray;

@property (nonatomic,strong)NSMutableArray *work_abilityArray;
@property (nonatomic,strong)NSMutableArray *work_stateArray;
@property (nonatomic,strong)NSMutableArray *work_yearsArray;
- (IBAction)saveInformation:(id)sender;
@end

@implementation PerfectInformationViewController

- (NSArray *)abilityArray{
    if (!_abilityArray) {
        _abilityArray = [NSArray arrayWithObjects:@"Web开发",@"Android开发",@"iOS开发",@"后端开发",@"微信开发",@"HTML5开发",@"UI设计",@"系统开发",@"需求分析", nil];
    }
    return _abilityArray;
}

- (NSArray *)stateArray{
    if (!_stateArray) {
        _stateArray = [NSArray arrayWithObjects:@"全职工作",@"自由职业者",@"在校生", nil];
    }
    return _stateArray;
}

- (NSArray *)yearsArray{
    if (!_yearsArray) {
        _yearsArray = [NSArray arrayWithObjects:@"1年以下",@"1-3年",@"3-5年",@"5年以上", nil];
    }
    return _yearsArray;
}

- (NSMutableArray *)work_abilityArray{
    if (!_work_abilityArray) {
        NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
        _work_abilityArray = [NSMutableArray arrayWithArray:[mydefault objectForKey:@"work_abilityArray"]];
    }
    return _work_abilityArray;
}

- (NSMutableArray *)work_stateArray{
    if (!_work_stateArray) {
        NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
        _work_stateArray = [NSMutableArray arrayWithArray:[mydefault objectForKey:@"work_stateArray"]];
    }
    return _work_stateArray;
}

- (NSMutableArray *)work_yearsArray{
    if (!_work_yearsArray) {
        NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
        _work_yearsArray = [NSMutableArray arrayWithArray:[mydefault objectForKey:@"work_yearsArray"]];
    }
    return _work_yearsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    self.tableView.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"piCell"];
    switch (indexPath.row) {
        case 0:{
            Cell.textLabel.text = @"姓名：";
            UITextField *textField = [[UITextField alloc] init];
            self.nameField = textField;
            NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
            self.nameField.text = [mydefault objectForKey:@"information_name"];
            textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-100, 55);
            [Cell addSubview:textField];
            }
            break;
            
            /*    [mydefault setObject:self.nameField.text forKey:@"information_name"];
             [mydefault setObject:self.phoneNumField.text forKey:@"information_phone"];
             [mydefault setObject:self.emailField.text forKey:@"information_email"];
             [mydefault setObject:self.qqField.text forKey:@"information_qq"];
             [mydefault setObject:self.placeField.text forKey:@"information_place"];*/
        case 1:{
            Cell.textLabel.text = @"电话：";
            UITextField *textField = [[UITextField alloc] init];
            self.phoneNumField = textField;
            NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
            self.phoneNumField.text = [mydefault objectForKey:@"information_phone"];
            textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-100, 55);
            [Cell addSubview:textField];
            }
            break;
        case 2:{
            Cell.textLabel.text = @"E-mail：";
            UITextField *textField = [[UITextField alloc] init];
            self.emailField = textField;
            NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
            self.emailField.text = [mydefault objectForKey:@"information_email"];
            textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-100, 55);
            [Cell addSubview:textField];
        }
            break;
        case 3:{
            Cell.textLabel.text = @"QQ：";
            UITextField *textField = [[UITextField alloc] init];
            self.qqField = textField;
            NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
            self.qqField.text = [mydefault objectForKey:@"information_qq"];
            textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-100, 55);
            [Cell addSubview:textField];
        }
            break;
        case 4:{
            Cell.textLabel.text = @"所在地：";
            UITextField *textField = [[UITextField alloc] init];
            self.placeField = textField;
            NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
            self.placeField.text = [mydefault objectForKey:@"information_place"];
            textField.frame = CGRectMake(80, 0, [UIScreen mainScreen].bounds.size.width-100, 55);
            [Cell addSubview:textField];
        }
            break;
        case 5:{
            Cell.textLabel.text = @"所能胜任的工作类型：";
            if (self.work_abilityArray.count) {
                Cell.detailTextLabel.text = self.work_abilityArray[0];
            }
            else{
                Cell.detailTextLabel.text = @"请选择";
            }
        }
            break;
        case 6:{
            Cell.textLabel.text = @"工作现状：";
            if (self.work_stateArray.count) {
                Cell.detailTextLabel.text = self.work_stateArray[0];
            }
            else{
                Cell.detailTextLabel.text = @"请选择";
            }
            }
            break;
        case 7:{
            Cell.textLabel.text = @"工作年限：";
            if (self.work_yearsArray.count) {
                Cell.detailTextLabel.text = self.work_yearsArray[0];
            }
            else{
                Cell.detailTextLabel.text = @"请选择";
            }
        }
            break;
        default:
            break;
    }
    
    return Cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 5:
            {
                [self buttonStyleArray:self.abilityArray titleString:@"能胜任的工作类型" messageString:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n"];
            }
            break;
        case 6:{
                [self buttonStyleArray:self.stateArray titleString:@"工作现状" messageString:@"\n\n\n\n"];
             }
            break;
        case 7:{
            [self buttonStyleArray:self.yearsArray titleString:@"工作年限" messageString:@"\n\n\n\n"];
        }
            break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark - setSelectButton
- (UIView *)buttonStyleArray:(NSArray *)array titleString:(NSString *)title messageString:(NSString *)message{
    UIView *selectView = [[UIView alloc] init];
    NSInteger i = 0;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert.view addSubview:selectView];
    selectView.userInteractionEnabled = YES;
    alert.view.userInteractionEnabled = YES;
    selectView.frame = alert.view.frame;
    for (NSString *jobStr in array) {
        UIButton *button = [[UIButton alloc] init];
        if ([self.work_abilityArray indexOfObject:jobStr]!=NSNotFound||[self.work_stateArray indexOfObject:jobStr]!=NSNotFound||[self.work_yearsArray indexOfObject:jobStr]!=NSNotFound) {
            button.selected = YES;
        }
        button.frame = CGRectMake(25+(i%2)*130,50+(i/2)*50, 100, 25);
        [button setTitle:jobStr forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"勾-1"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"勾-2"] forState:UIControlStateSelected];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
        [selectView addSubview:button];
        i ++;
    }
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.tableView reloadData];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:^{ }];
    return selectView;
}

- (void)buttonSelect:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
//        NSLog(@"%@",button.titleLabel.text);
//        NSLog(@"%ld",(unsigned long)[self.abilityArray indexOfObject:button.titleLabel.text]);
        if ([self.abilityArray indexOfObject:button.titleLabel.text]!=NSNotFound) {
            [self.work_abilityArray addObject:button.titleLabel.text];
        }
        else if ([self.stateArray indexOfObject:button.titleLabel.text]!=NSNotFound){
            [self.work_stateArray addObject:button.titleLabel.text];
        }
        else{
            [self.work_yearsArray addObject:button.titleLabel.text];
        }
    }
    else{
        if ([self.abilityArray indexOfObject:button.titleLabel.text]!=NSNotFound) {
            [self.work_abilityArray removeObject:button.titleLabel.text];
        }
        else if ([self.stateArray indexOfObject:button.titleLabel.text]!=NSNotFound){
            [self.work_stateArray removeObject:button.titleLabel.text];
        }
        else{
            [self.work_yearsArray removeObject:button.titleLabel.text];
        }
    }
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    [mydefault setObject:self.work_abilityArray forKey:@"work_abilityArray"];
    [mydefault setObject:self.work_stateArray forKey:@"work_stateArray"];
    [mydefault setObject:self.work_yearsArray forKey:@"work_yearsArray"];
    [mydefault setObject:self.nameField.text forKey:@"information_name"];
    [mydefault setObject:self.phoneNumField.text forKey:@"information_phone"];
    [mydefault setObject:self.emailField.text forKey:@"information_email"];
    [mydefault setObject:self.qqField.text forKey:@"information_qq"];
    [mydefault setObject:self.placeField.text forKey:@"information_place"];
    NSLog(@"ability:%@",self.work_abilityArray);
    NSLog(@"state:%@",self.work_stateArray);
    NSLog(@"year:%@",self.work_yearsArray);
}

#pragma mark - 保存数据
- (IBAction)saveInformation:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"teigantieganttg!" forHTTPHeaderField:@"JOKE"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"56565b0b9540f_1448499979" forHTTPHeaderField:@"Authorization"];
    NSString *work_abilityStr;
    for (NSString *str in self.work_abilityArray) {
//        [work_abilityStr stringByAppendingFormat:@",%@",str];
        work_abilityStr = [NSString stringWithFormat:@",%lu",(unsigned long)[self.abilityArray indexOfObject:str]];
    }
    work_abilityStr = [work_abilityStr substringFromIndex:1];
    NSLog(@"workstr%@",work_abilityStr);
    
    NSDictionary *parameters = @{@"name":self.nameField.text,@"phone":self.phoneNumField.text,@"email":self.emailField.text,@"qq":self.qqField.text,@"place":self.placeField.text,@"work_ability":work_abilityStr,@"work_state":self.work_stateArray[0],@"work_years":self.work_yearsArray[0]};
    
    [manager POST:profileURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}
@end

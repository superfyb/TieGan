//
//  MyRequestmentCell.h
//  铁杆
//
//  Created by fengyibo on 15/12/28.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRequirementCell : UITableViewCell
@property (strong,nonatomic) NSString *data_id;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *requirementName;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;


@end

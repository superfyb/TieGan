//
//  CompanyCell.h
//  TieGan
//
//  Created by fengyibo on 15/11/20.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstButtonImageView;
@property (weak, nonatomic) IBOutlet UILabel *secondButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secondButtonImageView;
@property (weak, nonatomic) IBOutlet UILabel *thirdButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thirdButtonImageView;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@end

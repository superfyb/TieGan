//
//  buttonCell.h
//  TieGan
//
//  Created by fengyibo on 15/11/19.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buttonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

//
//  buttonCell.m
//  TieGan
//
//  Created by fengyibo on 15/11/19.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "buttonCell.h"

@implementation buttonCell

- (void)awakeFromNib {
    self.nameLabel.layer.cornerRadius = 10;
    self.nameLabel.clipsToBounds = YES;
    self.introLabel.text = [NSString stringWithFormat:@"产品简介：%@",self.introLabel.text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

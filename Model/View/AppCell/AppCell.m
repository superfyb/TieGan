//
//  AppCell.m
//  TieGan
//
//  Created by fengyibo on 15/11/20.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

- (void)awakeFromNib {
    self.recruitLabel.layer.cornerRadius = 10;
    self.recruitLabel.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

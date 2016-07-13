//
//  ToolsDetailController.h
//  铁杆
//
//  Created by fengyibo on 15/12/4.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolsDetailController : UIViewController
@property (strong,nonatomic)NSString *introduceText;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong,nonatomic) NSURL *imageUrl;
@end

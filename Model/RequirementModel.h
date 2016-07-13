//
//  APPModel.h
//  TieGan
//
//  Created by fengyibo on 15/11/23.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface requirementModel : NSObject
//序号
@property (nonatomic,strong) NSString *num;
//名称
@property (nonatomic,strong) NSString *name;
//简要说明
@property (nonatomic,strong) NSString *info;
//分类
@property (nonatomic,strong) NSString *category_id;
//开发周期预估
@property (nonatomic,strong) NSString *period;
//开发费用预估
@property (nonatomic,strong) NSString *cost;
//联系人
@property (nonatomic,strong) NSString *owner;
//联系方式
@property (nonatomic,strong) NSString *contact;
//邮箱
@property (nonatomic,strong) NSString *email;
//参考实例
@property (nonatomic,strong) NSString *reference;
//图片
@property (nonatomic,strong) NSString *icon_img;
//id
@property (nonatomic,strong) NSString *data_id;

@end

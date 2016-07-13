//
//  ChatViewController.m
//  铁杆
//
//  Created by fengyibo on 15/12/15.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<EaseMessageCellDelegate,EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
//    NSArray *messages = [conversation loadAllMessages]; // 获取会话中的全部聊天记录。
//    [self.messsagesSource arrayByAddingObjectsFromArray:messages];
    if ([self.parentViewController.title isEqualToString:@"铁杆客服"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页-14"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"tiegan" conversationType:eConversationTypeChat];

    NSArray *array = [conversation loadAllMessages];
    for (NSDictionary *message in array) {
        NSString *messageID = [message valueForKey:@"messageId"];
        NSLog(@"id:%@",messageID);
//        EMMessage *msg = [conversation loadMessageWithId:message[@"id"]];
        EMMessage *msg = [conversation loadMessageWithId:messageID]; // 根据messageid获取消息
        [self addMessageToDataSource:msg progress:nil];
//            [[EaseMob sharedInstance].chatManager insertMessageToDB:msg append2Chat:YES];
    }


    NSLog(@"array:%@",array);
}

//具体样例:
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系,根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    if (model.isSender) {
        if ([mydefaults objectForKey:@"headImageData"]) {
            NSData *data = [mydefaults objectForKey:@"headImageData"];
            model.avatarImage = [UIImage imageWithData:data];
        }
        else{
            model.avatarImage = [UIImage imageNamed:@"user_head"];
        }
    }
    else{
        model.avatarImage = [UIImage imageNamed:@"icon 界面设计_铁杆客服(0)"];
    }
    model.avatarURLPath = @"";//头像网络地址
    model.nickname = @"昵称";//用户昵称
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回上一界面
- (void)back{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

@end


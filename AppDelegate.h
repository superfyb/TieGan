//
//  AppDelegate.h
//  TieGan
//
//  Created by fengyibo on 15/11/10.
//  Copyright © 2015年 fengyibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *Authorization;
}

@property (retain,nonatomic) NSString *Authorization;
@property (retain,nonatomic) NSString *userName;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) removeGuide;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end


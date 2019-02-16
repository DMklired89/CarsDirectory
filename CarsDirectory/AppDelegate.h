//
//  AppDelegate.h
//  CarsDirectory
//
//  Created by Dmitry Edrenov on 17.02.19.
//  Copyright © 2019 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


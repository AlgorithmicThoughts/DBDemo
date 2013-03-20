//
//  AppDelegate.h
//  DatabaseDemo
//
//  Created by Ravi Dixit on 20/03/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEmpRecordVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AddEmpRecordVC *objAddEmpRecordVC;
@property (strong,nonatomic) UINavigationController *objnavc;

@end

//
//  EmployeeListTableVC.h
//  DatabaseDemo
//
//  Created by Ravi Dixit on 01/02/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseHelper.h"
#import "EmployeeListTableCell.h"

@interface EmployeeListTableVC : UITableViewController
{
    NSMutableArray *presentationArray;
    DatabaseHelper *objDBHelper;
}

- (void)addBackBarButtonToNavigationBar;

- (void)navigationBarBackbuttonPressed;

@end

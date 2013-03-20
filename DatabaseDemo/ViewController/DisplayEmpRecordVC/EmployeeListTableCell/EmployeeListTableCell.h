//
//  EmployeeListTableCell.h
//  DatabaseDemo
//
//  Created by Ravi Dixit on 20/03/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeListTableCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *userImageView;
@property (nonatomic,strong)IBOutlet UILabel *lbluserName;
@property (nonatomic,strong)IBOutlet UILabel *lbluserDepartmentName;

@end

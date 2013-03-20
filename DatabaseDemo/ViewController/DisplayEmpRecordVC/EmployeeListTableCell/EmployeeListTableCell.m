//
//  EmployeeListTableCell.m
//  DatabaseDemo
//
//  Created by Ravi Dixit on 20/03/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import "EmployeeListTableCell.h"

@implementation EmployeeListTableCell

@synthesize userImageView;
@synthesize lbluserDepartmentName;
@synthesize lbluserName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

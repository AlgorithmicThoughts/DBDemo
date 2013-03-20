//
//  EmployeeListTableVC.m
//  DatabaseDemo
//
//  Created by Ravi Dixit on 01/02/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import "EmployeeListTableVC.h"

@interface EmployeeListTableVC ()

@end

@implementation EmployeeListTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addBackBarButtonToNavigationBar];
    self.title = @"Employee Listing";
    objDBHelper = [[DatabaseHelper alloc]init];
    presentationArray = [[NSMutableArray alloc]initWithArray:[objDBHelper getAllEmployeeRecord]];
    if (presentationArray.count!=0)
    {
        [self.tableView reloadData];
    }
    
    
}

- (void)addBackBarButtonToNavigationBar
{
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarBackbuttonPressed)];
    self.navigationItem.leftBarButtonItem = btnItem;
}

- (void)navigationBarBackbuttonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return presentationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EmployeeListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSArray *xiblocation = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
    
    for (id cellObj in xiblocation)
    {
        cell = (EmployeeListTableCell*)cellObj;
    }
    
    cell.lbluserName.text = [[presentationArray objectAtIndex:indexPath.row] valueForKey:@"EmpName"];
     cell.lbluserDepartmentName.text = [[presentationArray objectAtIndex:indexPath.row] valueForKey:@"EmpDept"];
    
    NSData *d = [NSData dataWithData:[[presentationArray objectAtIndex:indexPath.row] valueForKey:@"EmpImage"]];
    cell.userImageView.image = [UIImage imageWithData:d];
    
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86.0f;
}


// Override to support conditional editing of the table view.



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        if (objDBHelper)
        {
            NSString *currentUserRecordID = [[presentationArray objectAtIndex:indexPath.row] valueForKey:@"RecordID"];
            BOOL deleteflag = [objDBHelper deleteEmployeeWithID:currentUserRecordID];
            
            if (deleteflag == YES)
            {   [presentationArray removeObjectAtIndex:indexPath.row];
                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

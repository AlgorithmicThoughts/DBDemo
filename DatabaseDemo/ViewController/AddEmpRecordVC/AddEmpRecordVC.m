//
//  AddEmpRecordVC.m
//  DatabaseDemo
//
//  Created by Ravi Dixit on 01/02/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import "AddEmpRecordVC.h"

@interface AddEmpRecordVC ()

@end

@implementation AddEmpRecordVC

@synthesize txtempdept;
@synthesize txtempName;
@synthesize empimgv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    objDBHelper = [[DatabaseHelper alloc]init];
    self.title = @"Add Employee Record";
    [self addTapGestureToImageView];
}
- (void)addTapGestureToImageView
{
    UITapGestureRecognizer *tpGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageGallery:)];
    tpGesture.numberOfTapsRequired = 1;
    self.empimgv.userInteractionEnabled = YES;
    [self.empimgv addGestureRecognizer:tpGesture];
}

- (void)showImageGallery:(UIGestureRecognizer*)sender
{
    UIImagePickerController *objImagePicker = [[UIImagePickerController alloc]init];
    objImagePicker.allowsEditing = YES;
    objImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    objImagePicker.delegate = self;
    [self presentViewController:objImagePicker animated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Image picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.empimgv.image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showpopUp:(NSString*)popUpMessage
{
    UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:popUpMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [objalert show];
}

- (IBAction)insertEmpRecord:(id)sender
{
 
  if ([objDBHelper insertEmployeeRecordWithEmployeeName:txtempName.text andEmployeeDepartment:txtempdept.text andEmployeeImage:self.empimgv.image])
  {
      [self showpopUp:@"Record inserted Successfully"];
      [self clearControls:self];
  }
  else
  {
       [self showpopUp:@"Record insertion failed"];
  }
    
}
- (IBAction)clearControls:(id)sender
{
    self.txtempdept.text = @"";
    self.txtempName.text = @"";
    self.empimgv.image = [UIImage imageNamed:@"Goku_SSJ4.jpg"];
}
- (IBAction)displayallEmployeeRecords:(id)sender
{
    EmployeeListTableVC *objempListVC = [[EmployeeListTableVC alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:objempListVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

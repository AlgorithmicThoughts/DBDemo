//
//  AddEmpRecordVC.h
//  DatabaseDemo
//
//  Created by Ravi Dixit on 01/02/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseHelper.h"
#import "EmployeeListTableVC.h"

@interface AddEmpRecordVC : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    DatabaseHelper *objDBHelper;
}


@property (nonatomic,strong) IBOutlet UITextField *txtempName;
@property (nonatomic,strong) IBOutlet UITextField *txtempdept;
@property (nonatomic,strong) IBOutlet UIImageView *empimgv;

// adds the tap gesture to the image view
- (void)addTapGestureToImageView;

// displays the ios gallery
- (void)showImageGallery:(UIGestureRecognizer*)sender;

// displays the simple alert pop up
- (void)showpopUp:(NSString*)popUpMessage;

// calls the insert query to insert record in sqlite DB
- (IBAction)insertEmpRecord:(id)sender;

// clears the UI control
- (IBAction)clearControls:(id)sender;

// fetches all the records from the database and displays them in table view
- (IBAction)displayallEmployeeRecords:(id)sender;


@end

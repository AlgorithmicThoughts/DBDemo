//
//  DatabaseHelper.h
//  DatabaseDemo
//
//  Created by Ravi Dixit on 01/02/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseHelper : NSObject
{
    sqlite3 *databaseReference;
}

- (id)init;

//Copies the database from the Project bundle to the document directory
- (BOOL)copyDatabaseFromBundletoDocumentDirectory;

// gets the location of the database present in the document directory
- (NSString*)documentDirectoryDatabaseLocation;

// creates the database instance
- (void)createDatabaseInstance;

// checks if any previous db connection is open before firing a new query
//and if the connection is open then closes it
- (void)closeanyOpenConnection;


// inserts the new employee record
- (BOOL)insertEmployeeRecordWithEmployeeName:(NSString*)empname andEmployeeDepartment:(NSString*)empdept andEmployeeImage:(UIImage*)empImage;

// gives you the employee name and employee image
- (NSMutableArray*)getAllEmployeeRecord;

// gets the employee record with all the employee details by empname
- (NSMutableArray*)getEmployeeDetailsByEmployeeName:(NSString*)empName;

// Delete the employee record and accepts the record ID as the parameter
- (BOOL)deleteEmployeeWithID:(NSString*)employeeRecordID;


@end

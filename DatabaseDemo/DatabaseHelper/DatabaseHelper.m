//
//  DatabaseHelper.m
//  DatabaseDemo
//
//  Created by Ravi Dixit on 01/02/13.
//  Copyright (c) 2013 Ravi Dixit. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper

- (id)init
{
    [self createDatabaseInstance];
    return self;
}


//Copies the database from the Project bundle to the document directory
- (BOOL)copyDatabaseFromBundletoDocumentDirectory
{
    // If sqlite file does not exists at the document dir then create it
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self documentDirectoryDatabaseLocation]])
    {
        
        NSString *bundlePathofDatabase = [[NSBundle mainBundle]pathForResource:@"AdventureWorks" ofType:@"sqlite"];
        if (bundlePathofDatabase.length!=0)
        {
            NSString *docdirLocation = [self documentDirectoryDatabaseLocation];
            
            // it should return YES which indicates that the file is copied
            return [[NSFileManager defaultManager] copyItemAtPath:bundlePathofDatabase toPath:docdirLocation error:nil];
        }
        
        // This means that your file is not copied in the document directory
        return NO;
    }
    else
    {
        return YES;
    }
}

// gets the location of the database present in the document directory
- (NSString*)documentDirectoryDatabaseLocation
{
    NSArray *documentDirectoryFolderLocation = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[documentDirectoryFolderLocation objectAtIndex:0] stringByAppendingPathComponent:@"AdventureWorks.sqlite"];
}

// creates the database instance at document directory
- (void)createDatabaseInstance
{
    if([self copyDatabaseFromBundletoDocumentDirectory])
    {
        // NSLog(@"DB copied in doc dir");
    }
    else
    {
        // NSLog(@"DB copying failed");
    }
}

// checks if any previous db connection is open before firing a new query
//and if the connection is open then closes it
- (void)closeanyOpenConnection
{
    if(sqlite3_open([[self documentDirectoryDatabaseLocation]UTF8String],&databaseReference)!= SQLITE_OK)
	{
		sqlite3_close(databaseReference);
	}
}


// inserts the new employee record
- (BOOL)insertEmployeeRecordWithEmployeeName:(NSString*)empname andEmployeeDepartment:(NSString*)empdept andEmployeeImage:(UIImage*)empImage
{
    if (empname.length!=0 && empdept.length!=0)
    {
        // checking for any previously open connection which was not closed
        [self closeanyOpenConnection];
        
        // preparing my sqlite query
        const char *sqliteQuery = "insert into EmployeeRecord(EmpName,EmpDept,EmpImage) values(?,?,?)";
        
        sqlite3_stmt *sqlstatement = nil;
        
        if (sqlite3_prepare_v2(databaseReference, sqliteQuery, -1, &sqlstatement, NULL)==SQLITE_OK )
        {
            sqlite3_bind_text(sqlstatement, 1, [empname UTF8String], -1,  SQLITE_TRANSIENT);
            sqlite3_bind_text(sqlstatement, 2, [empdept UTF8String], -1,  SQLITE_TRANSIENT);
            
            // You need to convert the image data into NSData first
            NSData *imgData = [NSData dataWithData:UIImagePNGRepresentation(empImage)];
            
            // insert the binary representation of the byte data into the database
            sqlite3_bind_blob(sqlstatement, 3, [imgData bytes], [imgData length], SQLITE_TRANSIENT);
            
            // executes the sql statement with the data you need to insert in the db
            sqlite3_step(sqlstatement);
            
            // clearing the sql statement
            sqlite3_finalize(sqlstatement);
            //closing the database after the query execution
            sqlite3_close(databaseReference);
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

// gives you the employee name and employee image
- (NSMutableArray*)getAllEmployeeRecord
{
    NSMutableArray *recordSet = [[NSMutableArray alloc]init];
    [self closeanyOpenConnection];
    
    // Query to fetch the emp name and images from the database
    const char *selectQuery = "select EmpName,EmpImage,EmpDept,RecordID from EmployeeRecord";
    sqlite3_stmt *sqlstatement = nil;
    
    
    if (sqlite3_prepare_v2(databaseReference, selectQuery, -1, &sqlstatement , NULL)==SQLITE_OK) {
        
        // declaring a dictionary so that response can be saved in KVC
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        while (sqlite3_step(sqlstatement) == SQLITE_ROW)
        {
            char* nameChar = (char*)sqlite3_column_text(sqlstatement, 0);
            NSString *nameStr = [NSString stringWithUTF8String:nameChar];
            [dict setValue:nameStr forKey:@"EmpName"];
            
            // fetching the image data from the DB
            NSData *imageDataFromDatabase = [[NSData alloc]initWithBytes:sqlite3_column_blob(sqlstatement, 1) length:sqlite3_column_bytes(sqlstatement, 1)];
            
            [dict setValue:imageDataFromDatabase forKey:@"EmpImage"];
            
            char* deptChar = (char*)sqlite3_column_text(sqlstatement, 2);
            NSString *deptStr = [NSString stringWithUTF8String:deptChar];
            [dict setValue:deptStr forKey:@"EmpDept"];
            
            int recordID = sqlite3_column_int(sqlstatement, 3);
            NSString *recordIDstr = [NSString stringWithFormat:@"%d",recordID];
            [dict setValue:recordIDstr forKey:@"RecordID"];
            
            // saving the record set in a MutableArray
            [recordSet addObject:dict];
            
            // clearing the NSData variable since it will be initalized again and again
            imageDataFromDatabase = nil;
            
            // clearing off the dictionary to make sure that it does not contain any garbage data
            dict = nil;
            
            // re- initalizing the dictionary for next record
            dict = [[NSMutableDictionary alloc]init];
        }
        
        // once all the fetching is one clearing off the dict variable for good.
        dict = nil;
        
    }
    
    
    return  recordSet;
    
}

// gets the employee record with all the employee details by empname
- (NSMutableArray*)getEmployeeDetailsByEmployeeName:(NSString*)empName
{
    NSMutableArray *recordSet = [[NSMutableArray alloc]init];
    [self closeanyOpenConnection];
    
    // Query to fetch the emp name and images from the database
    NSString *fetchQuery = [NSString stringWithFormat:@"select EmpName,EmpDept,EmpImage from EmployeeRecord where EmpName =='%@'",empName];
    
    const char *selectQuery = [fetchQuery UTF8String];
    sqlite3_stmt *sqlstatement = nil;
    
    
    if (sqlite3_prepare_v2(databaseReference, selectQuery, -1, &sqlstatement , NULL)==SQLITE_OK) {
        
        // declaring a dictionary so that response can be saved in KVC
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        while (sqlite3_step(sqlstatement) == SQLITE_ROW)
        {
            char* nameChar = (char*)sqlite3_column_text(sqlstatement, 0);
            NSString *nameStr = [NSString stringWithUTF8String:nameChar];
            [dict setValue:nameStr forKey:@"EmpName"];
            
            // fetching the image data from the DB
            NSData *imageDataFromDatabase = [[NSData alloc]initWithBytes:sqlite3_column_blob(sqlstatement, 1) length:sqlite3_column_bytes(sqlstatement, 1)];
            
            [dict setValue:imageDataFromDatabase forKey:@"EmpImage"];
            
            // saving the record set in a MutableArray
            [recordSet addObject:dict];
            
            // clearing the NSData variable since it will be initalized again and again
            imageDataFromDatabase = nil;
            
            // clearing off the dictionary to make sure that it does not contain any garbage data
            dict = nil;
            
            // re- initalizing the dictionary for next record
            dict = [[NSMutableDictionary alloc]init];
        }
        
        // once all the fetching is one clearing off the dict variable for good.
        dict = nil;
        
    }
    
    
    return  recordSet;
    
}


- (BOOL)deleteEmployeeWithID:(NSString*)employeeRecordID
{
    BOOL flag = NO ;
    
    NSString *sqliteQuery = [NSString stringWithFormat:@"Delete from EmployeeRecord where RecordID = '%@'",employeeRecordID];
    [self closeanyOpenConnection];
    
    sqlite3_stmt *sqlStatement = nil;
    if (sqlite3_prepare_v2(databaseReference, [sqliteQuery UTF8String], -1, &sqlStatement, NULL) == SQLITE_OK)
    {
        sqlite3_step(sqlStatement);
        sqlite3_finalize(sqlStatement);
        sqlite3_close(databaseReference);
        flag = YES;
    }
    else
    {
        flag = NO;
    }
    
    return flag;
}




@end

//
//  DBManager.h
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DBManager : NSObject

-(instancetype) initWithDatabaseFilename:(NSString *)fileName;

@property(nonatomic, strong) NSString *documentsDirectory;
@property(nonatomic,strong) NSString *dbFileName;
@property(nonatomic,strong) NSMutableArray *records;
@property(nonatomic,strong) NSMutableArray *columnNames;
@property(nonatomic) int modifiedRowCount;
@property(nonatomic) long long rowInsertId;

-(NSArray *) loadDataFromDB: (NSString *) query;

-(void) executeQuery:(NSString *) query;
-(void) copyDatabaseIntoDocumentsDirectory;
-(void)runQuery:(const char*)query isQueryExecutable:(BOOL) isUpdateDelete;


@end

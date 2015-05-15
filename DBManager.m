//
//  DBManager.m
//  Final_Project
//
//  Created by Anantha Shankar Arun Kumar on 5/1/15.
//  Copyright (c) 2015 Anantha Shankar Arun Kumar. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager


-(instancetype)initWithDatabaseFilename:(NSString *)fileName
{
    self = [super init];
    if(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        
        self.dbFileName = fileName;
        
        [self copyDatabaseIntoDocumentsDirectory];
        
    }
    return self;
    
}

-(void) copyDatabaseIntoDocumentsDirectory
{
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.dbFileName];
    NSLog(@"%@", destinationPath);
    if(![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        
        NSString *sourcePath = [NSString stringWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: self.dbFileName]];
        
        NSLog(@"%@", destinationPath);
        NSLog(@"%@", sourcePath);
        
        NSLog(@"%@",[[NSBundle mainBundle] resourcePath]);
        
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        
        if(error != nil)
        {
            
            NSLog(@" %@",[error localizedDescription]);
        }
    }
    
    
}

-(void) runQuery:(const char *)query isQueryExecutable:(BOOL)isUpdateDelete
{
    sqlite3 *db;
    
    NSString *databasePath= [self.documentsDirectory stringByAppendingPathComponent:self.dbFileName];
    
    if(self.records != nil)
    {
        [self.records removeAllObjects];
        self.records = nil;
        
    }
    self.records = [[NSMutableArray alloc]init];
    
    if(self.columnNames != nil)
    {
        
        [self.columnNames removeAllObjects];
        self.columnNames = nil;
        
    }
    self.columnNames = [[NSMutableArray alloc] init];
    
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &db);
    
    
    if(openDatabaseResult == SQLITE_OK)
    { sqlite3_stmt *compiledStatement;
        
        BOOL prepareStatmentResult = sqlite3_prepare_v2(db, query, -1, &compiledStatement, NULL);
        
        if(prepareStatmentResult == SQLITE_OK)
        {
            if(!isUpdateDelete)
            {
                NSMutableArray* rowRecord;
                
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    
                    rowRecord = [[NSMutableArray alloc] init];
                    
                    int totalColumns= sqlite3_column_count(compiledStatement);
                    
                    for(int i=0; i<totalColumns; i++)
                    {
                        char *dbDataAsChars = (char*) sqlite3_column_text(compiledStatement, i);
                        if(dbDataAsChars != NULL)
                        {
                            
                            [rowRecord addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                            
                        }
                        if(self.columnNames.count != totalColumns)
                        {
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.columnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                            
                        }
                    }
                    if(rowRecord.count > 0)
                    {
                        [self.records addObject:rowRecord];
                        
                    }
                }
            }
            else{
                
                BOOL executeQueryResult = sqlite3_step(compiledStatement);
                if(executeQueryResult == SQLITE_DONE)
                {
                    
                    self.modifiedRowCount = sqlite3_changes(db);
                    self.rowInsertId = sqlite3_last_insert_rowid(db);
                    
                }
                else{
                    
                    NSLog(@"Error: %s",sqlite3_errmsg(db));
                }
                
            }
        }
        else
        {
            NSLog(@"%s", sqlite3_errmsg(db));
        }
        sqlite3_finalize(compiledStatement);
    }
    
    
    
    sqlite3_close(db);
    
}
-(NSArray *) loadDataFromDB:(NSString *)query
{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *) self.records;
}
-(void) executeQuery:(NSString *)query
{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}


@end

//
//  NoteDAO.m
//  Table2
//
//  Created by 张雨楠 on 16/4/10.
//  Copyright (c) 2016年 张雨楠. All rights reserved.
//


#import "NoteDAO.h"

@implementation NoteDAO


static NoteDAO *sharedManager = nil;

+ (NoteDAO*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
        [sharedManager createEditableCopyOfDatabaseIfNeeded];
    });
    return sharedManager;
}

//判断在Documents目录下是否存在NotesList.plist文件，如果不存在则从资源目录下复制一个
- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
        
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        NSAssert(success, @"错误写入文件");
    }
}

//获取放置在沙箱Documents目录下的文件的完整路径
- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    
    return path;
}


//查询所有数据方法
-(NSMutableArray*) findAll
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    //[self.listData removeAllObjects];
    NSMutableArray *listcontents = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Note* note = [[Note alloc] init];
        note.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        note.content = [dict objectForKey:@"content"];
        
        [listcontents addObject:note];
        
    }
    return listcontents;
}


//删除Note方法
-(int) remove:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        //Note* note = [[Note alloc] init];
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        //note.content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [array removeObject: dict];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    
    return 0;
}





@end
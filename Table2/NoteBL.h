//
//  NoteBL.h
//  Table2
//
//  Created by 张雨楠 on 16/4/10.
//  Copyright (c) 2016年 张雨楠. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NoteDAO.h"
#import "Note.h"

@interface NoteBL : NSObject

////插入Note方法
//-(NSMutableArray*) createNote:(Note*)model;
//
//删除Note方法
-(NSMutableArray*) remove:(Note*)model;

//查询所用数据方法
-(NSMutableArray*) findAll;


@end

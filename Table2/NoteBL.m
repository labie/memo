//
//  NoteBL.m
//  Table2
//
//  Created by 张雨楠 on 16/4/10.
//  Copyright (c) 2016年 张雨楠. All rights reserved.
//

#import "NoteBL.h"
#import "NoteDAO.h"

@implementation NoteBL

////插入Note方法
//-(NSMutableArray*) createNote:(Note*)model
//{
//    NoteDAO *dao = [NoteDAO sharedManager];
//    [dao create:model];
//    
//    return [dao findAll];
//}

//删除Note方法
-(NSMutableArray*) remove:(Note*)model
{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao remove:model];
    
    return [dao findAll];
}

//查询所用数据方法
-(NSMutableArray*) findAll
{
    NoteDAO *dao = [NoteDAO sharedManager];
    return [dao findAll];
}
@end

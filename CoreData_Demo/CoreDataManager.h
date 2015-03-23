//
//  CoreDataManager.h
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//
#define TableName @"News"
#import <Foundation/Foundation.h>
#import "News.h"
@interface CoreDataManager : NSObject

@property (readonly,strong,nonatomic) NSManagedObjectContext * managedObjectContext;//管理对象，上下文，持久性存储模型对象
@property (readonly,strong,nonatomic) NSManagedObjectModel   * managedObjectModel;//被管理的数据模型，数据结构
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;//连接数据库的



//保存数据
- (void)saveContext;
//获取文件目录
- (NSURL*)applicationDocumentsDirectory;





//插入
- (void)insertCoreData:(NSMutableArray*)dataArray;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end

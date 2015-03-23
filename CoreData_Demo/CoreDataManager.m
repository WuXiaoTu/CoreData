//
//  CoreDataManager.m
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel   = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//这个实现替换为适当的代码来处理错误
- (void)saveContext
{
    NSError * error = nil;
    NSManagedObjectContext * managedObjectContext = self.managedObjectContext;
    if (managedObjectContext !=nil) {
        
        if ([managedObjectContext hasChanges] &&![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort()会导致应用程序生成一个崩溃日志和终止。你不应该使用这个函数在项目应用程序中,虽然它可能是有用的
            abort();
        }
    }
}
//返回应用程序的托管对象模型
//如果模型不存在,它从应用程序的创建模型
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewsModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
//返回应用程序的管理对象上下文
//如果不存在,则创建并绑定到应用程序的持久性存储协调员
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext !=nil) {
        
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
    
    if (coordinator !=nil) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
//返回应用程序的持久性存储协调员
//如果协调器不存在,创建和应用程序的商店添加到它
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator !=nil) {
        
        return _persistentStoreCoordinator;
    }
    NSURL * storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"NewsModel.sqlite"];
    
    NSError * error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
#pragma mark - 应用程序的文件目录
//将URL返回给应用程序的文档目录 获取Documents路径
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}
#pragma mark - 增、删、改、查
//插入
- (void)insertCoreData:(NSMutableArray *)dataArray
{
    NSManagedObjectContext * context = [self managedObjectContext];
    
    for (News * info in dataArray) {
        
        News * newsInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        
        newsInfo.newsid = info.newsid;
        newsInfo.title  = info.title;
        newsInfo.imgurl = info.imgurl;
        newsInfo.descr  = info.descr;
        newsInfo.islook = info.islook;
        
        NSError * error;
        if (![context save:&error]) {
            
            NSLog(@"不能保存：%@",[error localizedDescription]); 
        }
    }
}
//查询
- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage
{
    NSManagedObjectContext * context = [self managedObjectContext];
    // 限定查询结果的数量
    // setFetchLimit
    // 查询的偏移量
    // setFetchOffset
    
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError * error;
    
    NSArray * fetchdObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray * resultArray = [NSMutableArray array];
    
    for (News * info in fetchdObjects) {
        
        NSLog(@"id:%@", info.newsid);
        NSLog(@"title:%@", info.title);
        [resultArray addObject:info];
    }
    return resultArray;
}
//删除
- (void)deleteData
{
    NSManagedObjectContext * context = [self managedObjectContext];
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    
    NSError * error = nil;
    NSArray * datas = [context executeFetchRequest:request error:&error];
    
    if (!error && datas && [datas count]) {
        
        for (NSManagedObject * obj in datas) {
            
            [context deleteObject:obj];
        }
        if (![context save:&error]) {
            
            NSLog(@"错误:%@",error);
        }
    }
}
//更新
- (void)updateData:(NSString *)newsId withIsLook:(NSString *)islook
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"newsid like[cd] %@",newsId];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:context]];
    [request setPredicate:predicate];//这里相当于sqlite中的查询条件，具体格式参考苹果文档
    

    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (News *info in result) {
        info.islook = islook;
    }
    
    //保存
    if ([context save:&error]) {
        //更新成功
        NSLog(@"更新成功");
    }
}
@end

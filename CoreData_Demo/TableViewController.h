//
//  TableViewController.h
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "CoreDataManager.h"
@interface TableViewController : UITableViewController
{
    CoreDataManager * coreManager;
    
}

@property (nonatomic,strong)NSMutableArray * resultArray;
@end

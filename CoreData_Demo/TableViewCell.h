//
//  TableViewCell.h
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "UIImageView+WebCache.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descr;

-(void)setContent:(News*)info;


@end

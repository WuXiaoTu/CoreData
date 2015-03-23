//
//  News.h
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject


@property (nonatomic,strong)NSString *newsid;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *descr;
@property (nonatomic,strong)NSString *imgurl;
@property (nonatomic,strong)NSString *islook;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

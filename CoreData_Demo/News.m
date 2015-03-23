//
//  News.m
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.newsid = dictionary[@"id"];
        self.title  = dictionary[@"title"];
        self.descr  = dictionary[@"descr"];
        self.imgurl = dictionary[@"imgurl"];
        self.islook = @"0";
    }
    return self;
}

@end

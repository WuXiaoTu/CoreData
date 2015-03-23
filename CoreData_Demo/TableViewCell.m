//
//  TableViewCell.m
//  CoreData_Demo
//
//  Created by Transuner on 15-3-17.
//  Copyright (c) 2015年 广州传讯信息科技有限公司. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        _title.textColor = [UIColor darkGrayColor];
    }
}
-(void)setContent:(News*)info
{
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        _ImageView.image = image;
    }];
    _title.text = info.title;
    _descr.text = info.descr;
    if ([info.islook isEqualToString:@"1"]) {
        _title.textColor = [UIColor redColor];
        _descr.textColor = [UIColor redColor];
    }
}
@end

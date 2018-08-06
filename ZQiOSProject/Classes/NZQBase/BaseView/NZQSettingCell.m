//
//  NZQSettingCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQSettingCell.h"
#import "NZQWordItem.h"
#import "NZQWordArrowItem.h"
#import "NZQItemSection.h"

@implementation NZQSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style{
    
    NZQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[self className]];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:style reuseIdentifier:[self className]];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupBaseSettingCellUI];
    }
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupBaseSettingCellUI];
}


- (void)setupBaseSettingCellUI{
    self.detailTextLabel.numberOfLines = 0;
}

- (void)setItem:(NZQWordItem *)item{
    _item = item;
    
    [self fillData];
    
    [self changeUI];
}

- (void)fillData{
    
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subTitle;
    //    self.imageView.image = self.item.image;
    /** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
    if ([self.item.image isKindOfClass:[UIImage class]]) {
        self.imageView.image = self.item.image;
    }else if ([self.item.image isKindOfClass:[NSURL class]]) {
        [self.imageView setImageURL:self.item.image];
    }else if ([self.item.image isKindOfClass:[NSString class]]) {
        
        if ([self.item.image hasPrefix:@"http://"] || [self.item.image hasPrefix:@"https://"] || [self.item.image hasPrefix:@"file://"]) {
            NSString *imageUrl = [self.item.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
            [self.imageView setImageURL:[NSURL URLWithString:imageUrl]];
        }else {
            self.imageView.image = [UIImage imageNamed:self.item.image];
        }
    }
}

- (void)changeUI{
    
    self.textLabel.font = self.item.titleFont;
    self.textLabel.textColor = self.item.titleColor;
    
    self.detailTextLabel.font = self.item.subTitleFont;
    self.detailTextLabel.textColor = self.item.subTitleColor;
    self.detailTextLabel.numberOfLines = self.item.subTitleNumberOfLines;
    
    if ([self.item isKindOfClass:[NZQWordArrowItem class]]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (self.item.itemOperation || [self.item isKindOfClass:[NZQWordArrowItem class]]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end

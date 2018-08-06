//
//  NZQWordItem.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQWordItem.h"

@implementation NZQWordItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    NZQWordItem *item = [[self alloc] init];
    item.subTitle = subTitle;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation {
    NZQWordItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.itemOperation = itemOperation;
    return item;
}

- (instancetype)init{
    if (self = [super init]) {
        _titleColor = [UIColor blackColor];
        _subTitleColor = [UIColor blackColor];
        _titleFont = AdaptedFontSize(16);
        _subTitleFont = AdaptedFontSize(16);
        _subTitleNumberOfLines = 2;
    }
    
    return self;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight += 20;
        NSString *totalString = [NSString stringWithFormat:@"%@%@", self.title, self.subTitle];
        _cellHeight += [totalString boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : self.subTitleFont} context:nil].size.height;
        _cellHeight = MAX(_cellHeight, 50);
        _cellHeight = AdaptedWidth(_cellHeight);
    }
    return _cellHeight;
}


@end

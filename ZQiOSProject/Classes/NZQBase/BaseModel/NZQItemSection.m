//
//  NZQItemSection.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQItemSection.h"
#import "NZQWordItem.h"

@implementation NZQItemSection

+ (instancetype)sectionWithItems:(NSArray<NZQWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle{
    
    NZQItemSection *item = [[self alloc] init];
    if (items.count) {
        [item.items addObjectsFromArray:items];
    }
    
    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;
    
    return item;
}

- (NSMutableArray<NZQWordItem *> *)items{
    
    if(!_items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end

//
//  NZQItemSection.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NZQWordItem;

@interface NZQItemSection : NSObject

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong) NSMutableArray<NZQWordItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<NZQWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end

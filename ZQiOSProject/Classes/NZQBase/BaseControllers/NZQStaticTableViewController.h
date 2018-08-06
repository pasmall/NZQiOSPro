//
//  NZQStaticTableViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQTableViewController.h"
#import "NZQWordItem.h"
#import "NZQItemSection.h"
#import "NZQWordArrowItem.h"

@interface NZQStaticTableViewController : NZQTableViewController

// 需要把组模型添加到数据中
@property (nonatomic, strong) NSMutableArray<NZQItemSection *> *sections;

// 用于自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NZQStaticTableViewController *(^)(NZQWordItem *item))addItem;

@end

UIKIT_EXTERN const UIEdgeInsets tableViewDefaultSeparatorInset;
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultLayoutMargins;

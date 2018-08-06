//
//  NZQSettingCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQWordItem;

@interface NZQSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;

/** 静态单元格模型 */
@property (nonatomic, strong)  NZQWordItem *item;

@end

//
//  NZQStaticTableViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQStaticTableViewController.h"
#import "NZQSettingCell.h"

const UIEdgeInsets tableViewDefaultSeparatorInset = {0, 15, 0, 0};
const UIEdgeInsets tableViewDefaultLayoutMargins = {8, 8, 8, 8};

@interface NZQStaticTableViewController ()

@end

@implementation NZQStaticTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    self.tableView.separatorInset = UIEdgeInsetsZero;
//    self.tableView.layoutMargins = UIEdgeInsetsZero;
    
    NSLog(@"self.tableView.separatorInset = %@, self.tableView.separatorInset = %@", NSStringFromUIEdgeInsets(self.tableView.separatorInset), NSStringFromUIEdgeInsets(self.tableView.layoutMargins));
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NZQWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    NZQSettingCell *cell = [NZQSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NZQWordItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    // 普通的cell
    if(item.itemOperation){
        item.itemOperation(indexPath);
        return;
    }
    
    // 带箭头的cell
    if([item isKindOfClass:[NZQWordArrowItem class]]){
        NZQWordArrowItem *arrowItem = (NZQWordArrowItem *)item;
        
        if(arrowItem.destVc){
            UIViewController *vc = [[arrowItem.destVc alloc] init];
            if ([vc isKindOfClass:[UIViewController class]]) {
                vc.navigationItem.title = arrowItem.title;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return self.sections[section].footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}

- (NSMutableArray<NZQItemSection *> *)sections{
    if(_sections == nil){
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (NZQStaticTableViewController *(^)(NZQWordItem *))addItem {
    
    NZQWeak(self);
    if (!self.sections.firstObject) {
        [self.sections addObject:[NZQItemSection sectionWithItems:@[] andHeaderTitle:nil footerTitle:nil]];
    }
    return  ^NZQStaticTableViewController *(NZQWordItem *item) {
        [weakself.sections.firstObject.items addObject:item];
        return weakself;
    };
}

- (instancetype)init{
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

@end

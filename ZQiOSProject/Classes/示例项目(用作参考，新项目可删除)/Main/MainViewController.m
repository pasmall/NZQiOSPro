//
//  MainViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.tabBarItem setBadgeColor:[UIColor redColor]];
    [self.navigationController.tabBarItem setBadgeValue:@"25"];
    
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.height;
    self.tableView.contentInset = edgeInsets;
    [self loadData];
    
}

- (void)loadData{
    NZQWordArrowItem *item0 = [NZQWordArrowItem itemWithTitle:@"通用链接跳转" subTitle: @"根据连接跳转到APP,并打开某个页面"];
    

    NZQItemSection *section = [NZQItemSection sectionWithItems:@[item0] andHeaderTitle:nil footerTitle:nil];
    
    [self.sections addObject:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - 导航栏样式定义
- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar{
    return [UIColor whiteColor];
}

- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
    return [self changeTitle:@"查看功能页面"];
}



#pragma mark - 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle{
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
    
    return title;
}



@end

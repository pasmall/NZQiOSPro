//
//  DemoViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "DemoViewController.h"
#import "NZQPersonalViewController.h"
#import "NZQMessageViewController.h"
#import "NZQCustonBuildHomePage.h"
#import "NZQCustonBuildHomePage2.h"
#import "NZQBuildUserCenterPage.h"
#import "NZQWebViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    edgeInsets.bottom += self.tabBarController.tabBar.height;
    self.tableView.contentInset = edgeInsets;
    [self loadData];
}

- (void)loadData{
    NZQWordArrowItem *item0 = [NZQWordArrowItem itemWithTitle:@"个人中心" subTitle: @""];
    item0.destVc = [NZQPersonalViewController class];
    
    NZQWordArrowItem *item1 = [NZQWordArrowItem itemWithTitle:@"消息" subTitle: @""];
    item1.destVc = [NZQMessageViewController class];
    
    NZQWordArrowItem *item2 = [NZQWordArrowItem itemWithTitle:@"建筑定制首页" subTitle: @""];
    item2.destVc = [NZQCustonBuildHomePage class];
    
    NZQWordArrowItem *item3 = [NZQWordArrowItem itemWithTitle:@"建筑定制首页2" subTitle: @""];
    item3.destVc = [NZQCustonBuildHomePage2 class];
    
    NZQWordArrowItem *item4 = [NZQWordArrowItem itemWithTitle:@"我的" subTitle: @""];
    item4.destVc = [NZQBuildUserCenterPage class];
    
    NZQWordArrowItem *item5 = [NZQWordArrowItem itemWithTitle:@"html" subTitle: @""];
    item5.destVc = [NZQWebViewController class];
    
    
    NZQItemSection *section = [NZQItemSection sectionWithItems:@[item0,item1,item2,item3,item4,item5] andHeaderTitle:@"建筑定制" footerTitle:nil];
    [self.sections addObject:section];
}

#pragma mark - 导航栏样式定义
- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar{
    return [UIColor whiteColor];
}

- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
    return [[NSMutableAttributedString alloc]initWithString:@"Dmeo程序"];
}

@end

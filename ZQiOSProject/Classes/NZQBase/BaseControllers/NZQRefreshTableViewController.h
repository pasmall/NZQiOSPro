//
//  NZQRefreshTableViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQTableViewController.h"
#import "NZQAutoRefreshFooter.h"
#import "NZQNormalRefreshHeader.h"

@interface NZQRefreshTableViewController : NZQTableViewController

//子类重载该方法
- (void)loadMore:(BOOL)isMore;

- (void)endHeaderFooterRefreshing;

@end

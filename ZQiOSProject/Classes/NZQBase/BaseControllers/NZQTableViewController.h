//
//  NZQTableViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQBaseViewController.h"

@interface NZQTableViewController : NZQBaseViewController<UITableViewDelegate, UITableViewDataSource>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end

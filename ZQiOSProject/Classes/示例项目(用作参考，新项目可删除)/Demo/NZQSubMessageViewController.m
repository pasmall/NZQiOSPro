//
//  NZQSubMessageViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/6.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQSubMessageViewController.h"
#import "NZQCommentCell.h"

@interface NZQSubMessageViewController ()

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation NZQSubMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    [self loadMore:NO];
}

- (void)loadMore:(BOOL)isMore{
    
    NZQWeak(self);
    NSDictionary *para;
    
    if (isMore) {
        self.page += 1;
        para = @{@"uid":userID,
                 @"keyid":keyID,
                 @"page":@(self.page),
                 };
    }else{
        self.page = 1;
        para = @{@"uid":userID,
                 @"keyid":keyID,
                 @"page":@(self.page),
                 };
    }
    [weakself endHeaderFooterRefreshing];
    
    //    [[NZQRequestManager sharedManager] POST:BaseUrlWith(DataBuildMyCommList) parameters:para completion:^(NZQBaseResponse *response) {
    //        [weakself endHeaderFooterRefreshing];
    //
    //        if (response.error) {
    //            //错误提示
    //            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
    //                [weakself.tableView.mj_header beginRefreshing];
    //            }];
    //            return ;
    //        }
    //
    //        if (![response.responseObject[@"state"] boolValue]) {
    //            //发生错误
    //            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
    //                [weakself.tableView.mj_header beginRefreshing];
    //            }];
    //            return ;
    //        }
    //
    //        NSArray *array = response.responseObject[@"ext"][@"data"][@"list"];
    //        if (isMore) {
    //            [weakself.dataArray removeAllObjects];
    //            [weakself.dataArray addObjectsFromArray:array];
    //        }else{
    //            [weakself.dataArray addObjectsFromArray:array];
    //        }
    //
    //        //没有数据
    //        if (weakself.dataArray.count==0) {
    //            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
    //                [weakself.tableView.mj_header beginRefreshing];
    //            }];
    //
    //            return;
    //        }
    //
    //        [weakself.tableView reloadData];
    //    }];
    
}


#pragma mark - ZJScrollPageViewChildVcDelegate
- (void)zj_viewWillAppearForIndex:(NSInteger)index {
    [self viewWillAppear:YES];
}
- (void)zj_viewDidAppearForIndex:(NSInteger)index {
    [self viewDidAppear:YES];
    // bug fix
    self.view.height = self.view.superview.height;
}
- (void)zj_viewWillDisappearForIndex:(NSInteger)index {
    [self viewWillDisappear:YES];
}
- (void)zj_viewDidDisappearForIndex:(NSInteger)index {
    [self viewDidDisappear:YES];
}



#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NZQCommentCell *commetnCell = [NZQCommentCell commentCellWithTableView:tableView];
    
    if (indexPath.row == 2) {
        commetnCell.textLab.text = @"有一部分";
    }

    return commetnCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return self.topicService.topicViewModels[indexPath.row].cellHeight;
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"        " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    deleteAction.backgroundColor = [UIColor whiteColor];
    
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

#pragma mark 加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}


@end

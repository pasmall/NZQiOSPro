//
//  NZQCommentViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQCommentViewController.h"
#import "NZQCommentListCell.h"

@interface NZQCommentViewController ()

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation NZQCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    [self loadMore:NO];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 20)];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"评论";
    [header addSubview:titleLab];
    
    self.tableView.tableHeaderView = header;
    
    
    
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

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.dataArray.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NZQCommentListCell *cell = [NZQCommentListCell commentCellWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return self.topicService.topicViewModels[indexPath.row].cellHeight;
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 导航栏样式定义
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar{
    return [UIColor clearColor];
}

- (BOOL)nzqNavigationIsHideBottomLine:(NZQNavigationBar *)navigationBar{
    return YES;
}

- (UIImage *)nzqNavigationBarBackgroundImage:(NZQNavigationBar *)navigationBar{
    return [UIImage imageNamed:@"navBackImage"];
}

- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar{
    
    [leftButton setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    leftButton.tintColor = [UIColor whiteColor];
    return [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}


@end

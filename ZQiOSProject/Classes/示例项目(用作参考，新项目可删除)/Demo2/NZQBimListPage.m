//
//  NZQBimListPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/20.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQBimListPage.h"
#import "NZQBuildCell.h"
#import <ZFPlayerView.h>
#import "NZQProjectInfoViewController.h"


@interface NZQBimListPage ()

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)ZFPlayerView *playerView;

@end

@implementation NZQBimListPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadMore:NO];
    
}

- (void)loadMore:(BOOL)isMore{
    
    if (isMore) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    NZQWeak(self);
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildInfo) parameters:nil completion:^(NZQBaseResponse *response) {
        [weakself endHeaderFooterRefreshing];
        
        if (response.error) {
            //错误提示
            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [weakself.tableView.mj_header beginRefreshing];
            }];
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [weakself.tableView.mj_header beginRefreshing];
            }];
            return ;
        }
        
        NSArray *workList = response.responseObject[@"ext"][@"page"][@"list"];
        if (isMore) {
            [weakself.dataArray addObjectsFromArray:workList];
        }else{
            [weakself.dataArray removeAllObjects];
            [weakself.dataArray addObjectsFromArray:workList];
        }
        
        //没有数据
        if (weakself.dataArray.count==0) {
            [weakself.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                [weakself.tableView.mj_header beginRefreshing];
            }];
            
            return;
        }
        
        [weakself.tableView reloadData];
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NZQBuildCell *cell = [NZQBuildCell buildCellWithTableView:tableView];
    [cell setDataDic:self.dataArray[indexPath.row] WithType:NZQHomeCellTypeC];
    
    //播放
    @weakify(self);
    cell.startPlayVideo = ^(NZQBuildCell *cell) {
        [weak_self cellPlayClick:cell];
    };
    
    return cell;
    
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return self.topicService.topicViewModels[indexPath.row].cellHeight;
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *des = dic[@"title2"];
    CGFloat textH = [des heightForFont:[UIFont systemFontOfSize:13] width:kScreenWidth - 30];
    CGFloat videoH = (kScreenWidth - 30) * 9 / 16;
    return 70 + videoH + textH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQProjectInfoViewController *page = [[NZQProjectInfoViewController alloc]initWithTitle:dic[@"title"]];
    page.workID = [dic[@"id"] integerValue];
    [self.navigationController pushViewController:page animated:YES];
    
}

#pragma mark Action
- (void)cellPlayClick:(NZQBuildCell *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSURL *videoURL = [NSURL URLWithString:cell.dataDic[@"video"]];
    
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.title            = @"";
    playerModel.videoURL         = videoURL;
    playerModel.placeholderImageURLString = cell.dataDic[@"thumbnail"];
    playerModel.scrollView       = self.tableView;
    playerModel.indexPath        = indexPath;
    playerModel.fatherViewTag    = cell.videoImgView.tag;
    [self.playerView playerControlView:nil playerModel:playerModel];
    self.playerView.hasDownload = NO;
    [self.playerView autoPlayTheVideo];
}

#pragma mark 加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}

- (ZFPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.cellPlayerOnCenter = YES;
        _playerView.stopPlayWhileCellNotVisable = YES;
        
        ZFPlayerShared.isStatusBarHidden = YES;
    }
    return _playerView;
}

@end

//
//  NZQFiltrateResultPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQFiltrateResultPage.h"
#import "NZQBuildCell.h"
#import <ZFPlayerView.h>
#import "NZQCardInfoViewController.h"

@interface NZQFiltrateResultPage ()

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)ZFPlayerView *playerView;

@end

@implementation NZQFiltrateResultPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    [self loadMore:NO];
    
}

- (void)loadMore:(BOOL)isMore{
    
    NSAssert(!NZQStringIsEmpty(_zqType), @"必须传Type");
    
    NZQWeak(self);
    if (isMore) {
        self.page += 1;
    }else{
        self.page = 1;
    }
    NSDictionary *para = @{@"uid":userID,
                           @"page":@(self.page),
                           @"type":_zqType
                           };
    
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildSeek) parameters:para completion:^(NZQBaseResponse *response) {
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
        
        NSArray *workList = response.responseObject[@"ext"][@"data"][@"list"];
        if (isMore) {
            [weakself.dataArray addObjectsFromArray:workList];
        }else{
            [weakself.dataArray removeAllObjects];
            [weakself.dataArray addObjectsFromArray:workList];
        }
        

        if (weakself.dataArray.count == [response.responseObject[@"ext"][@"data"][@"count"] integerValue]) {
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
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

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NZQBuildCell *cell = [NZQBuildCell buildCellWithTableView:tableView];
    [cell setDataDic:self.dataArray[indexPath.row] WithType:NZQHomeCellTypeD];
    //播放
    @weakify(self);
    cell.startPlayVideo = ^(NZQBuildCell *cell) {
        [weak_self cellPlayClick:cell];
    };
    
    //个人中心
    cell.gotoUserCenter = ^(NZQBuildCell *cell) {
        
    };
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return self.topicService.topicViewModels[indexPath.row].cellHeight;
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *des = dic[@"description"];
    NSString *title = dic[@"title"];
    
    CGFloat titleOneH = [@"一行的高度" heightForFont:[UIFont systemFontOfSize:15] width:kScreenWidth - 30];
    CGFloat textOneH = [@"一行的高度" heightForFont:[UIFont systemFontOfSize:13] width:kScreenWidth - 30];
    
    CGFloat titleH = [title heightForFont:[UIFont systemFontOfSize:15] width:kScreenWidth - 30];
    CGFloat textH = [des heightForFont:[UIFont systemFontOfSize:13] width:kScreenWidth - 30];
    
    if (titleH >= titleOneH * 2) {
        titleH = titleOneH * 2;
    }
    if (textH >= textOneH * 3) {
        textH = textOneH * 3;
    }
    
    CGFloat videoH = (kScreenWidth - 30) * 9 / 16;
    return 115 + videoH + textH + titleH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQCardInfoViewController *page = [[NZQCardInfoViewController alloc]init];
    page.isPic = NO;
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
    playerModel.placeholderImageURLString = cell.dataDic[@"logourl"];
    playerModel.scrollView       = self.tableView;
    playerModel.indexPath        = indexPath;
    playerModel.fatherViewTag    = cell.videoImgView.tag;
    [self.playerView playerControlView:nil playerModel:playerModel];
    self.playerView.hasDownload = NO;
    [self.playerView autoPlayTheVideo];
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

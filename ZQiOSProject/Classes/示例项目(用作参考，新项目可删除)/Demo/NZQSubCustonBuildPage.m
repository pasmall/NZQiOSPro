//
//  NZQSubCustonBuildPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/10.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQSubCustonBuildPage.h"
#import "NZQWorkModel.h"
#import "NZQWorkCell.h"
#import "NZQProjectCell.h"
#import <ZFPlayer.h>


@interface NZQSubCustonBuildPage ()
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)NSInteger MaxPage;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)ZFPlayerView *playerView;

@end

@implementation NZQSubCustonBuildPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MaxPage = 10000;
    self.page = 1;
    [self loadMore:NO];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
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
        
        weakself.MaxPage = [response.responseObject[@"ext"][@"data"][@"pageCount"] integerValue];
        if (weakself.page == weakself.MaxPage) {
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        NZQWorkList *workList = [NZQWorkList modelWithDictionary:response.responseObject[@"ext"][@"data"]];
        if (isMore) {
            [weakself.dataArray addObjectsFromArray:workList.list];
        }else{
            [weakself.dataArray removeAllObjects];
            [weakself.dataArray addObjectsFromArray:workList.list];
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

- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
    return [self changeTitle:@"建筑定制"];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    
    return title;
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NZQWorkModel *mode = self.dataArray[indexPath.row];
    
    NZQWorkCell *cell;
    //手动判断是否是视频
    if (NZQStringIsEmpty(mode.video)) {
        cell = [NZQWorkCell workCell2WithTableView:tableView];
    }else{
        cell = [NZQWorkCell workCellWithTableView:tableView];
    }
    cell.dataModel = mode;
    
    //Cell事件
    NZQWeak(self);
    cell.PlayBlock = ^(NZQWorkCell *cell) {
        [weakself cellPlayClick:cell];
    };
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NZQWorkModel *mode = self.dataArray[indexPath.row];
    return mode.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark Action
- (void)cellPlayClick:(NZQWorkCell *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSURL *videoURL = [NSURL URLWithString:cell.dataModel.video];
    
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.title            = cell.dataModel.title;
    playerModel.videoURL         = videoURL;
    playerModel.placeholderImageURLString = cell.dataModel.logourl;
    playerModel.scrollView       = self.tableView;
    playerModel.indexPath        = indexPath;
    playerModel.fatherViewTag    = cell.bgImageView.tag;
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

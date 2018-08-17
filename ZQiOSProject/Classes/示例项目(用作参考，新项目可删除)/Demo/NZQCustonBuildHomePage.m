//
//  NZQCustonBuildHomePage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQCustonBuildHomePage.h"
#import "NZQWorkModel.h"
#import "NZQWorkCell.h"
#import "NZQProjectCell.h"
#import <ZFPlayer.h>
#import "NZQSelectTypeViewController.h"

//跳转
#import "NZQUpVide0ViewController.h"
#import "NZQProjectInfoViewController.h"
#import "NZQCardInfoViewController.h"


@interface NZQCustonBuildHomePage ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)ZFPlayerView *playerView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;

@end

@implementation NZQCustonBuildHomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    self.page = 1;
    [self loadCustomData];
    [self loadMore:NO];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}
- (void)setUI{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,100)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat NZQSpace = 15;
    UIButton *upVideoBtn = [[UIButton alloc]initWithFrame:CGRectMake(NZQSpace * 0.5, NZQSpace, headerView.height -20, headerView.height -20)];
    [upVideoBtn addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(8, 8)];
    
    [upVideoBtn setImage:[UIImage imageNamed:@"btn_addshow"] forState:UIControlStateNormal];
    [upVideoBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113" ] forState:UIControlStateNormal];
    [headerView addSubview:upVideoBtn];
    
    NZQWeak(self);
    [upVideoBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NZQUpVide0ViewController *vc = [[NZQUpVide0ViewController alloc]initWithTitle:@"基建定制上传"];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake( 120 , upVideoBtn.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(upVideoBtn.right + NZQSpace * 0.5,upVideoBtn.top,headerView.width - upVideoBtn.right -  NZQSpace * 0.5,upVideoBtn.height) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQProjectCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQProjectCell class])];

    [headerView addSubview:_collectionView];
    
    self.tableView.tableHeaderView = headerView;
}

- (void)loadCustomData{

    @weakify(self);
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildInfo) parameters:nil completion:^(NZQBaseResponse *response) {
        if (response.error) {
            //错误提示
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            return ;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weak_self.collectDataArray = response.responseObject[@"ext"][@"page"][@"list"];
                [weak_self.collectionView reloadData];
            });
        }
    }];
 
}


- (void)loadMore:(BOOL)isMore{
    
    NZQWeak(self);

    if (isMore) {
        _page ++;
    }else{
        _page = 15;
    }

    [[NZQRequestManager sharedManager] GET:BaseUrlWith(SeeVideoData) parameters:@{@"uid":userID,@"page":@(_page)} completion:^(NZQBaseResponse *response) {
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

-  (UIView *)nzqNavigationBarTitleView:(NZQNavigationBar *)navigationBar{
    
    UIView *searchBtn = [UIView new];
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.cornerRadius = 15;
    searchBtn.width = self.view.width - 100;
    searchBtn.height = 30;
    
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 20,  20)];
    imgV.image = [UIImage imageNamed:@"icon_homepage_search"];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
//    imgV.tintColor = [UIColor redColor];
    [searchBtn addSubview:imgV];
    

    UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+15, 0, 100, searchBtn.height)];
    textLab.textColor = [UIColor grayColor];
    textLab.text = @"搜索关键词";
    textLab.font = [UIFont systemFontOfSize:14];
    [searchBtn addSubview:textLab];
    
    return searchBtn;
}

- (UIImage *)nzqNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NZQNavigationBar *)navigationBar{
    [rightButton setImage:[[UIImage imageNamed:@"icon_homepage_filter"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    rightButton.tintColor = [UIColor whiteColor];
    return [[UIImage imageNamed:@"icon_homepage_filter"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    NZQSelectTypeViewController *selectVc = [[NZQSelectTypeViewController alloc]init];
    [self.navigationController pushViewController:selectVc animated:YES];
}

-(void)titleClickEvent:(UILabel *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    
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
    
    //点击头像
    cell.HeaderBlock = ^(NZQWorkCell *cell) {

    };
    
    //bgView
    cell.bgViewBlock = ^(NZQWorkCell *cell) {
        NZQCardInfoViewController *page = [[NZQCardInfoViewController alloc]init];
        page.isPic = NO;
        page.workID = [cell.dataModel.zqId integerValue];
        [weakself.navigationController pushViewController:page animated:YES];
    };
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NZQWorkModel *mode = self.dataArray[indexPath.row];
    return mode.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NZQWorkModel *mode = self.dataArray[indexPath.row];
    NZQCardInfoViewController *page = [[NZQCardInfoViewController alloc]init];
    page.isPic = YES;
    page.workID = [mode.zqId integerValue];
    [self.navigationController pushViewController:page animated:YES];
    
}

#pragma  mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.collectDataArray[indexPath.row];
    NZQProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQProjectCell class]) forIndexPath:indexPath];
    cell.dataDic = dic;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.collectDataArray[indexPath.row];
    NZQProjectInfoViewController *page = [[NZQProjectInfoViewController alloc]initWithTitle:dic[@"title"]];
    page.workID = [dic[@"id"] integerValue];
    [self.navigationController pushViewController:page animated:YES];
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

- (NSArray *)collectDataArray{
    if (!_collectDataArray) {
        _collectDataArray  = [NSMutableArray array];
    }
    return _collectDataArray;
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

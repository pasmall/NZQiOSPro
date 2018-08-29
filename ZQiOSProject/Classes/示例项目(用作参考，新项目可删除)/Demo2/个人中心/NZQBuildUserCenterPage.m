//
//  NZQBuildUserCenterPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQBuildUserCenterPage.h"
#import "ZJScrollPageView.h"
#import "NZQUserHeaderView.h"
#import "NZQAutoRefreshFooter.h"

#import "NZQMyCollectPage.h"
#import "NZQMyUpVideoListPage.h"
#import "NZQMyOrderListPage.h"

#import "NZQMyEditInfoPage.h"
#import "NZQMyFansListPage.h"
#import "NZQMyUpVideoViewController.h"


static CGFloat const segmentViewHeight = 44.0;
static CGFloat const headViewHeight = 130;

NSString *const NZQParentTableViewDidLeaveFromTopNotification = @"NZQParentTableViewDidLeaveFromTopNotification";


@interface ZJCustomGestureTableView : UITableView

@end

@implementation ZJCustomGestureTableView

/// 返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}
@end

@interface NZQBuildUserCenterPage ()<ZJScrollPageViewDelegate, NZQPageViewControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray<NSString *> *titles;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (strong, nonatomic) NZQUserHeaderView *headView;
@property (strong, nonatomic) UIScrollView *childScrollView;
@property (strong, nonatomic) ZJCustomGestureTableView *tableView;

@property (strong, nonatomic)UIImageView *headBgView;
@property (strong, nonatomic)UIView *sectionView;
@property (assign, nonatomic)UIStatusBarStyle statusBarStyle;
@property (nonatomic,assign)NSInteger currentVcIndex;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;


@end

@implementation NZQBuildUserCenterPage

- (void)viewDidLoad {
    [super viewDidLoad];

    [self childVcs];
    [self setUI];
    self.nzq_navgationBar.titleView.hidden = YES;
    self.nzq_navgationBar.rightView.hidden = YES;
    _statusBarStyle = UIStatusBarStyleDefault;
    
    [self getData];
}

- (void)setUI{
    
    [self.view addSubview:self.tableView];
    _headView.bgImgView.top = - self.nzq_navgationBar.bottom;
    _headBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 125)];
    [_headBgView setImage:[UIImage imageNamed:@"bg_jzdzpersonal_top"]];
    _headBgView.backgroundColor = [UIColor whiteColor];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, self.nzq_navgationBar.bottom, self.view.width, 125 - self.nzq_navgationBar.bottom)];
    [_headBgView addSubview:whiteView];
    [self.view insertSubview:_headBgView belowSubview:_tableView];
    
    
    //头视图事件
    @weakify(self);
    _headView.gotoEditInfo = ^(NZQUserHeaderView *cell) {
        NZQMyEditInfoPage *page = [[NZQMyEditInfoPage  alloc]initWithTitle:@"编辑简介"];
        [weak_self.navigationController pushViewController:page animated:YES];
        
    };
    _headView.gotoSeePage = ^(NZQUserHeaderView *cell) {

        NZQMyFansListPage *page = [[NZQMyFansListPage  alloc]initWithTitle:@"我的关注"];
        page.isFans = NO;
        [weak_self.navigationController pushViewController:page animated:YES];
    };
    _headView.gotoFansPage = ^(NZQUserHeaderView *cell) {
        NZQMyFansListPage *page = [[NZQMyFansListPage  alloc]initWithTitle:@"我的粉丝"];
        page.isFans = YES;
        [weak_self.navigationController pushViewController:page animated:YES];
    };
    

}

- (void)getData{
    NSDictionary *para = @{@"uid":userID,
                           @"keyid":keyID,
                           };
    
    @weakify(self);
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildInformation) parameters:para completion:^(NZQBaseResponse *response) {

        if (response.error) {
            //错误提示
            [weak_self.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [weak_self getData];
            }];
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weak_self.tableView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [weak_self getData];
            }];
            return ;
        }

        [weak_self setUIWithData:response.responseObject[@"ext"][@"list"]];

        
    }];
}

- (void)setUIWithData:(NSDictionary *)dic{
    _headView.dataDic = dic;
    
    for (int i = 0; i < self.titles.count; i++ ) {
        UILabel *subLab = [_sectionView viewWithTag:i + 100];
        
        switch (i) {
            case 0:{
                subLab.text = [NSString stringWithFormat:@"%ld",[dic[@"collectCount"] integerValue]];
            }
                break;
            case 1:{
                subLab.text = [NSString stringWithFormat:@"%ld",[dic[@"artCount"] integerValue]];
            }
                break;
            case 2:{
                subLab.text = [NSString stringWithFormat:@"%ld",[dic[@"resCount"] integerValue]];
            }
                break;
                
            default:
                break;
        }
    }
    
    
}


#pragma ZJScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    
    if (index == 1) {
        self.nzq_navgationBar.rightView.hidden = NO;
    }else{
        self.nzq_navgationBar.rightView.hidden = YES;
    }

    _currentVcIndex = index;
    return childVc;
}


#pragma mark- ZJPageViewControllerDelegate

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (self.tableView.contentOffset.y < headViewHeight) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }else {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
        scrollView.showsVerticalScrollIndicator = YES;
    }
    
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childScrollView && _childScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < headViewHeight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NZQParentTableViewDidLeaveFromTopNotification object:nil];
        
        if (offsetY > 0) {
            _headBgView.top = -offsetY;
        }else{
            _headBgView.top = 0;
        }
        
        
        _statusBarStyle = UIStatusBarStyleDefault;
        self.nzq_navgationBar.backgroundImage = [UIImage imageWithColor:COLORA(0, 0, 0, 0)];
        self.nzq_navgationBar.titleView.hidden = YES;
        self.nzq_navgationBar.leftView.tintColor = [UIColor blackColor];
        
    }else{
        
        
        _statusBarStyle = UIStatusBarStyleLightContent;
        self.nzq_navgationBar.backgroundImage = [UIImage imageNamed:@"navBackImage"];
        self.nzq_navgationBar.titleView.hidden = NO;
        self.nzq_navgationBar.leftView.tintColor = [UIColor whiteColor];
    }
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

#pragma mark- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"`1`"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"`1`"];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.contentView];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, segmentViewHeight * 2)];
    sectionView.backgroundColor = [UIColor whiteColor];
    [sectionView addSubview:self.segmentView];
    
    //创建三个lab
    CGFloat width = self.view.width / self.titles.count;
    for (int i = 0 ; i < self.titles.count; i ++) {
        UILabel *countLab = [[UILabel alloc]initWithFrame:CGRectMake(width*i, 26, width, 18)];
        countLab.tag = 100 + i;
        countLab.font = [UIFont systemFontOfSize:17 weight:0.8];
        countLab.textAlignment = NSTextAlignmentCenter;
        countLab.text = @"";
        [sectionView addSubview:countLab];
        
    }
    
    _sectionView = sectionView;
    
    return sectionView;
}

#pragma mark- setter getter
- (ZJScrollSegmentView *)segmentView {
    if (_segmentView == nil) {
        
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.scrollTitle = NO;
        style.showLine = YES;
        style.scrollLineHeight = 8;
        style.scrollLineColor = [UIColor clearColor];
        style.scrollContentView = YES;
        style.titleFont = [UIFont systemFontOfSize:15];
        style.coverBackgroundColor = [UIColor clearColor];
        style.normalTitleColor = [UIColor darkGrayColor];
        style.selectedTitleColor = [UIColor blackColor];
        style.animatedContentViewWhenTitleClicked = YES;
        style.haveNZQLine = YES;
        
        self.titles =  @[@"收藏",@"上传",@"预约"];
        
        @weakify(self);
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0,44, self.view.bounds.size.width, segmentViewHeight) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            
            [weak_self.contentView setContentOffSet:CGPointMake(weak_self.contentView.bounds.size.width * index, 0.0) animated:YES];
            
        }];
        segment.backgroundColor = [UIColor whiteColor];
        _segmentView = segment;
        
    }
    return _segmentView;
}


#pragma mark 加载
- (ZJContentView *)contentView {
    if (_contentView == nil) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:self.view.bounds segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}

- (NZQUserHeaderView *)headView {
    if (!_headView) {
        _headView = [[NZQUserHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headViewHeight)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    
    return _headView;
}

- (ZJCustomGestureTableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0.0f, self.nzq_navgationBar.bottom, self.view.bounds.size.width, self.view.bounds.size.height - self.nzq_navgationBar.bottom);
        ZJCustomGestureTableView *tableView = [[ZJCustomGestureTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.tableHeaderView = self.headView;
        tableView.rowHeight = self.contentView.bounds.size.height;
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.sectionHeaderHeight = segmentViewHeight * 2;
        tableView.showsVerticalScrollIndicator = false;
        _tableView = tableView;
    }
    
    return _tableView;
}

- (NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *)childVcs{
    if (!_childVcs) {
        NZQMyCollectPage  *page1 = [[NZQMyCollectPage alloc]initWithTitle:@"收藏"];
        NZQMyUpVideoListPage  *page2 = [[NZQMyUpVideoListPage alloc]initWithTitle:@"上传"];
        NZQMyOrderListPage  *page3 = [[NZQMyOrderListPage alloc]initWithTitle:@"预约"];
        
        [self addChildViewController:page1];
        [self addChildViewController:page2];
        [self addChildViewController:page3];
        
        _childVcs = @[page1,page2,page3];
    }
    
    return _childVcs;
}



#pragma mark - 导航栏样式定义
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar{
    return [UIColor clearColor];
}

- (UIImage *)nzqNavigationBarBackgroundImage:(NZQNavigationBar *)navigationBar{
    
    return [UIImage imageWithColor:COLORA(0, 0, 0, 0)];
}

- (BOOL)nzqNavigationIsHideBottomLine:(NZQNavigationBar *)navigationBar{
    return YES;
}

- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar{
    
    [leftButton setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    leftButton.tintColor = [UIColor blackColor];
    return [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (UIImage *)nzqNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NZQNavigationBar *)navigationBar{
    return [UIImage imageNamed:@"cinct_162"];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    NZQMyUpVideoViewController *page = [[NZQMyUpVideoViewController alloc]initWithTitle:@"上传"];
    [self.navigationController pushViewController:page animated:YES];
}

@end

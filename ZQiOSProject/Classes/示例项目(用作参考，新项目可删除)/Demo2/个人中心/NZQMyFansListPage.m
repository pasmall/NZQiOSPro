//
//  NZQMyFansListPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyFansListPage.h"
#import "NZQVerticalFlowLayout.h"
#import "NZQAutoRefreshFooter.h"

#import "NZQMyFansCell.h"

@interface NZQMyFansListPage ()<NZQVerticalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation NZQMyFansListPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self makeData];
}

- (void)makeData{
    
    _page ++;
    NSDictionary *param;
    NSString *urlStr;

    if (_isFans) {
        urlStr = BaseUrlWith(DataBuildMyfocus);
        param = @{@"page":@(_page),
                  @"uid":userID,
                  @"keyid":keyID,
                  };

    }else{
        urlStr = BaseUrlWith(DataBuildFocusList);
        param = @{@"page":@(_page),
                  @"uid":userID,
                  @"keyid":keyID,
                  };
    }



    @weakify(self);
    [[NZQRequestManager sharedManager] GET:urlStr parameters:param completion:^(NZQBaseResponse *response) {
        if (response.error) {
            //错误提示
            [weak_self.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {

            }];
            return ;
        }

        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weak_self.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {

            }];
            return ;
        }

        NSArray *workList = response.responseObject[@"ext"][@"page"][@"list"];
        [weak_self.dataArray addObjectsFromArray:workList];


        //没有数据
        if (weak_self.dataArray.count==0) {
            [weak_self.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {

            }];
            return;
        }

        //所有数据加载完毕了
        if (weak_self.dataArray.count == [response.responseObject[@"ext"][@"page"][@"count"] integerValue]) {
            [weak_self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }

        [weak_self.collectionView reloadData];
    }];
    
}

- (void)setUI{
    
    @weakify(self);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(0);
        make.top.mas_equalTo(weak_self.nzq_navgationBar.bottom);
    }];
    
}

#pragma mark -加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120) collectionViewLayout:[[NZQVerticalFlowLayout alloc] initWithDelegate:self]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.scrollEnabled = YES;
        
        @weakify(self);
        _collectionView.mj_footer = [NZQAutoRefreshFooter footerWithRefreshingBlock:^{
            [weak_self makeData];
        }];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQMyFansCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQMyFansCell class])];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - NZQVerticalFlowLayoutDelegate
- (NSInteger)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{

    return 210 ;
}

- (UIEdgeInsets)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQMyFansCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQMyFansCell class]) forIndexPath:indexPath];
    cell.dataDic = dic;
    return cell;
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

@end

//
//  NZQTypeListViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQTypeListViewController.h"
#import "NZQVerticalFlowLayout.h"

#import "NZQSubCustonBuildPage.h"
#import "NZQTypeListCell.h"
#import "NZQFiltrateResultPage.h"

static const CGFloat NZQSpacing = 15;

@interface NZQTypeListViewController ()<NZQVerticalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation NZQTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self makeData];
}

- (void)makeData{
    
    NZQWeak(self);
    [[NZQRequestManager sharedManager]GET:BaseUrlWith(DataBuildTagsList) parameters:nil completion:^(NZQBaseResponse *response) {
        if (response.error) {
            //错误提示
            [weakself.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                
            }];
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            [weakself.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                
            }];
            return ;
        }
        
        weakself.dataArray = response.responseObject[@"ext"][@"page"][0][@"array"];
        
        //没有数据
        if (weakself.dataArray.count==0) {
            [weakself.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                
            }];
            
            return;
        }
        [weakself.collectionView reloadData];
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
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQTypeListCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQTypeListCell class])];
    }
    return _collectionView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

#pragma mark - NZQVerticalFlowLayoutDelegate
- (NSInteger)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    return 220;
}

- (UIEdgeInsets)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView{
    return UIEdgeInsetsMake(NZQSpacing, NZQSpacing, NZQSpacing, NZQSpacing);
}


#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQTypeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQTypeListCell class]) forIndexPath:indexPath];
    cell.dataDic = dic;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQFiltrateResultPage *page = [[NZQFiltrateResultPage alloc]initWithTitle:@"建筑定制"];
    page.zqType = dic[@"id"];
    [self.navigationController pushViewController:page animated:YES];

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

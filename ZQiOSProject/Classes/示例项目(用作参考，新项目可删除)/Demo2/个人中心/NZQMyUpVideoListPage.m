//
//  NZQMyUpVideoListPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyUpVideoListPage.h"
#import "NZQVerticalFlowLayout.h"
#import "NZQMyUpVideoCell.h"
#import "NZQAutoRefreshFooter.h"
#import "NZQCardInfoViewController.h"


static const CGFloat NZQSpacing = 10;
@interface NZQMyUpVideoListPage ()<NZQVerticalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation NZQMyUpVideoListPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self makeData];
}

- (void)makeData{
    
    _page ++;
    @weakify(self);
    NSDictionary *param = @{@"page":@(_page),
                            @"uid":userID,
                            @"keyid":keyID,
                            @"is_scenery":@"1,3"
                            };
    
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildUpload) parameters:param completion:^(NZQBaseResponse *response) {
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
        
        NSArray *workList = response.responseObject[@"ext"][@"list"][@"list"];
        [weak_self.dataArray addObjectsFromArray:workList];
        
        
        //没有数据
        if (weak_self.dataArray.count==0) {
            [weak_self.collectionView configBlankPage:NZQEasyBlankPageViewTypeNoData hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
                
            }];
            return;
        }
        
        //所有数据加载完毕了
        if (weak_self.dataArray.count == [response.responseObject[@"ext"][@"list"][@"count"] integerValue]) {
            [weak_self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [weak_self.collectionView reloadData];
    }];
    
}

- (void)setUI{
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
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
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQMyUpVideoCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQMyUpVideoCell class])];
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
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *title = dic[@"title"];
    CGFloat titleH = [title heightForFont:[UIFont systemFontOfSize:15] width:(itemWidth-40)];
    
    return 210 + titleH ;
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
    NZQMyUpVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQMyUpVideoCell class]) forIndexPath:indexPath];
    cell.dataDic = dic;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArray[indexPath.row];
    NZQCardInfoViewController *page = [[NZQCardInfoViewController alloc]init];
    page.isPic = NO;
    page.workID = [dic[@"id"] integerValue];
    [self.navigationController pushViewController:page animated:YES];
    
}


@end

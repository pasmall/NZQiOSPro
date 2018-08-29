//
//  NZQCardInfoViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/14.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyCardInfoViewController.h"
#import <SDCycleScrollView.h>
#import <WebKit/WebKit.h>
#import <ZFPlayer.h>
#import "NZQHorizontalFlowLayout.h"
#import "NZQAutoRefreshFooter.h"
#import "NZQSubmitInfoViewController.h"
#import "NZQCommentViewController.h"

#import "NZQWorkModel.h"
#import "NZQProjectCell.h"

@interface NZQMyCardInfoViewController ()<SDCycleScrollViewDelegate,WKNavigationDelegate,NZQHorizontalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *colBtn;


@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)UILabel *indexLab;
@property (nonatomic,strong)NSDictionary *dataDic;
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *collectDataArray;
@property (nonatomic,assign)NSInteger colPage;
@property (nonatomic,strong)UIView *downView;
@property (nonatomic,strong)ZFPlayerView *playerView;
@property (nonatomic,strong)UILabel *locLab;
@property (nonatomic,assign)BOOL noMoreData;

@end

@implementation NZQMyCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _colPage = 1;
    [self setUI];
    [self getData];
    [self setBtnsEvent];

}

- (void)getData{
    
    [self showLoading];
    @weakify(self);
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataSceneryDetails) parameters:@{@"id":@(_workID),@"uid":userID} completion:^(NZQBaseResponse *response) {
        [weak_self dismissLoading];
        if (response.error) {
            //错误提示
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            return ;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weak_self setDataWithDic:response.responseObject[@"ext"][@"data"][@"list"][0]];
            });
        }
    }];
}

- (void)loadCollectionData{

    @weakify(self);
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataSceneryList) parameters:@{@"uid":userID,@"page":@(_colPage)} completion:^(NZQBaseResponse *response) {
        [weak_self.collectionView.mj_footer endRefreshing];
        
        if (response.error) {
            //错误提示
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            return ;
        }
        
        NSArray *workList = response.responseObject[@"ext"][@"data"][@"list"];
        [weak_self.collectDataArray addObjectsFromArray:workList];


        //没有更多数据
        if (weak_self.collectDataArray.count== [response.responseObject[@"ext"][@"data"][@"count"] integerValue]) {
            weak_self.noMoreData = YES;
        }
        weak_self.colPage++;
        [weak_self.collectionView reloadData];
        
    }];
}

- (void)setDataWithDic:(NSDictionary *)dic{
    _dataDic = dic;
    if (_isPic) {
        NSArray *array = _dataDic[@"pictures"];
        self.cycleScrollView.imageURLStringsGroup = array;
        _indexLab.text = [NSString stringWithFormat:@"1/%ld",array.count];
        
    }else{
        [_headerView setImageURL:[NSURL URLWithString:dic[@"thumbnail"]]];
    }
    
    _titleLab.text = dic[@"info"];
    _timeLab.text = dic[@"add_time"];
    _locLab.text = dic[@"address"];
    [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dic[@"pageView"] integerValue] + 1] forState:UIControlStateNormal];

    
    
    if (NZQIsEmpty(dic[@"article"])) {
        
    }else{
        [self.webView loadHTMLString:dic[@"article"] baseURL:nil];
    }
    
    _bottomView = [[UIView alloc]init];

}



- (void)setUI{
    _headerView.userInteractionEnabled = YES;
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.tag = 111;
    _contentView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    
    if (_isPic) {
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 180) delegate:self placeholderImage:nil];
        _cycleScrollView.autoScroll = NO;
        _cycleScrollView.showPageControl = NO;
        [_headerView addSubview:_cycleScrollView];
        
        _indexLab = [[UILabel alloc]init];
        _indexLab.textColor = [UIColor whiteColor];
        _indexLab.font = [UIFont systemFontOfSize:12];
        _indexLab.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_indexLab];
        
        [_indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(21);
        }];
        
        
    }else{
        UIImageView *playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
        [_headerView addSubview:playImg];
        @weakify(self);
        [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(48, 48));
            make.center.mas_equalTo(weak_self.headerView).centerOffset(CGPointMake(0,0));
        }];
        
        [_headerView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            
            ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];

            playerModel.videoURL         = [NSURL URLWithString:weak_self.dataDic[@"video"]];
            playerModel.placeholderImageURLString = weak_self.dataDic[@"logourl"];
            playerModel.scrollView       = weak_self.scrollView;
            playerModel.fatherView = weak_self.headerView;
            playerModel.fatherViewTag    = weak_self.headerView.tag;
            [weak_self.playerView playerControlView:nil playerModel:playerModel];
            weak_self.playerView.hasDownload = NO;
            [weak_self.playerView autoPlayTheVideo];
        }];
        
    }
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;

    _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:wkWebConfig];
    [_contentView addSubview:_webView];
    _webView.userInteractionEnabled = NO;
    _webView.navigationDelegate = self;
    @weakify(self);
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.colBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    _bottomView  = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor bgViewColor];
    [_contentView addSubview:_bottomView];

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(weak_self.webView.mas_bottom);
        make.height.mas_equalTo(214);
    }];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [_bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(54);
        make.top.mas_equalTo(0);
    }];
    
    //进入地图
    [lineView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
    }];
    
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [lineView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(0);
    }];
    
    UIImageView *locImage = [[UIImageView alloc]init];
    locImage.image = [UIImage imageNamed:@"cinct_182"];
    locImage.contentMode = UIViewContentModeScaleAspectFit;
    [lineView addSubview:locImage];
    [locImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(20);
        make.width.height.mas_equalTo(20);
    }];
    
    _locLab = [[UILabel alloc]init];
    _locLab.font = [UIFont systemFontOfSize:14];
    _locLab.numberOfLines = 2;
    [lineView addSubview:_locLab];
    [_locLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locImage.mas_right).offset(10);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel *designLab = [[UILabel alloc]init];
    designLab.textColor = [UIColor blackColor];
    designLab.text = @"推荐设计";
    designLab.font = [UIFont systemFontOfSize:15];
    [_bottomView addSubview:designLab];
    [designLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(21);
    }];
    
    NZQHorizontalFlowLayout *layout = [[NZQHorizontalFlowLayout alloc] initWithDelegate:self];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor bgViewColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsZero;
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    _collectionView.directionalLockEnabled = YES;
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NZQProjectCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([NZQProjectCell class])];
    
    [_bottomView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(designLab.mas_bottom);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(120);
    }];
    [self loadCollectionData];
    
    _downView = [[UIView alloc]init];
    _downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downView];
    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *desLab = [[UILabel alloc]init];
    desLab.font = [UIFont systemFontOfSize:15];
    [_downView addSubview:desLab];
    
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth *0.6);
    }];
    
    
    
    UIButton *desBtn = [[UIButton alloc]init];
    [desBtn setTitle:@"定制设计" forState:UIControlStateNormal];
    [desBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateNormal];
    desBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_downView addSubview:desBtn];
    
    [desBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(desLab.mas_right);
    }];
    
    
    [desBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        [weak_self.navigationController  pushViewController:[[NZQSubmitInfoViewController alloc] initWithTitle:@"申请预约"] animated:YES];
    }];

    
//    CGFloat safeAre = kScreenHeight - self.nzq_navgationBar.height + 44;
    
//    _contentHeight.constant = (self.webView.bottom + 180 + 20 + 40)>_scrollView.height?(self.webView.bottom + 180 + 20 + 40):_scrollView.height;
    _contentHeight.constant = self.webView.bottom + 214 + 20 + 40;
}

#pragma mark - action
- (void)setBtnsEvent{

}


#pragma mark - 导航条渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView != _scrollView) {
        return;
    }
    
    CGFloat kNavBarHeight = self.nzq_navgationBar.height;
    CGPoint contentOffset = scrollView.contentOffset;

    if (contentOffset.y < kNavBarHeight) {
        self.nzq_navgationBar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor]];
        self.nzq_navgationBar.title = [self changeTitle:@""];
    }else if (contentOffset.y >= kNavBarHeight){
        self.nzq_navgationBar.backgroundImage = [UIImage imageNamed:@"navBackImage"];
        self.nzq_navgationBar.title = [self changeTitle:@"作品详情"];
    }

}


#pragma mark - NZQHorizontalFlowLayoutDelegate

- (CGFloat)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight{
    return 160;
}

- (NSInteger)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *mode = self.collectDataArray[indexPath.row];
    NZQProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQProjectCell class]) forIndexPath:indexPath];
    cell.dataDic2 = mode;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_noMoreData) {
        return;
    }
    
    if (indexPath.row == self.collectDataArray.count -1) {
        [self loadCollectionData];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSDictionary *mode = self.collectDataArray[indexPath.row];
    NZQMyCardInfoViewController *page = [[NZQMyCardInfoViewController alloc]init];
    page.workID = [mode[@"id"] integerValue];
    [self.navigationController pushViewController:page animated:YES];
}


#pragma mark  - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {

    }];

}

#pragma mark  - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object != _webView.scrollView) {
        return;
    }
    
    CGFloat newHeight = self.webView.scrollView.contentSize.height;
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
    
//    _contentHeight.constant = (self.webView.bottom + 180 + 20 + 40)>_scrollView.height?(self.webView.bottom + 180 + 20 + 40):_scrollView.height;
    
    _contentHeight.constant = self.webView.bottom + 214 + 20 + 40;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    NSArray *array = _dataDic[@"pictures"];
    _indexLab.text = [NSString stringWithFormat:@"%ld/%ld",index+1,array.count];
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

- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar{
    
    [leftButton setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    leftButton.tintColor = [UIColor whiteColor];
    return [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 加载
- (NSMutableArray *)collectDataArray{
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

- (void)dealloc{
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end

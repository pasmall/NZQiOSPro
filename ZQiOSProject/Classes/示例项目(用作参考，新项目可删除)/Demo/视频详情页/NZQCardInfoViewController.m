//
//  NZQCardInfoViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/14.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQCardInfoViewController.h"
#import <SDCycleScrollView.h>
#import <WebKit/WebKit.h>
#import <ZFPlayer.h>
#import "NZQHorizontalFlowLayout.h"
#import "NZQAutoRefreshFooter.h"
#import "NZQSubmitInfoViewController.h"
#import "NZQCommentViewController.h"

#import "NZQWorkModel.h"
#import "NZQProjectCell.h"

#import "NZQBottomViewPresentationController.h"
#import "NZQMyCommentListPage.h"

@interface NZQCardInfoViewController ()<SDCycleScrollViewDelegate,WKNavigationDelegate,NZQHorizontalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *colBtn;
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addreLab;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIView *focusBg;

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

@end

@implementation NZQCardInfoViewController

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
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildSeeVideoOne) parameters:@{@"id":@(_workID),@"uid":userID} completion:^(NZQBaseResponse *response) {
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
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(SeeVideoData) parameters:@{@"uid":userID,@"page":@(_colPage)} completion:^(NZQBaseResponse *response) {
        [weak_self.collectionView.mj_footer endRefreshing];
        
        if (response.error) {
            //错误提示
            return ;
        }
        
        if (![response.responseObject[@"state"] boolValue]) {
            //发生错误
            return ;
        }
        
        NZQWorkList *workList = [NZQWorkList modelWithDictionary:response.responseObject[@"ext"][@"data"]];
        [weak_self.collectDataArray addObjectsFromArray:workList.list];


        //没有数据
        if (weak_self.collectDataArray .count==0) {
            return;
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
        [_headerView setImageURL:[NSURL URLWithString:dic[@"logourl"]]];
    }
    
    _titleLab.text = dic[@"title"];
    _timeLab.text = dic[@"add_Time"];
    
    if ([dic[@"isCollect"] boolValue]) {
        [_colBtn setTitle:dic[@"collectCount"] forState:UIControlStateSelected];
        [_colBtn setTitle:[NSString stringWithFormat:@"%ld",[dic[@"collectCount"] integerValue] - 1] forState:UIControlStateNormal];
        _colBtn.selected = YES;
    }else{
        [_colBtn setTitle:dic[@"collectCount"] forState:UIControlStateNormal];
        [_colBtn setTitle:[NSString stringWithFormat:@"%ld",[dic[@"collectCount"] integerValue] + 1] forState:UIControlStateSelected];
        _colBtn.selected = NO;
    }
    
    [_comBtn setTitle:dic[@"commCount"] forState:UIControlStateNormal];
    
    [_icon setImageURL:[NSURL URLWithString:dic[@"headlogourl"]]];
    [_icon addRoundedCorners:UIRectCornerAllCorners];
    
    _nameLab.text = dic[@"nickname"];
    _addreLab.text = [NSString stringWithFormat:@"%@,%@",dic[@"provice"],dic[@"city"]];
    
    _focusBtn.backgroundColor = [UIColor whiteColor];
    [_focusBtn addRoundedCorners:UIRectCornerAllCorners];
    
    _focusBg.backgroundColor = [UIColor whiteColor];
    _focusBg.layer.cornerRadius = 12;
    [_focusBg addShadowWithColor:[UIColor zqBlueColor]];
    _focusBtn.selected = [dic[@"isFocus"] boolValue];
    
    if (NZQIsEmpty(dic[@"info"])) {
        
    }else{
        [self.webView loadHTMLString:dic[@"info"] baseURL:nil];
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
        make.top.mas_equalTo(weak_self.icon.mas_bottom);
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
        make.height.mas_equalTo(180);
    }];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [_bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(0);
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
    _contentHeight.constant = self.webView.bottom + 180 + 20 + 40;
}

#pragma mark - action
- (void)setBtnsEvent{
    
    @weakify(self);
    //收藏
    [_colBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
        NSDictionary *dic = @{@"uid":userID,@"keyid":keyID,@"artId":weak_self.dataDic[@"id"]};
        [[NZQRequestManager sharedManager] POST:BaseUrlWith(DataBuildCollect) parameters:dic completion:^(NZQBaseResponse *response) {
            if (response.error) {
                //错误提示
                return ;
            }
            
            if (![response.responseObject[@"state"] boolValue]) {
                //发生错误
                return ;
            }else{
                weak_self.colBtn.selected = !weak_self.colBtn.selected;
            }
        }];
        
    }];
    
    
    //评论
    [_comBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
//        NZQCommentViewController *page = [[NZQCommentViewController  alloc]initWithTitle:@""];
//        [weak_self.navigationController pushViewController:page animated:YES];
        
        NZQMyCommentListPage *page = [[NZQMyCommentListPage alloc]init];
        page.zqId = [weak_self.dataDic[@"id"] integerValue];
        NZQBottomViewPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
        presentationController = [[NZQBottomViewPresentationController alloc] initWithPresentedViewController:page presentingViewController:self];
        page.transitioningDelegate = presentationController;
        [self presentViewController:page animated:YES completion:NULL];
    }];
    
    //分享
    [_shareBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
    }];
    
    _icon.userInteractionEnabled = YES;
    //作者个人中心
    [_icon addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
    }];
    
    //关注作者
    [_focusBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
        NSDictionary *dic = @{@"uid":userID,@"keyid":keyID,@"focus_uid":weak_self.dataDic[@"uid"]};
        [[NZQRequestManager sharedManager] POST:BaseUrlWith(DataBuildAddFocus) parameters:dic completion:^(NZQBaseResponse *response) {
            if (response.error) {
                //错误提示
                return ;
            }
            
            if (![response.responseObject[@"state"] boolValue]) {
                //发生错误
                return ;
            }else{
                weak_self.focusBtn.selected = !weak_self.focusBtn.selected;
            }
        }];
        
    }];
    
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
    NZQWorkModel *mode = self.collectDataArray[indexPath.row];
    NZQProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NZQProjectCell class]) forIndexPath:indexPath];
    cell.dataModel = mode;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.collectDataArray.count -1) {
        [self loadCollectionData];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NZQWorkModel *mode = self.collectDataArray[indexPath.row];
    NZQCardInfoViewController *page = [[NZQCardInfoViewController alloc]init];
    page.workID = [mode.zqId integerValue];
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
    
    _contentHeight.constant = self.webView.bottom + 180 + 20 + 40;
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

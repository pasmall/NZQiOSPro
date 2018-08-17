//
//  NZQProjectInfoViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/14.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQProjectInfoViewController.h"
#import <WebKit/WebKit.h>

@interface NZQProjectInfoViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *videoImage;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *timeLab;
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)UIView *containerView;
@property (nonatomic,strong)UIScrollView *scrollView;


@end

@implementation NZQProjectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self getData];
    self.nzq_navgationBar.title = [self changeTitle:@""];
}

- (void)getData{

    [self showLoading];
    @weakify(self);
    
    [[NZQRequestManager sharedManager] GET:BaseUrlWith(DataBuildInfoDet) parameters:@{@"id":@(_workID),@"uid":userID} completion:^(NZQBaseResponse *response) {
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
                [weak_self setDataWithDic:response.responseObject[@"ext"][@"data"]];
            });
        }
    }];
}

- (void)setDataWithDic:(NSDictionary *)dic{
    [self.videoImage setImageURL:[NSURL URLWithString:dic[@"thumbnail"]]];
    self.titleLab.text = dic[@"title3"];
    self.timeLab.text = dic[@"add_time"];
    
    [self.webView loadHTMLString:dic[@"info"] baseURL:nil];
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200);
    }];
    @weakify(self);
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.webView.mas_bottom);
    }];
}


- (void)setUI{
    
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.bounces = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.tag = 100;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    _scrollView.frame = CGRectMake(0, 0, self.view.width, kScreenHeight);
    
    UIButton *appointBtn = [[UIButton alloc]initWithFrame:CGRectZero buttonTitle:@"预约" normalBGColor:nil selectBGColor:nil normalColor:[UIColor whiteColor] selectColor:nil buttonFont:[UIFont systemFontOfSize:15] cornerRadius:0 doneBlock:^(UIButton *btn) {
        
    }];
    [appointBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateNormal];
    [self.view addSubview:appointBtn];
    [appointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_containerView];
    @weakify(self);
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.mas_equalTo(weak_self.scrollView.width);
    }];
    

    
    self.videoImage = [[UIImageView alloc]init];
    [_containerView addSubview:_videoImage];
    [_videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    _videoImage.userInteractionEnabled = YES;
    [_videoImage addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {

    }];
    
    UIImageView *playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
    [_videoImage addSubview:playImg];
    
    [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.center.mas_equalTo(weak_self.videoImage).centerOffset(CGPointMake(0,0));
    }];
    
    
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.font = [UIFont systemFontOfSize:17 weight:1];
    _titleLab.textColor = [UIColor blackColor];
    _titleLab.numberOfLines = 0;
    [_containerView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.videoImage.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    _timeLab = [[UILabel alloc]init];
    _timeLab.font = [UIFont systemFontOfSize:12];
    _timeLab.textColor = [UIColor lightGrayColor];
    _timeLab.textAlignment = NSTextAlignmentRight;
    [_containerView addSubview:_timeLab];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.titleLab.mas_bottom);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;

    _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:wkWebConfig];
    [_containerView addSubview:_webView];
    _webView.userInteractionEnabled = NO;
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.timeLab.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.webView.mas_bottom);
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
        self.nzq_navgationBar.title = [self changeTitle:self.title];
    }
    
}



#pragma mark  - KVO回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object != _webView.scrollView) {
        return;
    }
    
    CGFloat newHeight = self.webView.scrollView.contentSize.height;
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
    
    @weakify(self);
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.webView.mas_bottom).offset(40);
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

- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar{
    
    [leftButton setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    leftButton.tintColor = [UIColor whiteColor];
    return [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end

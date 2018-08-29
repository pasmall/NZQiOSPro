//
//  NZQCustonBuildHomePage2.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/20.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQCustonBuildHomePage2.h"
#import "ZJScrollPageView.h"

//子控制器
#import "NZQCustonBuildListPage.h"
#import "NZQBimListPage.h"
#import "NZQRuralDreamListPage.h"


//static const CGFloat NZQSpacing = 15;

@interface NZQCustonBuildHomePage2 ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;

@end

@implementation NZQCustonBuildHomePage2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self childVcs];
    [self setUI];
}

- (void)setUI{
    
    //headerView
    UIImageView *headerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navBackImage"]];
    [self.view addSubview:headerView];
    headerView.frame = CGRectMake(0, self.nzq_navgationBar.bottom, self.view.width, 10);
    
    
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:whiteView];
    whiteView.frame = headerView.bounds;
    [whiteView addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight WithCornerRadii:CGSizeMake(10, 10)];
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, self.nzq_navgationBar.bottom + 10, self.view.bounds.size.width, self.view.bounds.size.height - self.nzq_navgationBar.bottom - 10) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    content.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.contentView];

}

#pragma mark - 标题栏相关
- (NSInteger)numberOfChildViewControllers {
    return self.childViewControllers.count;
}

- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
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
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    style.scrollTitle = NO;
    style.showLine = YES;
    style.scrollLineHeight = 4;
    style.scrollLineColor = [UIColor whiteColor];
    style.scrollContentView = YES;
    style.titleFont = [UIFont systemFontOfSize:15];
    style.coverBackgroundColor = [UIColor clearColor];
    style.normalTitleColor = [UIColor whiteColor];
    style.selectedTitleColor = [UIColor whiteColor];
    style.animatedContentViewWhenTitleClicked = YES;

    
    @weakify(self);
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, navigationBar.width - 44* 2, 34) segmentStyle:style delegate:self titles:@[@"建筑定制",@"田园梦想",@"BIM定制"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weak_self.contentView setContentOffSet:CGPointMake(weak_self.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    self.segmentView = segment;



    return segment;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载
- (NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *)childVcs{
    if (!_childVcs) {
        NZQCustonBuildListPage  *page1 = [[NZQCustonBuildListPage alloc]initWithTitle:@"建筑定制"];
        NZQRuralDreamListPage  *page2 = [[NZQRuralDreamListPage alloc]initWithTitle:@"田园梦想"];
        NZQBimListPage  *page3 = [[NZQBimListPage alloc]initWithTitle:@"BIM定制"];
        
        [self addChildViewController:page1];
        [self addChildViewController:page2];
        [self addChildViewController:page3];
        
        _childVcs = @[page1,page2,page3];
    }
    
    return _childVcs;
}


@end

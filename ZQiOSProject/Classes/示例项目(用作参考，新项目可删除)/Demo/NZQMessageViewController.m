//
//  NZQMessageViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/6.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMessageViewController.h"
#import "ZJScrollPageView.h"
#import "NZQSubMessageViewController.h"
#import "NZQFansViewController.h"

static const CGFloat NZQSpacing = 15;

@interface NZQMessageViewController ()<ZJScrollPageViewDelegate>

@end

@implementation NZQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)setUI{
    //title
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(NZQSpacing, self.nzq_navgationBar.height + NZQSpacing, self.view.width, 21)];
    titleLab.text = @"消息";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLab];
    
    //pageTitle
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.gradualChangeTitleColor = YES;
    style.showCover = YES;
    style.scrollTitle = YES;
    style.segmentHeight = 60;
    style.autoAdjustTitlesWidth = NO;
    style.adjustCoverOrLineWidth = NO;
    style.titleMargin = NZQSpacing * 3;
    style.titleFont = [UIFont systemFontOfSize:16];
    style.normalTitleColor = [UIColor zqGrayColor];
    style.selectedTitleColor = [UIColor zqWhiteColor];
    style.coverHeight = 34;
    style.coverCornerRadius = 17;
    
    NZQSubMessageViewController  *subMessagePage = [[NZQSubMessageViewController alloc]initWithTitle:@"评论"];
    NZQFansViewController *fansPage = [[NZQFansViewController alloc]initWithTitle:@"粉丝"];
    [self addChildViewController:subMessagePage];
    [self addChildViewController:fansPage];

    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, titleLab.bottom, self.view.bounds.size.width, self.view.bounds.size.height - titleLab.bottom) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self];
    scrollPageView.contentView.collectionView.scrollEnabled = NO;
    [self.view addSubview:scrollPageView];
    
    
    
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

- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
    return [[NSMutableAttributedString alloc]initWithString:@""];
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

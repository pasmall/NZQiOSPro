//
//  NZQNavUIBaseViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQNavUIBaseViewController.h"

@interface NZQNavUIBaseViewController ()

@end

@implementation NZQNavUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NZQWeak(self);
    [self.navigationItem addObserverBlockForKeyPath:NZQKeyPath(self.navigationItem,title) block:^(id  _Nonnull obj, id  _Nullable oldVal, NSString* _Nullable newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.nzq_navgationBar.width = self.view.width;
    [self.view bringSubviewToFront:self.nzq_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    [self.navigationItem removeObserverBlocksForKeyPath:NZQKeyPath(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(NZQNavUIBaseViewController *)navUIBaseViewController {
    return YES;
}

/**头部标题*/
- (NSMutableAttributedString*)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar {
    return [self changeTitle:self.title ?: self.navigationItem.title];
}

/** 背景色 */
- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar {
    return [UIColor whiteColor];
}

/** 导航条的高度 */
- (CGFloat)nzqNavigationHeight:(NZQNavigationBar *)navigationBar {
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}

/** 导航条的左边的 view */
/** 导航条右边的 view */
/** 导航条中间的 View */
/** 导航条左边的按钮 */
/** 导航条右边的按钮 */
/** 是否显示底部黑线 */
/** 背景图片 */


#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(NZQNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}


#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    
    return title;
}


- (NZQNavigationBar *)nzq_navgationBar {
    // 父类控制器必须是导航控制器
    if(!_nzq_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]])
    {
        NZQNavigationBar *navigationBar = [[NZQNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        _nzq_navgationBar = navigationBar;
        
        navigationBar.dataSource = self;
        navigationBar.nzqDelegate = self;
        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
    }
    return _nzq_navgationBar;
}



- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.nzq_navgationBar.title = [self changeTitle:title];
}

@end

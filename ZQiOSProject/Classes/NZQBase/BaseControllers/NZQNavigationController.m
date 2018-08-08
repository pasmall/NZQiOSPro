//
//  NZQNavigationController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQNavigationController.h"

@interface NZQNavigationController ()

@end

@implementation NZQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
   
    // 不让自控制器控制系统导航条
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
}

//#pragma mark - 全局侧滑代码:开始
//- (void)getSystemGestureOfBack{
//
//    // 记录系统的pop代理
//    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
//
//    [self.view addGestureRecognizer:panGes];
//
//    panGes.delegate = self;
//
//    // 禁止之前的手势
//    self.interactivePopGestureRecognizer.enabled = NO;
//
//}
//
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//
//    // 非根控制器才能触发
//    return self.childViewControllers.count > 1;
//}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end

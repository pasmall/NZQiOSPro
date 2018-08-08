//
//  NZQPersonalViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/6.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQPersonalViewController.h"

@interface NZQPersonalViewController ()

@end

@implementation NZQPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







#pragma mark - 导航栏样式定义
//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//    return UIStatusBarAnimationFade;
//}
//
//- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar{
//    return [UIColor clearColor];
//}
//
//- (BOOL)nzqNavigationIsHideBottomLine:(NZQNavigationBar *)navigationBar{
//    return YES;
//}
//
//- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar{
//
//    [leftButton setImage:[[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
//    leftButton.tintColor = [UIColor redColor];
//    return [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//}
//
//- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
//
//    return [[NSMutableAttributedString alloc]initWithString:@""];
//}
//
//- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

/**头部标题*/
//- (NSMutableAttributedString*)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
//{
//    return [self changeTitle:self.navigationItem.title ?: self.title color:[UIColor redColor]];
//}


/** 背景色 */
- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar
{
    return [UIColor clearColor];
}

///** 是否隐藏底部黑线 */
//- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
//{
//    return YES;
//}
//
//
///** 导航条左边的按钮 */
//- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
//{
//
//    [leftButton setImage:[UIImage imageNamed:@"tabBar_new_click_icon"] forState:UIControlStateSelected];
//
//    return [UIImage imageNamed:@"tabBar_new_icon"];
//}
///** 导航条右边的按钮 */
//- (UIImage *)lmjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(LMJNavigationBar *)navigationBar
//{
//    [rightButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateSelected];
//
//    return [UIImage imageNamed:@"mine-setting-icon-click"];
//}


@end

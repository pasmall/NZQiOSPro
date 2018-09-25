//
//  NZQWebViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/31.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQWebViewController.h"
#import <WebKit/WebKit.h>

@interface NZQWebViewController ()

@end

@implementation NZQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    WKWebView *web = [[WKWebView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:web];
    @weakify(self);
    [web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.nzq_navgationBar.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cninct.com/suitangbig/xieyi.html"]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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

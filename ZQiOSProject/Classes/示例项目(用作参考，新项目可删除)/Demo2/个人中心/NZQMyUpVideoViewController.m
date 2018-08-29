//
//  NZQMyUpVideoViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyUpVideoViewController.h"
#import "NZQUpVide0ViewController.h"
#import "NZQUpMyRuralVideoPage.h"

@interface NZQMyUpVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation NZQMyUpVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [_view1 addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NZQUpVide0ViewController *page = [[NZQUpVide0ViewController alloc]initWithTitle:@"上传建筑定制"];
        [weak_self.navigationController  pushViewController:page animated:YES];
    }];
    
    [_view2 addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NZQUpMyRuralVideoPage *page = [[NZQUpMyRuralVideoPage alloc]initWithTitle:@"上传田园梦响"];
        [weak_self.navigationController  pushViewController:page animated:YES];
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

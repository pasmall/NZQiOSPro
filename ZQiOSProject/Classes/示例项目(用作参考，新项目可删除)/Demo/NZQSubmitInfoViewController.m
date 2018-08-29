//
//  NZQSubmitInfoViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/16.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQSubmitInfoViewController.h"
#import "UITextView+Addtion.h"

@interface NZQSubmitInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *aggreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *protocoLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation NZQSubmitInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    
    [_nameLab addLineWithLinePlace:NZQLinePlaceDown];
    [_phoneLab addLineWithLinePlace:NZQLinePlaceDown];
    
    _contentTV.layer.borderWidth = 0.5;
    _contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _aggreeBtn.selected = YES;
    _protocoLab.userInteractionEnabled = YES;
    [_submitBtn addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(_submitBtn.height*0.5,_submitBtn.height*0.5)];
    
    //添加事件
    @weakify(self);
    [_aggreeBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        weak_self.aggreeBtn.selected = !weak_self.aggreeBtn.selected;
    }];
    
    [_protocoLab addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        //协议界面
        
    }];
    
    [_submitBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (!weak_self.aggreeBtn.selected) {
            //
            [MBProgressHUD showWarn:@"请先同意协议内容" ToView:weak_self.view];
            return;
        }
        
        
        
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

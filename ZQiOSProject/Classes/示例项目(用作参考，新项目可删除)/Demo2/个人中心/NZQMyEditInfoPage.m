//
//  NZQMyEditInfoPage.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyEditInfoPage.h"
#import "UITextView+Addtion.h"

@interface NZQMyEditInfoPage ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;

@end

@implementation NZQMyEditInfoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [UIColor zqLightGrayColor].CGColor;
    [_upBtn addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(_upBtn.height*0.5,_upBtn.height*0.5)];
    
    _textView.placeholder   = @"请输入...";
    
    if (!NZQStringIsEmpty(_oldInfo)) {
        _textView.text = _oldInfo;
    }
    
}

- (IBAction)tapUpBtn:(id)sender {
    
    
    
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

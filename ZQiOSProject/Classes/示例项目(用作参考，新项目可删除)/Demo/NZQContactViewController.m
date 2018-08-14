//
//  NZQContactViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/14.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQContactViewController.h"

@interface NZQContactViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UIButton *comtaBtn;

@end

@implementation NZQContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.title isEqualToString:@"建筑定制上传"]) {
        self.textLab.text = @"请您等待审核~";
    }else{
        self.textLab.text = @"稍后会有客服给您回电~";
    }

    [self.comtaBtn addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(_comtaBtn.height * 0.5, _comtaBtn.height * 0.5)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapContBtn:(id)sender {
    [UIAlertController mj_showAlertWithTitle:@"12345678" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.addActionDefaultTitle(@"取消").addActionCancelTitle(@"呼叫");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1) {
            
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

- (NSMutableAttributedString *)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar{
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.title];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    return title;
}

- (void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar{
    
    UIViewController *controller = self.navigationController.viewControllers[self.navigationController.viewControllers.count -3];
    [self.navigationController popToViewController:controller animated:YES];
}

@end

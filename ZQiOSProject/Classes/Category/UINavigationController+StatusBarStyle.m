//
//  UINavigationController+StatusBarStyle.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.visibleViewController;
}

-  (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return self.visibleViewController.preferredStatusBarUpdateAnimation;
}

@end

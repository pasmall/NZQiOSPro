//
//  NZQTabBarController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/3.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQTabBarController.h"
#import "MainViewController.h"
#import "BasicKnowViewController.h"
#import "DemoViewController.h"
#import "NZQNavigationController.h"


@interface NZQTabBarController ()<UITabBarControllerDelegate>

@end

@implementation NZQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    [self addTabarItems];
    self.delegate = self;
}

- (void)customIsInGod:(NSNotification *)noti {
    if (![noti.object boolValue]) {
        return;
    }
}


- (void)addChildViewControllers
{
    NZQNavigationController *main = [[NZQNavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    NZQNavigationController *base = [[NZQNavigationController alloc] initWithRootViewController:[[BasicKnowViewController alloc] init]];
    
    NZQNavigationController *demo = [[NZQNavigationController alloc] initWithRootViewController:[[DemoViewController alloc] init]];
    
     self.viewControllers = @[main, base, demo];
}

- (void)addTabarItems
{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"功能",
                                                 @"TabBarItemImage" : @"cinct_20",
                                                 @"TabBarItemSelectedImage" : @"cinct_19",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"基础",
                                                  @"TabBarItemImage" : @"cinct_22",
                                                  @"TabBarItemSelectedImage" : @"cinct_21",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"示例",
                                                 @"TabBarItemImage" : @"cinct_24",
                                                 @"TabBarItemSelectedImage" : @"cinct_23",
                                                 };
    NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                        firstTabBarItemsAttributes,
                                                        secondTabBarItemsAttributes,
                                                        thirdTabBarItemsAttributes
                                                        ];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    
    self.tabBar.tintColor = [UIColor blueColor];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}

@end

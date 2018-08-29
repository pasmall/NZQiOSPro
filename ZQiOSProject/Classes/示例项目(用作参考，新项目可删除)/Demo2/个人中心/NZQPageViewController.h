//
//  NZQPageViewController.h
//  NZQScrollPageView
//
//  Created by ZeroJ on 16/8/31.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZQBaseViewController.h"


@protocol NZQPageViewControllerDelegate <NSObject>

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView;

@end

@interface NZQPageViewController : NZQBaseViewController
// 代理
@property(weak, nonatomic)id<NZQPageViewControllerDelegate> delegate;

@property (strong, nonatomic) UIScrollView *scrollView;

@end

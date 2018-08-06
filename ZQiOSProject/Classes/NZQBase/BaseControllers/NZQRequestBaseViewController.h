//
//  NZQRequestBaseViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQTextViewControllerDelegate.h"
#import "AFNetworkReachabilityManager.h"

@class NZQRequestBaseViewController;
@protocol NZQRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(AFNetworkReachabilityStatus)networkStatus inViewController:(NZQRequestBaseViewController *)inViewController;

@end



@interface NZQRequestBaseViewController : NZQTextViewController<NZQRequestBaseViewControllerDelegate>
#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end

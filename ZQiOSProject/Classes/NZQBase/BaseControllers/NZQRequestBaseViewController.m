//
//  NZQRequestBaseViewController.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQRequestBaseViewController.h"
#import "MBProgressHUD+NZQ.h"

@interface NZQRequestBaseViewController ()


@end

@implementation NZQRequestBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NZQWeak(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself networkStatus:status inViewController:weakself];
        });
    }];
}

#pragma mark - 加载框
- (void)showLoading
{
    [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading
{
    [MBProgressHUD hideHUDForView:self.view];
}

#pragma mark - NZQRequestBaseViewControllerDelegate                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
- (void)networkStatus:(AFNetworkReachabilityStatus)networkStatus inViewController:(NZQRequestBaseViewController *)inViewController{
    
    //判断网络状态
    switch (networkStatus) {
        case AFNetworkReachabilityStatusNotReachable:{
            [MBProgressHUD showError:@"当前网络连接失败，请查看设置" ToView:self.view];
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWiFi:{
            NSLog(@"WiFi网络");
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN:{
            NSLog(@"无线网络");
            break;
        }
        default:
            break;
    }
}


- (void)dealloc{
    if ([self isViewLoaded]) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }
}

@end


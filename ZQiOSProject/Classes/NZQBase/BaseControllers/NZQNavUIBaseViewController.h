//
//  NZQNavUIBaseViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZQNavigationBar.h"
#import "NZQNavigationController.h"

@class NZQNavUIBaseViewController;
@protocol NZQNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(NZQNavUIBaseViewController *)navUIBaseViewController;
@end

@interface NZQNavUIBaseViewController : UIViewController <NZQNavigationBarDelegate, NZQNavigationBarDataSource, NZQNavUIBaseViewControllerDataSource>
/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;

@property (weak, nonatomic) NZQNavigationBar *nzq_navgationBar;
@end

//
//  NZQEasyBlankPageView.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NZQEasyBlankPageViewTypeNoData,
    NZQEasyBlankPageViewTypeService
} NZQEasyBlankPageViewType;

@interface NZQEasyBlankPageView : UIView
- (void)configWithType:(NZQEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block;
@end


@interface UIView (NZQConfigBlank)
- (void)configBlankPage:(NZQEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

//
//  NZQExpandHeader.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZQExpandImageView.h"

@interface NZQExpandHeader : NSObject

#pragma mark - 类方法
+ (instancetype)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


#pragma mark - 成员方法
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


@property (weak, nonatomic, readonly) UIView *headerView;

@end

//
//  UIView+NZQ.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NZQ)

- (void)addShadowWithColor:(UIColor*)color;

- (void)addRoundedCorners:(UIRectCorner)corners;
- (void)addRoundedCorners:(UIRectCorner)corners WithCornerRadii:(CGSize)radii;

@end

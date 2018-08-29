//
//  UIView+NZQ.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NZQLinePlaceDown
} NZQLinePlace;

@interface UIView (NZQ)

- (void)addShadowWithColor:(UIColor*)color;

- (void)addRoundedCorners:(UIRectCorner)corners;
- (void)addRoundedCorners:(UIRectCorner)corners WithCornerRadii:(CGSize)radii;
- (void)addRoundedCorners:(UIRectCorner)corners WithRect:(CGRect)rect WithCornerRadii:(CGSize)radii;

- (void)addLineWithLinePlace:(NZQLinePlace)place;


@end

//
//  UIColor+NZQ.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR(_r,_g,_b) [UIColor colorWithRed:_r / 255.0f green:_g / 255.0f blue:_b / 255.0f alpha:1]
#define COLORA(_r,_g,_b,_a) [UIColor colorWithRed:_r / 255.0f green:_g / 255.0f blue:_b / 255.0f alpha:_a]

@interface UIColor (NZQ)

//从十六进制字符串获取颜色
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

#pragma mark 自定义颜色
+ (UIColor *)bgViewColor;
+ (UIColor *)zqWhiteColor;
+ (UIColor *)zqGrayColor;
+ (UIColor *)zqLightGrayColor;
+ (UIColor *)zqBlueColor;
+ (UIColor *)zqShadowColor;
+ (UIColor *)zqGrayShadowColor;

@end

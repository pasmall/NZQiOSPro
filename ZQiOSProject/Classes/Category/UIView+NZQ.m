//
//  UIView+NZQ.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "UIView+NZQ.h"

@implementation UIView (NZQ)

- (void)addShadowWithColor:(UIColor *)color{
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 1;
}


- (void)addRoundedCorners:(UIRectCorner)corners{
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:self.size];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners WithCornerRadii:(CGSize)radii{
    
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners WithRect:(CGRect)rect WithCornerRadii:(CGSize)radii{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)addLineWithLinePlace:(NZQLinePlace)place{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    switch (place) {
        case NZQLinePlaceDown:{
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
                make.left.right.offset(0);
                make.bottom.offset(-0.5);
            }];
        }
            
            break;
            
        default:
            break;
    }
}

@end

//
//  NZQExpandImageView.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQExpandImageView.h"

@implementation NZQExpandImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupOnce];
    }
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupOnce];
}

- (void)setupOnce{
    //关键步骤 设置可变化背景view属性
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    self.userInteractionEnabled = YES;
}

@end

//
//  NZQProjectCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQProjectCell.h"

@implementation NZQProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_contentImg addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(8, 8)];
}

@end

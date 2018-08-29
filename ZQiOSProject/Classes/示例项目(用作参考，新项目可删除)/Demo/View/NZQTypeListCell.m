//
//  NZQTypeListCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQTypeListCell.h"

@implementation NZQTypeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _imgView.layer.cornerRadius = 10;
    _imgView.layer.masksToBounds = YES;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    _countLab.text = [NSString stringWithFormat:@"%@个视频",dataDic[@"art_count"]];
    _timeLab.text = [NSString stringWithFormat:@"%@  更新",dataDic[@"new_time"]];
    [_imgView setImageURL:[NSURL URLWithString:dataDic[@"spic"]]];
    _titleLab.text = dataDic[@"content"];
    
    
}

@end

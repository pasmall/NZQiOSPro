//
//  NZQMyFansCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyFansCell.h"

@implementation NZQMyFansCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgView.layer.cornerRadius = 8;
    [_bgView addShadowWithColor:[UIColor zqGrayShadowColor]];
    _imgBg.layer.cornerRadius = 32;
    [_imgBg addShadowWithColor:[UIColor zqGrayShadowColor]];
    [_icon addRoundedCorners:UIRectCornerAllCorners];

    
    _stateLab.layer.borderWidth = 1;
    _stateLab.layer.borderColor = [UIColor zqBlueColor].CGColor;
    _stateLab.layer.cornerRadius = _stateLab.height * 0.5;
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [_icon setImageURL:[NSURL URLWithString:dataDic[@"logourl"]]];
    _nameLab.text = dataDic[@"nickname"];
    _addressLab.text = [NSString stringWithFormat:@"%@ , %@",dataDic[@"provice"],dataDic[@"city"]];
    
    if ([dataDic[@"isFocus"] boolValue]) {
        _stateLab.text = @"已关注";
        _stateLab.textColor = [UIColor zqBlueColor];
        _stateLab.layer.borderColor = [UIColor zqBlueColor].CGColor;
    }else{
        _stateLab.text = @"关注";
        _stateLab.textColor = [UIColor grayColor];
        _stateLab.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
}

@end

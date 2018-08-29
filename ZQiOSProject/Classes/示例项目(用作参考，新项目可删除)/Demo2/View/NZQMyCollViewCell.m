//
//  NZQMyCollViewCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/23.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyCollViewCell.h"

@implementation NZQMyCollViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutSubviews];
    
    _bgView.layer.cornerRadius = 8;
    _bgView.backgroundColor = [UIColor whiteColor];
    [_bgView addShadowWithColor:[UIColor zqShadowColor]];
    [_icon addRoundedCorners:UIRectCornerAllCorners];
    
    UIImageView *playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
    playImg.contentMode = UIViewContentModeScaleAspectFill;
    [_imgView addSubview:playImg];
    
    @weakify(self);
    [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.imgView.mas_centerX);
        make.centerY.mas_equalTo(weak_self.imgView.mas_centerY);
        make.width.height.mas_equalTo(44);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_imgView addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight WithCornerRadii:CGSizeMake(8, 8)];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [_imgView setImageURL:[NSURL URLWithString:dataDic[@"logourl"]]];
    [_icon setImageURL:[NSURL URLWithString:dataDic[@"headLogourl"]]];
    _nameLab.text = dataDic[@"nickname"];
    [_colBtn setTitle:[NSString stringWithFormat:@" %@",dataDic[@"collectCount"]] forState:UIControlStateNormal];
    _titleLab.text = dataDic[@"title"];
}

@end

//
//  NZQMyUpVideoCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyUpVideoCell.h"

@implementation NZQMyUpVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutSubviews];
    
    _bgView.layer.cornerRadius = 8;
    _bgView.backgroundColor = [UIColor whiteColor];
    [_bgView addShadowWithColor:[UIColor zqShadowColor]];
    
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
    _titleLab.text = dataDic[@"title"];
    _seeCountLab.text = [NSString stringWithFormat:@"%ld",[dataDic[@"hits"] integerValue]] ;
    _likeCountLab.text = [NSString stringWithFormat:@"%ld",[dataDic[@"collectCount"] integerValue]];
    
    switch ([dataDic[@"type"] integerValue]) {
        case 1:{
            [_typeImg setImage:[UIImage imageNamed:@"cinct_160"]];
        }
            
            break;
        case 3:{
            [_typeImg setImage:[UIImage imageNamed:@"cinct_159"]];
        }
            
            break;
            
        default:
            break;
    }
    
    if (![dataDic[@"status"] integerValue]) {
        [_typeImg setImage:[UIImage imageNamed:@"cinct_161"]];
    }
    
}

@end

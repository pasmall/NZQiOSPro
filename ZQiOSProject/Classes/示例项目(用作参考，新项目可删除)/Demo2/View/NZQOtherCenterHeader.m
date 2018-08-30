//
//  NZQOtherCenterHeader.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/29.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQOtherCenterHeader.h"

@implementation NZQOtherCenterHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
        [_bgImgView setImage:[UIImage imageNamed:@"bg_author_top"]];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImgView];
        
        UIView *whiteBg = [[UIView alloc]initWithFrame:CGRectMake(25, self.height - 140 - 5, self.width - 50, 140)];
        whiteBg.backgroundColor = [UIColor whiteColor];
        whiteBg.layer.cornerRadius = 8;
        [whiteBg addShadowWithColor:[UIColor zqLightGrayColor]];
        [self addSubview:whiteBg];
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(35, -25, 70, 100)];
        [whiteBg addSubview:_icon];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+20, 20, self.width - _icon.right - 40, 21)];
        _nameLab.font = [UIFont systemFontOfSize:17 weight:1];
        [whiteBg addSubview:_nameLab];
        
        _locLab = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+20, _nameLab.bottom+10, self.width - _icon.right - 40, 21)];
        _locLab.font = [UIFont systemFontOfSize:15];
        _locLab.textColor = [UIColor lightGrayColor];
        [whiteBg addSubview:_locLab];
        
        _focusBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, whiteBg.height - 30 - 15, 84, 30)];
        [_focusBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateNormal];
        [_focusBtn setBackgroundImage:[UIImage imageNamed:@"cinct_113"] forState:UIControlStateSelected];
        [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
        
        _focusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _focusBtn.centerX = whiteBg.width * 0.5;
        [_focusBtn addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(20, 20)];
        [whiteBg addSubview:_focusBtn];
        
        @weakify(self);
        [_focusBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            if (weak_self.tapFouceBtn) {
                weak_self.tapFouceBtn(weak_self);
            }
        }];

    }
    return self;
}


- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [_icon setImageURL:[NSURL URLWithString:dataDic[@"logourl"]]];
    _nameLab.text = dataDic[@"nickname"];
    _locLab.text = [NSString stringWithFormat:@"%@ %@",dataDic[@"provice"],dataDic[@"city"]];
    _focusBtn.selected = [dataDic[@"isFocus"] boolValue];

    
}

@end

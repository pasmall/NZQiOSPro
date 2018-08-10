//
//  NZQSelectTypeCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/10.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQSelectTypeCell.h"

@implementation NZQSelectTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _ImgView.tintColor = [UIColor clearColor];
    _subImgView.userInteractionEnabled = NO;
    NZQWeak(self);
    [self.ImgView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        
        weakself.ImgView.selected = !weakself.ImgView.selected;
        weakself.subImgView.selected = weakself.ImgView.selected;

        if (weakself.tapSelectClick) {
            weakself.tapSelectClick(weakself);
        }
    }];
}


- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _titleLab.text = dataDic[@"content"];
    
    if ([dataDic[@"content"] isEqualToString:@"房建"]) {
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_fangjian_normal"] forState:UIControlStateNormal];
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_fangjian_selected"] forState:UIControlStateSelected];
    }else if ([dataDic[@"content"] isEqualToString:@"桥梁"]){
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_qiao_normal"] forState:UIControlStateNormal];
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_qiao_selected"] forState:UIControlStateSelected];
    }else if ([dataDic[@"content"] isEqualToString:@"隧道"]){
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_suidao_normal"] forState:UIControlStateNormal];
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_suidao_selected"] forState:UIControlStateSelected];
    }else if ([dataDic[@"content"] isEqualToString:@"铁路"]){
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_tielu_normal"] forState:UIControlStateNormal];
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_tielu_selected"] forState:UIControlStateSelected];
    }else if ([dataDic[@"content"] isEqualToString:@"市政建筑"]){
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_shizheng_normal"] forState:UIControlStateNormal];
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_shizheng_selected"] forState:UIControlStateSelected];
    }else if ([dataDic[@"content"] isEqualToString:@"公路"]){
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_road_normal"] forState:UIControlStateNormal];
        [_ImgView setBackgroundImage:[UIImage imageNamed:@"bg_filter_road_selected"] forState:UIControlStateSelected];
    }

        
    
}

@end

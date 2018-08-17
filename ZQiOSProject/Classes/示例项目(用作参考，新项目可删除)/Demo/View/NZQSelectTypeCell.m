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

- (void)cancelSelected{
    self.ImgView.selected = NO;
    self.subImgView.selected = self.ImgView.selected;
}


- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _titleLab.text = dataDic[@"content"];
    
    [_ImgView setBackgroundImageWithURL:[NSURL URLWithString:dataDic[@"spic"]] forState:UIControlStateNormal options:YYWebImageOptionUseNSURLCache];
    [_ImgView setBackgroundImageWithURL:[NSURL URLWithString:dataDic[@"spicq"]] forState:UIControlStateSelected options:YYWebImageOptionUseNSURLCache];
    
    
}

@end

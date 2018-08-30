//
//  NZQOtherCenterHeader.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/29.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQOtherCenterHeader : UIView

@property (nonatomic , strong)UIImageView *bgImgView;
@property (nonatomic , strong)UIImageView *icon;
@property (nonatomic , strong)UILabel *nameLab;
@property (nonatomic , strong)UILabel *locLab;
@property (nonatomic , strong)UIButton *focusBtn;
@property (nonatomic , strong)UILabel *bgView;

@property (nonatomic ,strong)NSDictionary *dataDic;

@property (nonatomic, copy) void(^tapFouceBtn)(NZQOtherCenterHeader *header);

@end

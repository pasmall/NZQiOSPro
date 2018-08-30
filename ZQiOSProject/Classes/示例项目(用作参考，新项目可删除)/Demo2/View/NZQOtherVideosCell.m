//
//  NZQOtherVideosCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/30.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQOtherVideosCell.h"

@implementation NZQOtherVideosCell

- (void)setupOtherVideoCellUIOnce{
    
    UIImageView *playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
    playImg.contentMode = UIViewContentModeScaleAspectFill;
    [_img addSubview:playImg];

    @weakify(self);
    [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.img.mas_centerX);
        make.centerY.mas_equalTo(weak_self.img.mas_centerY);
        make.width.height.mas_equalTo(44);
    }];

    _bgView.layer.cornerRadius = 8;
    [_bgView addShadowWithColor:[UIColor zqGrayShadowColor]];
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    _titleLab.text = dataDic[@"title"];
    [_img setImageURL:[NSURL URLWithString:dataDic[@"loglurl"]]];
    
    if ([dataDic[@"isCollect"] boolValue]) {
        [_colBtn setTitle:[NSString stringWithFormat:@" %ld",[dataDic[@"collectCount"] integerValue]] forState:UIControlStateSelected];
        _colBtn.selected = YES;
    }else{
        [_colBtn setTitle:[NSString stringWithFormat:@" %ld",[dataDic[@"collectCount"] integerValue]] forState:UIControlStateNormal];
        _colBtn.selected = NO;
    }
}



+ (instancetype)otherVideoCellWithTableView:(UITableView *)tableView{
    NZQOtherVideosCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupOtherVideoCellUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupOtherVideoCellUIOnce];
}

@end

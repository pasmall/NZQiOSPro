//
//  NZQMyOrderCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQMyOrderCell.h"

@implementation NZQMyOrderCell


- (void)setupOrderCellUIOnce{
    
    UIImageView *playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
    playImg.contentMode = UIViewContentModeScaleAspectFill;
    [_imgView addSubview:playImg];
    
    @weakify(self);
    [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.imgView.mas_centerX);
        make.centerY.mas_equalTo(weak_self.imgView.mas_centerY);
        make.width.height.mas_equalTo(24);
    }];
    [_imgView addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(5, 5)];
    
    _bgView.layer.cornerRadius = 8;
    [_bgView addShadowWithColor:[UIColor zqShadowColor]];
    
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    
    
}



+ (instancetype)orderCellWithTableView:(UITableView *)tableView{
    NZQMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupOrderCellUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupOrderCellUIOnce];
}

@end

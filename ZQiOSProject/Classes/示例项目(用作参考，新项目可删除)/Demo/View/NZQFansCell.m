//
//  NZQFansCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQFansCell.h"

@implementation NZQFansCell

- (void)setupFansCellUIOnce{
    [_icon addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(5, 5)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius =10;
    [_bgView addShadowWithColor:[UIColor zqGrayShadowColor]];
    
    @weakify(self);
    [_operBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (weak_self.tapfouceBtn) {
            weak_self.tapfouceBtn(weak_self);
        }
    }];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [_icon setImageURL:[NSURL URLWithString:dataDic[@"headLogourl"]]];
    _operBtn.selected = [dataDic[@"isFocus"] boolValue];
    _nameLab.text = dataDic[@"nickname"];
    
}

+ (instancetype)fansCellWithTableView:(UITableView *)tableView{
    NZQFansCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupFansCellUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupFansCellUIOnce];
}

@end

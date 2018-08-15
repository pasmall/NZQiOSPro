//
//  NZQProjectCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQProjectCell.h"
#import "NZQWorkModel.h"

@implementation NZQProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _timeLab.backgroundColor =COLORA(0, 0, 0, 0.5);
    _timeLab2.backgroundColor =COLORA(0, 0, 0, 0.5);
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_contentImg addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(8, 8)];
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [_contentImg setImageURL:[NSURL URLWithString:dataDic[@"thumbnail"]]];
    _titleLab.text = dataDic[@"title"];
    _timeLab.text = [self returnTimeStrWithSeconds:dataDic[@"long_time"]];
    
    _timeLab2.hidden = YES;
    _playImg.hidden = YES;
    
}

- (void)setDataModel:(NZQWorkModel *)dataModel{
    _dataModel = dataModel;
    _titleLab.hidden = YES;
    _timeLab.hidden = YES;
    
    [_contentImg setImageURL:[NSURL URLWithString:dataModel.logourl]];
    _timeLab2.text = [self returnTimeStrWithSeconds:dataModel.long_time];
}


- (NSString *)returnTimeStrWithSeconds:(NSString *)seconds{
    NSInteger sec = [seconds integerValue];
    NSMutableString *str = [NSMutableString string];
    if (sec < 60) {
        [str appendString:seconds];
        [str appendString:@"″"];
    }else{

        [str appendString:[NSString stringWithFormat:@"%ld",sec/60]];
        [str appendString:@"′"];
        
        [str appendString:[NSString stringWithFormat:@"%ld",sec%60]];
        [str appendString:@"″"];
    }
    

    _timeLabWidth.constant = [str widthForFont:self.timeLab.font] + 10;
    _timeLab2Width.constant = [str widthForFont:self.timeLab.font] + 10;
    
    [_timeLab2 addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(3, 3)];
    [_timeLab addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(3, 3)];
    
    return str;
}

@end

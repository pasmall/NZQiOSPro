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
    
    _contentImg.layer.cornerRadius = 8;
    _contentImg.layer.masksToBounds = YES;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [_contentImg setImageURL:[NSURL URLWithString:dataDic[@"thumbnail"]]];
    _titleLab.text = dataDic[@"title"];
    _timeLab.text = [self returnTimeStrWithSeconds:dataDic[@"long_time"]];
    
    _timeLab2.hidden = YES;
    _playImg.hidden = YES;
    
}

- (void)setDataDic2:(NSDictionary *)dataDic2{
    _dataDic2 = dataDic2;
    _titleLab.hidden = YES;
    _timeLab.hidden = YES;
    
    [_contentImg setImageURL:[NSURL URLWithString:dataDic2[@"thumbnail"]]];
    _timeLab2.text = dataDic2[@"long_time"];

}

- (void)setDataModel:(NZQWorkModel *)dataModel{
    _dataModel = dataModel;
    _titleLab.hidden = YES;
    _timeLab.hidden = YES;
    
    [_contentImg setImageURL:[NSURL URLWithString:dataModel.logourl]];
//    _timeLab2.text = [self returnTimeStrWithSeconds:dataModel.long_time];
    _timeLab2.text  = dataModel.long_time;
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

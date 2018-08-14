//
//  NZQProjectCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQProjectCell.h"

@implementation NZQProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_contentImg addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(8, 8)];
    _timeLab.backgroundColor =COLORA(0, 0, 0, 0.5);
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [_contentImg setImageURL:[NSURL URLWithString:dataDic[@"thumbnail"]]];
    _titleLab.text = dataDic[@"title"];
    _timeLab.text = [self returnTimeStrWithSeconds:dataDic[@"long_time"]];
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
    
    [_timeLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([str widthForFont:self.timeLab.font] + 10);
    }];
    
    [_timeLab addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(3, 3)];
    return str;
}

@end

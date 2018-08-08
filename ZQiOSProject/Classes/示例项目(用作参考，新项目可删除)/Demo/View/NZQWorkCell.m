//
//  NZQWorkCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQWorkCell.h"
#import "NZQWorkModel.h"

const CGFloat NZQSpace = 15;
const CGFloat NZQImageSpace = 6;
const CGFloat NZQImageWidth = 250;

@interface NZQWorkCell()

@property(nonatomic , strong)UIImageView *image1;
@property(nonatomic , strong)UIImageView *image2;
@property(nonatomic , strong)UIImageView *image3;
@property(nonatomic , strong)UILabel *imageCountLab;
@property(nonatomic , strong)UIImageView *playImage;



@end

@implementation NZQWorkCell


- (void)setupWorkCellUIOnce{
    
    
    if (_imageBgView != nil) {
        _image1 = [[UIImageView alloc]init];
        _image2 = [[UIImageView alloc]init];
        _image3 = [[UIImageView alloc]init];
        _imageCountLab = [[UILabel alloc]init];
        _imageCountLab.backgroundColor = COLORA(0, 0, 0, 0.5);
        _imageCountLab.font = [UIFont systemFontOfSize:12];
        _imageCountLab.textColor = [UIColor whiteColor];
        _imageCountLab.textAlignment = NSTextAlignmentCenter;
        
        
        [_imageBgView addSubview:_image1];
        [_imageBgView addSubview:_image2];
        [_imageBgView addSubview:_image3];
        [_imageBgView addSubview:_imageCountLab];
    }
    
    if (_bgImageView) {
        _playImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
        _playImage.contentMode = UIViewContentModeScaleAspectFill;
        [_bgImageView addSubview:_playImage];

        NZQWeak(self);
        [_playImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(48, 48));
            make.center.mas_equalTo(weakself.bgImageView);
        }];
        
        
        _bgImageView.userInteractionEnabled = YES;

        [_bgImageView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            if (weakself.PlayBlock) {
                weakself.PlayBlock(weakself);
            }
        }];
    }
    
    if (_bgView) {
        
        [_bgView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
//            if (weakself.) {
//                <#statements#>
//            }
        }];
    }
    
    
    
}

- (void)setDataModel:(NZQWorkModel *)dataModel{
    _dataModel = dataModel;
    
    [_icon addRoundedCorners:UIRectCornerAllCorners];
    [_icon2 addRoundedCorners:UIRectCornerAllCorners];
    [_icon setImageWithURL:[NSURL URLWithString:dataModel.headlogourl] options:YYWebImageOptionUseNSURLCache];
    [_icon2 setImageWithURL:[NSURL URLWithString:dataModel.headlogourl] options:YYWebImageOptionUseNSURLCache];
    
    _timeLab.text = dataModel.add_Time;
    _timeLab2.text = dataModel.add_Time;
    
    _contentLab.text = dataModel.title;
    _contentLab2.text = dataModel.title;
    
    _nameLab.text = dataModel.nickname;
    _nameLab2.text = dataModel.nickname;
    
    if (NZQStringIsEmpty(dataModel.video)) {
        
        if (dataModel.pictures.count >= 3) {
            [_image1 setImageWithURL:[NSURL URLWithString:dataModel.pictures[0]] options:YYWebImageOptionUseNSURLCache];
            [_image2 setImageWithURL:[NSURL URLWithString:dataModel.pictures[1]] options:YYWebImageOptionUseNSURLCache];
            [_image3 setImageWithURL:[NSURL URLWithString:dataModel.pictures[2]] options:YYWebImageOptionUseNSURLCache];
            
            _image1.frame = CGRectMake(0, 0, NZQImageWidth, _imageBgView.height);
            _image2.frame = CGRectMake(_image1.right+ NZQImageSpace, 0, _imageBgView.width - _image1.right - NZQImageSpace, (_imageBgView.height - NZQImageSpace)*0.5);
            _image3.frame = CGRectMake(_image2.left, _image2.bottom+NZQImageSpace, _image2.width, _image2.height);

        }else{
            [_image1 setImageWithURL:[NSURL URLWithString:dataModel.pictures[0]] options:YYWebImageOptionUseNSURLCache];
            _image1.frame = _imageBgView.bounds;
        }
        
        _imageCountLab.text = [NSString stringWithFormat:@"共%ld张",dataModel.pictures.count];
        _imageCountLab.height = 21;
        _imageCountLab.top = _imageBgView.height - 21 - NZQSpace;
        _imageCountLab.width = [_imageCountLab.text widthForFont:_imageCountLab.font] + NZQSpace;
        _imageCountLab.right = _imageBgView.width - NZQSpace - _imageCountLab.width;
        [_imageCountLab addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(_imageCountLab.height/2, _imageCountLab.height/2)];
        
    }else{
        [_bgImageView setImageWithURL:[NSURL URLWithString:dataModel.logourl] options:YYWebImageOptionUseNSURLCache];
    }
    
}

#pragma mark Action

- (void)playVideo:(id)sender {
    if (self.PlayBlock) {
        self.PlayBlock(self);
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)workCellWithTableView:(UITableView *)tableView{
    NZQWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    }
    return cell;
}

+ (instancetype)workCell2WithTableView:(UITableView *)tableView{
    NZQWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NZQWorkCell2"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil][1];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupWorkCellUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupWorkCellUIOnce];
}


@end

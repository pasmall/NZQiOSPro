//
//  NZQBuildCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/20.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQBuildCell.h"

@interface NZQBuildCell()

@property (nonatomic,strong)UILabel *proLab;
@property (nonatomic,strong)UILabel *needTimeLab;

@end

@implementation NZQBuildCell


- (void)setupBuildCellUIOnce{
    @weakify(self);
    
    _videoImgView.width = kScreenWidth - 30;
    _videoImgView.height = 180;
    _videoImgView.tag = 111;
    _videoImgView.userInteractionEnabled = YES;
    
    _proLab = [[UILabel alloc]init];
    _proLab.font = [UIFont systemFontOfSize:17];
    _proLab.textColor = [UIColor whiteColor];
    [_videoImgView addSubview:_proLab];
    
    UIImageView *playImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_play"]];
    playImg.contentMode = UIViewContentModeScaleAspectFill;
    [_videoImgView addSubview:playImg];
    
    _needTimeLab = [[UILabel alloc]init];
    _needTimeLab.font = [UIFont systemFontOfSize:12];
    _needTimeLab.textColor = [UIColor whiteColor];
    _needTimeLab.backgroundColor = COLORA(0, 0, 0, 0.6);
    _needTimeLab.textAlignment = NSTextAlignmentCenter;
    [_videoImgView addSubview:_needTimeLab];
    
    [_icon addRoundedCorners:UIRectCornerAllCorners];
    
    
    //添加事件
    [_videoImgView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (weak_self.startPlayVideo) {
            weak_self.startPlayVideo(weak_self);
        }
    }];
    
    _icon.userInteractionEnabled = YES;
    [_icon addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (weak_self.gotoUserCenter) {
            weak_self.gotoUserCenter(weak_self);
        }
    }];
    
    _typeLab.userInteractionEnabled = YES;
    [_typeLab addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (weak_self.gotoTypePage) {
            weak_self.gotoTypePage(weak_self);
        }
    }];
    
    
    //C
    _titleLab3 = [[UILabel alloc]init];
    _titleLab3.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLab3];
    
    [_titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(weak_self.videoImgView.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth*0.5 - 15);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _priceLab3 = [[UILabel alloc]init];
    _priceLab3.font = [UIFont systemFontOfSize:13];
    _priceLab3.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLab3];
    
    [_priceLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(weak_self.videoImgView.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth*0.5 - 15);
        make.height.mas_equalTo(20);
    }];
    
    
    
    _contentlab3 = [[UILabel alloc]init];
    _contentlab3.font = [UIFont systemFontOfSize:13];
    _contentlab3.textColor = [UIColor lightGrayColor];
    [self addSubview:_contentlab3];
    
    [_contentlab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(weak_self.titleLab3.mas_bottom).offset(10);
    }];
    
    _videoHeight.constant = (kScreenWidth - 30) * 9 / 16;
    [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-25);
    }];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_videoImgView addRoundedCorners:UIRectCornerAllCorners WithRect:CGRectMake(0, 0, kScreenWidth - 30, _videoImgView.height) WithCornerRadii:CGSizeMake(10, 10)];
    
    [_colBtn addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (weak_self.tapColBtn) {
            weak_self.tapColBtn(weak_self);
        }
    }];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)buildCellWithTableView:(UITableView *)tableView{
    NZQBuildCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupBuildCellUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupBuildCellUIOnce];
}

#pragma mark - 设置数据
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    
}

//B       C:height
- (void)setDataDic:(NSDictionary *)dataDic WithType:(NZQHomeCellType)type{
    _dataDic = dataDic;
    
    switch (type) {
        case NZQHomeCellTypeC:{
            _icon.hidden = YES;
            _nameLab.hidden = YES;
            _timeLab.hidden = YES;
            _colBtn.hidden = YES;
            _titleLab.hidden = YES;
            _contentlab.hidden = YES;
            _rightImg.hidden = YES;
            _priceLab.hidden = YES;
            _typeLab.hidden = YES;
            _authImg.hidden = YES;
            
            [_videoImgView setImageURL:[NSURL URLWithString:dataDic[@"thumbnail"]]];
            _titleLab3.text = dataDic[@"title"];
            _priceLab3.text = [NSString stringWithFormat:@"指导价格：%@",dataDic[@"price"]];
            _contentlab3.text = dataDic[@"title2"];
            _contentlab3.numberOfLines = 3;
            
        }
            
            break;
        case NZQHomeCellTypeA:{
            
            _authImg.hidden = YES;
            [_icon setImageURL:[NSURL URLWithString:dataDic[@"headlogourl"]]];
            _nameLab.text = dataDic[@"nickname"];
            _timeLab.text = dataDic[@"add_Time"];
            _titleLab.text = dataDic[@"title"];
            [_videoImgView setImageURL:[NSURL URLWithString:dataDic[@"logourl"]]];
            _priceLab.text = [NSString stringWithFormat:@"指导价格：%@",dataDic[@"price"]];
            
            if ([dataDic[@"isPraise"] boolValue]) {
                [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dataDic[@"praiseCount"] integerValue]] forState:UIControlStateSelected];
                [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dataDic[@"praiseCount"] integerValue]-1] forState:UIControlStateNormal];
                _colBtn.selected = YES;
            }else{
                [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dataDic[@"praiseCount"] integerValue]] forState:UIControlStateNormal];
                [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dataDic[@"praiseCount"] integerValue]+1] forState:UIControlStateSelected];
                _colBtn.selected = NO;
            }
            
            _contentlab.text = dataDic[@"description"];
            _contentlab.numberOfLines = 3;
        }
            break;
        case NZQHomeCellTypeB:{
            _colBtn.hidden = YES;
            _rightImg.hidden = YES;
            _typeLab.hidden = YES;
            
            [_icon setImageURL:[NSURL URLWithString:dataDic[@"headlogourl"]]];
            _nameLab.text = dataDic[@"nickname"];
            _timeLab.text = dataDic[@"add_time"];
            _titleLab.text = dataDic[@"title"];
            [_videoImgView setImageURL:[NSURL URLWithString:dataDic[@"thumbnail"]]];
            
            _priceLab.text = [NSString stringWithFormat:@"租赁价格：%@",dataDic[@"price"]];
            _contentlab.text = dataDic[@"info"];
            _contentlab.numberOfLines = 3;
            
            switch ([dataDic[@"status"] integerValue]) {
                case 1:{
                    [_authImg setImage:[UIImage imageNamed:@"cinct_157"]];
                    _authImg.hidden = NO;
                }
                    break;
                case 2:{
                    _authImg.hidden = YES;
                }
                    break;
                case 3:{
                    [_authImg setImage:[UIImage imageNamed:@"cinct_158"]];
                    _authImg.hidden = NO;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case NZQHomeCellTypeD:{
            
            _authImg.hidden = YES;
            _typeLab.hidden = YES;
            _rightImg.hidden = YES;
            
            [_icon setImageURL:[NSURL URLWithString:dataDic[@"headlogourl"]]];
            _nameLab.text = dataDic[@"nickname"];
            _timeLab.text = dataDic[@"add_Time"];
            _titleLab.text = dataDic[@"title"];
            [_videoImgView setImageURL:[NSURL URLWithString:dataDic[@"logourl"]]];
            _priceLab.text = [NSString stringWithFormat:@"指导价格：%@",dataDic[@"price"]];
            
            if ([dataDic[@"isCollect"] boolValue]) {
                [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dataDic[@"collectCount"] integerValue]] forState:UIControlStateSelected];
                _colBtn.selected = YES;
            }else{
                [_colBtn setTitle:[NSString stringWithFormat:@"% ld",[dataDic[@"collectCount"] integerValue]] forState:UIControlStateNormal];
                _colBtn.selected = NO;
            }
            
            _contentlab.text = dataDic[@"description"];
            _contentlab.numberOfLines = 3;
        }
            break;
        default:
            break;
    }
    
    NSString *proStr = @"基建通";
    //竖排的字
    CGFloat width = [@"基" widthForFont:_proLab.font];
    CGFloat oneHeight = [@"基" heightForFont:_proLab.font width:width];
    CGFloat height = oneHeight * proStr.length;
    _proLab.frame = CGRectMake(15, 15, width, height);
    _proLab.text = proStr;
    _proLab.numberOfLines = 0;
    _proLab.alpha = 0.8;
    
    
    //视频时间
    _needTimeLab.text =dataDic[@"long_time"];
    CGFloat timeW = [dataDic[@"long_time"] widthForFont:_needTimeLab.font] + 18;
    CGFloat timeH = 22;
    _needTimeLab.frame = CGRectMake(_videoImgView.width - timeW - 15, _videoImgView.height - timeH - 15, timeW, timeH);
    [_needTimeLab addRoundedCorners:UIRectCornerAllCorners WithCornerRadii:CGSizeMake(4, 4)];
}

@end

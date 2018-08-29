//
//  NZQUserHeaderView.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/23.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQUserHeaderView.h"

@interface NZQUserHeaderView()

@property (nonatomic,strong)UIImageView *inputImg;

@end


@implementation NZQUserHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 125)];
        [_bgImgView setImage:[UIImage imageNamed:@"bg_jzdzpersonal_top"]];
        _bgImgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgImgView];
        self.clipsToBounds = YES;
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 21)];
        titleLab.text = @"我的";
        [self addSubview:titleLab];
        
        UIView *iconBg = [[UIView alloc]initWithFrame:CGRectMake(titleLab.left, titleLab.bottom + 10, 88, 88)];
        iconBg.backgroundColor = [UIColor whiteColor];
        iconBg.layer.cornerRadius = 44;
        [iconBg addShadowWithColor:[UIColor zqBlueColor]];
        [self addSubview:iconBg];
        
        _icon = [[UIImageView alloc]initWithFrame:iconBg.bounds];
        [_icon addRoundedCorners:UIRectCornerAllCorners];
        [iconBg addSubview:_icon];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(iconBg.right+20, iconBg.top, self.width - iconBg.right - 40, 21)];
        _nameLab.font = [UIFont systemFontOfSize:17];
        [self addSubview:_nameLab];
        
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = [UIFont systemFontOfSize:13];
        _infoLab.textColor = [UIColor lightGrayColor];
        _infoLab.numberOfLines = 2;
        [self addSubview:_infoLab];
        @weakify(self);
        [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-50);
            make.left.mas_equalTo(iconBg.right+20);
            make.top.mas_equalTo(weak_self.nameLab.bottom + 5);
        }];

        _fansLab = [[UILabel alloc]init];
        _fansLab.font = [UIFont systemFontOfSize:14];
        _fansLab.textColor = [UIColor grayColor];
        [self addSubview:_fansLab];
        [_fansLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconBg.right+20);
            make.bottom.mas_equalTo(weak_self.icon.mas_bottom).offset(10);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(90);
        }];
        
        _seeLab = [[UILabel alloc]init];
        _seeLab.font = [UIFont systemFontOfSize:14];
        _seeLab.textColor = [UIColor grayColor];
        [self addSubview:_seeLab];
        [_seeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weak_self.fansLab.mas_right).offset(10);
            make.bottom.mas_equalTo(weak_self.fansLab.mas_bottom);
            make.height.mas_equalTo(21);
            make.right.mas_equalTo(-20);
        }];
        
        _inputImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_personal_edit"]];
        _inputImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_inputImg];
        
        [_inputImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weak_self.infoLab.mas_right);
            make.width.height.mas_equalTo(14);
            make.centerY.mas_equalTo(weak_self.infoLab.mas_centerY);
        }];
        
        //添加事件
        _infoLab.userInteractionEnabled = YES;
        [_infoLab addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            if (weak_self.gotoEditInfo) {
                weak_self.gotoEditInfo(weak_self);
            }
            
        }];
        
        _inputImg.userInteractionEnabled = YES;
        [_inputImg addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            if (weak_self.gotoEditInfo) {
                weak_self.gotoEditInfo(weak_self);
            }
        }];
        
        _fansLab.userInteractionEnabled = YES;
        _seeLab.userInteractionEnabled  = YES;
        
        [_fansLab addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            if (weak_self.gotoFansPage) {
                weak_self.gotoFansPage(weak_self);
            }
            
        }];
        
        [_seeLab addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
            if (weak_self.gotoSeePage) {
                weak_self.gotoSeePage(weak_self);
            }
            
        }];
        
        
        
    }
    return self;
}


- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [_icon setImageURL:[NSURL URLWithString:dataDic[@"logourl"]]];
    _nameLab.text = dataDic[@"nickname"];
    _infoLab.text = NZQIsEmpty(dataDic[@"information"]) ? @"请输入个人简介,让别人更了解您...":dataDic[@"information"];
    _fansLab.text = [NSString stringWithFormat:@"%@ 粉丝",dataDic[@"countFocus"]];
    _seeLab.text = [NSString stringWithFormat:@"%@ 关注",dataDic[@"focusCount"]];


}

@end

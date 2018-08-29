//
//  NZQUserHeaderView.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/23.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQUserHeaderView : UIView

@property (nonatomic , strong)UIImageView *bgImgView;
@property (nonatomic , strong)UIImageView *icon;
@property (nonatomic , strong)UILabel *nameLab;
@property (nonatomic , strong)UILabel *infoLab;
@property (nonatomic , strong)UILabel *fansLab;
@property (nonatomic , strong)UILabel *seeLab;

@property (nonatomic ,strong)NSDictionary *dataDic;

@property (nonatomic, copy) void(^gotoEditInfo)(NZQUserHeaderView *cell);
@property (nonatomic, copy) void(^gotoFansPage)(NZQUserHeaderView *cell);
@property (nonatomic, copy) void(^gotoSeePage)(NZQUserHeaderView *cell);

@end

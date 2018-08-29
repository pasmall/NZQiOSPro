//
//  NZQBuildCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/20.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    NZQHomeCellTypeA,
    NZQHomeCellTypeB,
    NZQHomeCellTypeC,
    NZQHomeCellTypeD,
} NZQHomeCellType;

@interface NZQBuildCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (weak, nonatomic) IBOutlet UILabel *contentlab;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *colBtn;
@property (weak, nonatomic) IBOutlet UIImageView *authImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoHeight;


//C
@property (nonatomic , strong)UILabel *titleLab3;
@property (nonatomic , strong)UILabel *priceLab3;
@property (nonatomic , strong)UILabel *contentlab3;




@property (nonatomic,strong)NSDictionary *dataDic;

- (void)setDataDic:(NSDictionary *)dataDic WithType:(NZQHomeCellType)type;
+ (instancetype)buildCellWithTableView:(UITableView *)tableView;

//回调
@property (nonatomic, copy) void(^startPlayVideo)(NZQBuildCell *cell);
@property (nonatomic, copy) void(^gotoUserCenter)(NZQBuildCell *cell);
@property (nonatomic, copy) void(^gotoTypePage)(NZQBuildCell *cell);


@end

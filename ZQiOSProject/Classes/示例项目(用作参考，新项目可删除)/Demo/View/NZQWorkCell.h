//
//  NZQWorkCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQWorkModel;
@class NZQWorkCell;

typedef void (^tapPlayBtnBlock) (NZQWorkCell *cell);
typedef void (^tapHeaderBtnBlock) (NZQWorkCell *cell);

@interface NZQWorkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;


//imageCell
@property (weak, nonatomic) IBOutlet UIView *imageBgView;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UILabel *timeLab2;
@property (weak, nonatomic) IBOutlet UILabel *contentLab2;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;

@property (nonatomic , strong) NZQWorkModel *dataModel;

@property(nonatomic, copy) tapPlayBtnBlock PlayBlock;
@property(nonatomic, copy) tapHeaderBtnBlock HeaderBlock;

+ (instancetype)workCellWithTableView:(UITableView *)tableView;
+ (instancetype)workCell2WithTableView:(UITableView *)tableView;

@end

//
//  NZQOtherVideosCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/30.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQOtherVideosCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *colBtn;
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;

@property (nonatomic,strong)NSDictionary *dataDic;

+ (instancetype)otherVideoCellWithTableView:(UITableView *)tableView;

@end

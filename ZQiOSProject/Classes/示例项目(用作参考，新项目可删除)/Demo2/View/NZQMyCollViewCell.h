//
//  NZQMyCollViewCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/23.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQMyCollViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *colBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,strong)NSDictionary *dataDic;


@end

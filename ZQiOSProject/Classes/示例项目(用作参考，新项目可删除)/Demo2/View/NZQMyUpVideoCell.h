//
//  NZQMyUpVideoCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/24.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQMyUpVideoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *seeCountLab;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

@property (nonatomic,strong)NSDictionary  *dataDic;

@end

//
//  NZQProjectCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQWorkModel;

@interface NZQProjectCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contentImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab2;
@property (weak, nonatomic) IBOutlet UIImageView *playImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLab2Width;

@property (nonatomic,strong)NSDictionary *dataDic;
@property (nonatomic , strong)NZQWorkModel *dataModel;

//田园梦响 
@property (nonatomic ,strong)NSDictionary *dataDic2;

@end

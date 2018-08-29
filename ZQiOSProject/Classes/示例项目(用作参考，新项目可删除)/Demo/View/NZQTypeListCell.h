//
//  NZQTypeListCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQTypeListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (nonatomic ,strong)NSDictionary *dataDic;

@end

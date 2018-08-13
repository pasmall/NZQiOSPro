//
//  NZQSelectTypeCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/10.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQSelectTypeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *ImgView;
@property (weak, nonatomic) IBOutlet UIButton *subImgView;
@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic, copy) void(^tapSelectClick)(NZQSelectTypeCell *zqCell);

- (void)cancelSelected;

@end

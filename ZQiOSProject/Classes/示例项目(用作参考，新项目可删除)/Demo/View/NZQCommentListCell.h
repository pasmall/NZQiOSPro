//
//  NZQCommentListCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQCommentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;
@property (weak, nonatomic) IBOutlet UIView *replyBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyHeight;

@property (nonatomic,strong)NSDictionary *dataDic;

+ (instancetype)commentCellWithTableView:(UITableView *)tableView;


@end

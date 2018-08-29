//
//  NZQCommentListCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/22.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQCommentListCell.h"

@implementation NZQCommentListCell

- (void)setupCommentCellUIOnce{
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [_icon setImageURL:[NSURL URLWithString:dataDic[@"headlogourl"]]];
    _nameLab.text = dataDic[@"nickname"];
    _contentLab.text = dataDic[@"content"];
    
    NSArray *replyArray = dataDic[@"commentReplyEntities"];
    NSMutableAttributedString *allStr = [[NSMutableAttributedString alloc]init];
    for (NSDictionary *subDic in replyArray) {
        
        NSString *nameStr = subDic[@"nickname"];
        NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@\n\n",nameStr,subDic[@"content"]]];
        [subStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, nameStr.length)];
        [subStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(nameStr.length, subStr.length - nameStr.length)];
        [allStr insertAttributedString:subStr atIndex:allStr.length];
    }
    [allStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, allStr.length)];
    _replyLab.attributedText = allStr;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect  replyBounds = [allStr boundingRectWithSize:CGSizeMake(kScreenWidth - 86, CGFLOAT_MAX) options:options context:nil];
    
    if (allStr.length > 0) {
        _replyHeight.constant = replyBounds.size.height + 20;
    }else{
        _replyHeight.constant = 0;
    }
    
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}


+ (instancetype)commentCellWithTableView:(UITableView *)tableView{
    NZQCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCommentCellUIOnce];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupCommentCellUIOnce];
}

@end

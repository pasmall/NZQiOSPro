//
//  NZQUpLoadImageCell.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQUpLoadImageCell.h"

@interface NZQUpLoadImageCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;



@end

@implementation NZQUpLoadImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)setupUIOnce{
    self.addBtn.hidden = self.imgView.hidden = self.delBtn.hidden = YES;
    self.addBtn.hidden = NO;
    self.addBtn.backgroundColor = [UIColor orangeColor];
}

- (void)setPhotoImage:(UIImage *)photoImage{
    _photoImage = photoImage;
    
    if (photoImage) {
        self.addBtn.hidden = self.imgView.hidden = self.delBtn.hidden = NO;
        self.addBtn.hidden = YES;
    }else {
        self.addBtn.hidden = self.imgView.hidden = self.delBtn.hidden = YES;
        self.addBtn.hidden = NO;
    }
    self.imgView.image = photoImage;
}

- (IBAction)tapAddBtn:(id)sender {
    NZQWeak(self);
    if (self.addPhotoClick) {
        self.addPhotoClick(weakself);
    }
}

- (IBAction)tapDelBtn:(id)sender {
    NZQWeak(self);
    if (self.deletePhotoClick) {
        self.deletePhotoClick(weakself.photoImage);
    }
}



@end

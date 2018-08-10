//
//  NZQUpLoadImageCell.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZQUpLoadImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *photoImage;

@property (nonatomic, copy) void(^deletePhotoClick)(UIImage *photoImage);
@property (nonatomic, copy) void(^addPhotoClick)(NZQUpLoadImageCell *uploadImageCell);


@end

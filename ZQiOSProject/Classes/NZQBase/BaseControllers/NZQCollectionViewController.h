//
//  NZQCollectionViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZQBaseViewController.h"
#import "NZQElementsFlowLayout.h"
#import "NZQVerticalFlowLayout.h"
#import "NZQHorizontalFlowLayout.h"


@class NZQCollectionViewController;
@protocol NZQCollectionViewControllerDataSource <NSObject>

@required
// 需要返回对应的布局
- (UICollectionViewLayout *)collectionViewController:(NZQCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;

@end

@interface NZQCollectionViewController : NZQBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, NZQCollectionViewControllerDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

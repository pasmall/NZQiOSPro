//
//  NZQVerticalFlowLayout.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQVerticalFlowLayout;


@protocol NZQVerticalFlowLayoutDelegate <NSObject>

@required
/**
 *  @return 需要代理高度对应的cell的高度
 */
- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
@optional

/**
 *  需要显示的列数, 默认3
 */
- (NSInteger)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView;
/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout columnsMarginInCollectionView:(UICollectionView *)collectionView;
/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(NZQVerticalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end


@interface NZQVerticalFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<NZQVerticalFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<NZQVerticalFlowLayoutDelegate>)delegate;

@end

//
//  NZQHorizontalFlowLayout.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQHorizontalFlowLayout;


@protocol NZQHorizontalFlowLayoutDelegate <NSObject>

@required
/**
 *  @return 需要代理高度对应的cell的宽度
 */
- (CGFloat)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight;
@optional

/**
 *  需要显示的行数, 默认3
 */
- (NSInteger)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView;

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout linesMarginInCollectionView:(UICollectionView *)collectionView;

/**
 *  距离collectionView四周的间距, 默认{10, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(NZQHorizontalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end

@interface NZQHorizontalFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<NZQHorizontalFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<NZQHorizontalFlowLayoutDelegate>)delegate;

@end

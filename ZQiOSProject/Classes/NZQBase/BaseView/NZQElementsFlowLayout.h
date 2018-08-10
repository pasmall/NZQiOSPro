//
//  NZQElementsFlowLayout.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQElementsFlowLayout;


@protocol NZQElementsFlowLayoutDelegate <NSObject>

@required
/**
 *  要求实现
 *
 *  @param waterflowLayout 哪个布局需要代理返回大小
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *
 *  @return 需要代理高度对应的cell的高度
 */
- (CGSize)waterflowLayout:(NZQElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(NZQElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(NZQElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(NZQElementsFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;

@end


@interface NZQElementsFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<NZQElementsFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<NZQElementsFlowLayoutDelegate>)delegate;


@end

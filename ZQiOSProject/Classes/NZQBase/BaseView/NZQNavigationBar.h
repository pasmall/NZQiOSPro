//
//  NZQNavigationBar.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NZQNavigationBar;
// 主要处理导航条
@protocol  NZQNavigationBarDataSource<NSObject>

@optional

/**头部标题*/
- (NSMutableAttributedString*)nzqNavigationBarTitle:(NZQNavigationBar *)navigationBar;

/** 背景图片 */
- (UIImage *)nzqNavigationBarBackgroundImage:(NZQNavigationBar *)navigationBar;
/** 背景色 */
- (UIColor *)nzqNavigationBackgroundColor:(NZQNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)nzqNavigationIsHideBottomLine:(NZQNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)nzqNavigationHeight:(NZQNavigationBar *)navigationBar;


/** 导航条的左边的 view */
- (UIView *)nzqNavigationBarLeftView:(NZQNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)nzqNavigationBarRightView:(NZQNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)nzqNavigationBarTitleView:(NZQNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)nzqNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NZQNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)nzqNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NZQNavigationBar *)navigationBar;
@end


@protocol NZQNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(NZQNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(NZQNavigationBar *)navigationBar;
@end


@interface NZQNavigationBar : UIView

@property (weak, nonatomic) UIView *bottomBlackLineView;
@property (weak, nonatomic) UIView *titleView;
@property (weak, nonatomic) UIView *leftView;
@property (weak, nonatomic) UIView *rightView;
@property (nonatomic, copy) NSMutableAttributedString *title;
@property (weak, nonatomic) id<NZQNavigationBarDataSource> dataSource;
@property (weak, nonatomic) id<NZQNavigationBarDelegate> nzqDelegate;
@property (weak, nonatomic) UIImage *backgroundImage;

@end

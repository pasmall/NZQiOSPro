//
//  NZQEasyBlankPageView.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/7.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQEasyBlankPageView.h"
#import <YYAnimatedImageView.h>

@interface NZQEasyBlankPageView()
/** 加载按钮 */
@property (weak, nonatomic) UIButton *reloadBtn;
/** 图片 */
@property (weak, nonatomic) YYAnimatedImageView *imageView;
/** 提示 label */
@property (weak, nonatomic) UILabel *tipLabel;
/** 按钮点击 */
@property (nonatomic, copy) void(^reloadBlock)(UIButton *sender);
@end

@implementation NZQEasyBlankPageView
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.backgroundColor = newSuperview.backgroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(frame.size.height * 0.3);
            make.centerX.offset(0);
        }];
        
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.left.right.equalTo(self.imageView);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
        }];
        
        [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
            //            make.width.mas_equalTo(@94);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

- (void)configWithType:(NZQEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block{
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.reloadBtn.hidden = YES;
    self.tipLabel.hidden = YES;
    self.imageView.hidden = YES;
    self.reloadBlock = block;
    
    if (hasError) {
        [self.imageView setImage:[UIImage imageNamed:@"common_noNetWork"]];
        self.tipLabel.text = @"貌似出了点差错";
        self.reloadBtn.hidden = NO;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
    } else {
        
        switch (blankPageType) {
            case NZQEasyBlankPageViewTypeNoData:{
                [self.imageView setImage:[UIImage imageNamed:@"bg_default_normaldata"]];
                self.tipLabel.text = @"暂无数据";
                self.reloadBtn.hidden = YES;
                self.tipLabel.hidden = NO;
                self.imageView.hidden = NO;
                
            }
                break;
            case NZQEasyBlankPageViewTypeService:{
                
            }
                break;
                
            default:
                break;
        }

    }
}

- (void)reloadClick:(UIButton *)btn
{
    !self.reloadBlock ?: self.reloadBlock(btn);
}

- (UIButton *)reloadBtn
{
    if(!_reloadBtn)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _reloadBtn = btn;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [btn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}

- (YYAnimatedImageView *)imageView{
    if(!_imageView)
    {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
        imageView.autoPlayAnimatedImage = YES;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)tipLabel{
    if(!_tipLabel)
    {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipLabel = label;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
    }
    return _tipLabel;
}

@end



static void *BlankPageViewKey = &BlankPageViewKey;

@implementation UIView (NZQConfigBlank)

- (void)setBlankPageView:(NZQEasyBlankPageView *)blankPageView{
    objc_setAssociatedObject(self, BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NZQEasyBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, BlankPageViewKey);
}

- (void)configBlankPage:(NZQEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[NZQEasyBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        }
        self.blankPageView.hidden = NO;
        [self addSubview:self.blankPageView];
        [self.blankPageView configWithType:blankPageType hasData:NO hasError:hasError reloadButtonBlock:block];
    }
}

@end

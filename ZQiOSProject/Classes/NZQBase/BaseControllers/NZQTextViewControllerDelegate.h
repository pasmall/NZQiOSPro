//
//  NZQTextViewControllerDelegate.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQNavUIBaseViewController.h"

@class NZQTextViewController;
@protocol NZQTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(NZQTextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(NZQTextViewController *)textViewController;

//控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(NZQTextViewController *)textViewController;

@end


@protocol NZQTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(NZQTextViewController *)textViewController inputViewDone:(id)inputView;
@end

@interface NZQTextViewController : NZQNavUIBaseViewController<NZQTextViewControllerDataSource, NZQTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;


@end




#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (NZQTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface NZQTextViewControllerTextField : UITextField

@end

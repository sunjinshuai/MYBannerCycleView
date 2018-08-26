//
//  UITextView+InputLengthCalculate.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//  用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题

#import <UIKit/UIKit.h>

@interface UITextView (InputLengthCalculate)

/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger textLength = [textView getInputLengthWithText:text];
    if (textLength > 20) {
        //超过20个字可以删除
        if ([text isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView getInputLengthWithText:nil] > 20) {
        textView.text = [textView.text substringToIndex:20];
    }
}
 
 */

/**
 *  用来捕获输入时的字符数的
 *
 *  @param text
 在-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text使用时需要传入replacementText用于计算长度，- (void)textViewDidChange:(UITextView *)textView中使用不需要传入
 *
 *  @return 字符长度
 */
- (NSInteger)getInputLengthWithText:(NSString *)text;

- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text
                settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end

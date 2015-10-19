//
//  TYShowAlertView.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/3/16.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYShowAlertView : UIView

@property (nonatomic, weak, readonly) UIView *tipView;
@property (nonatomic, weak) UIView *backgroundView;

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default YES
@property (nonatomic, assign) CGFloat alertViewOriginY;  // default center Y
@property (nonatomic, assign) CGFloat alertViewEdging;   // default 15


+(void)showAlertViewWithView:(UIView *)alertView;

+(void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY;

+(void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

+ (instancetype)alertViewWithView:(UIView *)alertView;

- (void)show;

- (void)hide;

@end

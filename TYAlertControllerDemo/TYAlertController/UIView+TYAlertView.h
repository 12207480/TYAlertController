//
//  UIView+TYAlertView.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYAlertController.h"
#import "TYShowAlertView.h"

@interface UIView (TYAlertView)

+ (instancetype)createViewFromNib;

+ (instancetype)createViewFromNibName:(NSString *)nibName;

- (UIViewController*)viewController;

#pragma mark - show in controller

- (void)showInController:(UIViewController *)viewController;

- (void)showInController:(UIViewController *)viewController preferredStyle:(TYAlertControllerStyle)preferredStyle;

- (void)showInController:(UIViewController *)viewController preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation;

- (void)hideInController;

#pragma mark - show in window

- (void)showInWindow;

- (void)showInWindowWithOriginY:(CGFloat)OriginY;

- (void)showInWindowWithOriginY:(CGFloat)OriginY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

- (void)hideInWindow;

@end
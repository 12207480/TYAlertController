//
//  UIView+TYAlertView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "UIView+TYAlertView.h"

@implementation UIView (TYAlertView)

+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - show in window

- (void)showInWindow
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [TYShowAlertView showAlertViewWithView:self];
}

- (void)showInWindowWithOriginY:(CGFloat)OriginY
{
    [self showInWindowWithOriginY:OriginY backgoundTapDismissEnable:YES];
}

- (void)showInWindowWithOriginY:(CGFloat)OriginY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [TYShowAlertView showAlertViewWithView:self originY:OriginY backgoundTapDismissEnable:backgoundTapDismissEnable];
}

- (void)hideInWindow
{
    if (self.superview && [self.superview isKindOfClass:[TYShowAlertView class]]) {
        [(TYShowAlertView *)self.superview hide];
    }else {
        NSLog(@"self.superview is nil, or isn't TYShowAlertView");
    }
}

#pragma mark - show in controller

- (void)showInController:(UIViewController *)viewController
{
    [self showInController:viewController preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationFade];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(TYAlertControllerStyle)preferredStyle
{
    [self showInController:viewController preferredStyle:preferredStyle transitionAnimation:TYAlertTransitionAnimationFade];
}

- (void)showInController:(UIViewController *)viewController preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:self preferredStyle:preferredStyle transitionAnimation:transitionAnimation];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)hideInController
{
    if (self.viewController && [self.viewController isKindOfClass:[TYAlertController class]]) {
        [(TYAlertController *)self.viewController dismissViewControllerAnimated:YES];
    }else {
        NSLog(@"self.viewController is nil, or isn't TYAlertController");
    }
}

@end

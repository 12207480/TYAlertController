//
//  TYAlertScaleFadeAnimation.m
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/2.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertScaleFadeAnimation.h"

@implementation TYAlertScaleFadeAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYAlertController *alertController = (TYAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case TYAlertControllerStyleAlert:
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            break;
        case TYAlertControllerStyleActionSheet:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = 1.0;
        switch (alertController.preferredStyle) {
            case TYAlertControllerStyleAlert:
                alertController.alertView.alpha = 1.0;
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            case TYAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformIdentity;
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYAlertController *alertController = (TYAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case TYAlertControllerStyleAlert:
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                break;
            case TYAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

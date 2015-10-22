//
//  TYAlertDefaultAnimation.m
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertFadeAnimation.h"

@implementation TYAlertFadeAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.45;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYAlertController *alertController = (TYAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case TYAlertControllerStyleAlert:
            alertController.alertView.alpha = 0.0;
            alertController.alertView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            break;
        case TYAlertControllerStyleActionSheet:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(alertController.alertView.frame));
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 1.0;
        switch (alertController.preferredStyle) {
            case TYAlertControllerStyleAlert:
                alertController.alertView.alpha = 1.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                break;
            case TYAlertControllerStyleActionSheet:
                alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -10.0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            alertController.alertView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
    
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYAlertController *alertController = (TYAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:0.25 animations:^{
        alertController.backgroundView.alpha = 0.0;
        switch (alertController.preferredStyle) {
            case TYAlertControllerStyleAlert:
                alertController.alertView.alpha = 0.0;
                alertController.alertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
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

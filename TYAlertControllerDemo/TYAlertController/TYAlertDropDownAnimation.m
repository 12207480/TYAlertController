//
//  TYAlertDropDownAnimation.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/10/27.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import "TYAlertDropDownAnimation.h"

@implementation TYAlertDropDownAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.5;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYAlertController *alertController = (TYAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    alertController.backgroundView.alpha = 0.0;
    
    switch (alertController.preferredStyle) {
        case TYAlertControllerStyleAlert:
            alertController.alertView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(alertController.alertView.frame));
            break;
        case TYAlertControllerStyleActionSheet:
            NSLog(@"don't support ActionSheet style!");
            break;
        default:
            break;
    }
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:alertController.view];

    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:0 animations:^{
        
        alertController.backgroundView.alpha = 1.0;
        alertController.alertView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
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
                NSLog(@"don't support ActionSheet style!");
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

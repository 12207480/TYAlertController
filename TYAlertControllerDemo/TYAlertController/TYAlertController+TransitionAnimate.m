//
//  TYAlertController+TransitionAnimate.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertController.h"
#import "TYAlertFadeAnimation.h"
#import "TYAlertScaleFadeAnimation.h"
#import "TYAlertDropDownAnimation.h"

@implementation TYAlertController (TransitionAnimate)

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    switch (self.transitionAnimation) {
        case TYAlertTransitionAnimationFade:
            return [TYAlertFadeAnimation alertAnimationIsPresenting:YES];
        case TYAlertTransitionAnimationScaleFade:
            return [TYAlertScaleFadeAnimation alertAnimationIsPresenting:YES];
        case TYAlertTransitionAnimationDropDown:
            return [TYAlertDropDownAnimation alertAnimationIsPresenting:YES];
        case TYAlertTransitionAnimationCustom:
            return [self.transitionAnimationClass alertAnimationIsPresenting:YES preferredStyle:self.preferredStyle];
        default:
            return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.transitionAnimation) {
        case TYAlertTransitionAnimationFade:
            return [TYAlertFadeAnimation alertAnimationIsPresenting:NO];
        case TYAlertTransitionAnimationScaleFade:
            return [TYAlertScaleFadeAnimation alertAnimationIsPresenting:NO];
        case TYAlertTransitionAnimationDropDown:
            return [TYAlertDropDownAnimation alertAnimationIsPresenting:NO];
        case TYAlertTransitionAnimationCustom:
            return [self.transitionAnimationClass alertAnimationIsPresenting:NO preferredStyle:self.preferredStyle];
        default:
            return nil;
    }
}

@end

//
//  TYAlertController+TransitionAnimate.m
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertController.h"
#import "TYAlertFadeAnimation.h"
#import "TYAlertScaleFadeAnimation.h"

@implementation TYAlertController (TransitionAnimate)

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [TYAlertScaleFadeAnimation alertAnimationIsPresenting:YES];
    //return [TYAlertFadeAnimation alertAnimationIsPresenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [TYAlertScaleFadeAnimation alertAnimationIsPresenting:NO];
    //return [TYAlertFadeAnimation alertAnimationIsPresenting:NO];
}

@end

//
//  TYAlertController.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYAlertView.h"

typedef NS_ENUM(NSInteger, TYAlertControllerStyle) {
    TYAlertControllerStyleAlert = 0,
    TYAlertControllerStyleActionSheet
};

typedef NS_ENUM(NSInteger, TYAlertTransitionAnimation) {
    TYAlertTransitionAnimationFade = 0,
    TYAlertTransitionAnimationScaleFade,
    TYAlertTransitionAnimationDropDown,
    TYAlertTransitionAnimationCustom
};


@interface TYAlertController : UIViewController

@property (nonatomic, strong, readonly) UIView *alertView;

@property (nonatomic, strong) UIColor *backgroundColor; // set backgroundColor
@property (nonatomic, strong) UIView *backgroundView; // you set coustom view to it

@property (nonatomic, assign, readonly) TYAlertControllerStyle preferredStyle;

@property (nonatomic, assign, readonly) TYAlertTransitionAnimation transitionAnimation;

@property (nonatomic, assign, readonly) Class transitionAnimationClass;

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO

@property (nonatomic, assign) CGFloat alertViewOriginY;  // default center Y

@property (nonatomic, assign) CGFloat alertStyleEdging; //  when width frame equal to 0,or no width constraint ,this proprty will use, default to 15 edge
@property (nonatomic, assign) CGFloat actionSheetStyleEdging; // default 0

// alertView lifecycle block
@property (copy, nonatomic) void (^viewWillShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewWillHideHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidHideHandler)(UIView *alertView);

// dismiss controller completed block
@property (nonatomic, copy) void (^dismissComplete)(void);

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView;

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle;

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation;

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimationClass:(Class)transitionAnimationClass;

- (void)dismissViewControllerAnimated: (BOOL)animated;

@end

// Transition Animate
@interface TYAlertController (TransitionAnimate)<UIViewControllerTransitioningDelegate>

@end

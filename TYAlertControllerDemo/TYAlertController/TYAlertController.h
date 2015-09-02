//
//  TYAlertController.h
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TYAlertControllerStyle) {
    TYAlertControllerStyleActionSheet = 0,
    TYAlertControllerStyleAlert
};

@interface TYAlertController : UIViewController

@property (nonatomic, strong, readonly) UIView *alertView;

@property (nonatomic, assign, readonly) TYAlertControllerStyle preferredStyle;

@property (nonatomic, assign) BOOL backgoundTapEnable;  // default YES

@property (nonatomic, assign) CGFloat alertViewTopY;  // default center Y

@property (nonatomic, copy) void (^dismissComplete)(void);

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle;

@end

// Transition Animate
@interface TYAlertController (TransitionAnimate)<UIViewControllerTransitioningDelegate>

@end

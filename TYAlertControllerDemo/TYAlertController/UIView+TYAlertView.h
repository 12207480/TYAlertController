//
//  UIView+TYAlertView.h
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TYAlertView)

+ (instancetype)createViewFromNib;

+ (instancetype)createViewFromNibName:(NSString *)nibName;

- (UIViewController*)viewController;


@end
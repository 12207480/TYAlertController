//
//  TYShowAlertView.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/3/16.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYShowAlertView : UIView

@property (nonatomic, weak, readonly) UIView *alertView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO

/** 2019-10-04 12:13:56
    取值优先级为 ( 数字越小, 优先级越高 )
    1. 主动赋值了alertViewWidth或alertViewHeight属性,则以_alertViewWidth为准
    2. alertView.size != {0 , 0} , 则以 alertView.size 为准
    3. superView.width - 2 * 15
 */
@property (nonatomic, assign) CGFloat alertViewWidth;

/** 2019-10-04 12:22:41
   取值优先级为 ( 数字越小, 优先级越高 )
   1. 主动赋值了alertViewWidth或alertViewHeight属性,则以_alertViewHeight为准
   2. alertView.size != {0 , 0} , 则以 alertView.size 为准
   3. 200
*/
@property (nonatomic, assign) CGFloat alertViewHeight;

/** 2019-10-04 12:24:03
    1. 主动赋值了alertViewCenter,则以_alertViewCenter为准
    2. alertView.size != {0 , 0}, 则视为想要使用frame进行约束,赋值CGPointMake(CGRectGetMidX(_alertView.frame), CGRectGetMidY(_alertView.frame))
    3.kCurrentWindow.center
 */
@property (nonatomic, assign) CGPoint alertViewCenter;

+(void)showAlertViewWithView:(UIView *)alertView;

+ (void)showAlertViewWithView:(UIView *)alertView backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

+(void)showAlertViewWithView:(UIView *)alertView center:(CGPoint)center;

+ (void)showAlertViewWithView:(UIView *)alertView center:(CGPoint)center backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

+ (instancetype)alertViewWithView:(UIView *)alertView;

- (void)show;

- (void)hide;

@end

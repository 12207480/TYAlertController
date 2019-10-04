//
//  TYShowAlertView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/3/16.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "TYShowAlertView.h"
#import "UIView+TYAutoLayout.h"

@interface TYShowAlertView ()
@property (nonatomic, weak) UIView *alertView;
@property (nonatomic, weak) UITapGestureRecognizer *singleTap;
@end

//current window
#define kCurrentWindow [UIApplication sharedApplication].keyWindow

@implementation TYShowAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgoundTapDismissEnable = NO;
        
        [self addBackgroundView];
        
        [self addSingleGesture];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)tipView
{
    if (self = [self initWithFrame:CGRectZero]) {
        
        [self addSubview:tipView];
        _alertView = tipView;
    }
    return self;
}

+ (instancetype)alertViewWithView:(UIView *)tipView
{
    return [[self alloc]initWithAlertView:tipView];
}

+ (void)showAlertViewWithView:(UIView *)alertView
{
    [self showAlertViewWithView:alertView backgoundTapDismissEnable:NO];
}

+ (void)showAlertViewWithView:(UIView *)alertView backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    TYShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.backgoundTapDismissEnable = backgoundTapDismissEnable;
    [showTipView show];
}

+ (void)showAlertViewWithView:(UIView *)alertView center:(CGPoint)center
{
    [self showAlertViewWithView:alertView
                       center:center backgoundTapDismissEnable:NO];
}

+ (void)showAlertViewWithView:(UIView *)alertView center:(CGPoint)center backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    TYShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.alertViewCenter = center;
    showTipView.backgoundTapDismissEnable = backgoundTapDismissEnable;
    [showTipView show];
}

- (void)addBackgroundView
{
    if (_backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _backgroundView = backgroundView;
    }
    [self insertSubview:_backgroundView atIndex:0];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintToView:_backgroundView edgeInset:UIEdgeInsetsZero];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self addBackgroundView];
        [self addSingleGesture];
    }
}
- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.superview addConstraintToView:self edgeInset:UIEdgeInsetsZero];
        [self layoutAlertView];
    }
}

- (void)layoutAlertView
{
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // width, height
    if (!CGSizeEqualToSize(_alertView.frame.size,CGSizeZero)) {
        /**2019-10-04 12:10:15 如果没有人为设置_alertViewCenter, 则取frame的对应的center*/
        if (CGPointEqualToPoint(_alertViewCenter, CGPointZero)) {
            _alertViewCenter = CGPointMake(CGRectGetMidX(_alertView.frame), CGRectGetMidY(_alertView.frame));
        }
        
        /**2019-10-04 12:10:15 如果没有人为设置_alertViewWidth或者_alertViewHeight, 则从frame中取*/
        if (!(_alertViewWidth || _alertViewHeight)) {
            _alertViewWidth = _alertView.frame.size.width;
            _alertViewHeight = _alertView.frame.size.height;
        }

        [_alertView addConstraintWidth:_alertViewWidth height:_alertViewHeight];
    }else {
        BOOL findAlertViewWidthConstraint = NO;
        BOOL findAlertViewHeightConstraint = NO;
        for (NSLayoutConstraint *constraint in _alertView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                findAlertViewWidthConstraint = YES;
            }else if (constraint.firstAttribute == NSLayoutAttributeHeight){
                findAlertViewHeightConstraint = YES;
            }
        }
        
        if (!findAlertViewWidthConstraint) {
            if (!(_alertViewWidth || _alertViewHeight)) {
                _alertViewWidth = CGRectGetWidth(self.superview.frame)-2*15;
            }
            [_alertView addConstraintWidth:_alertViewWidth height:0];
        }
        
        if (!findAlertViewHeightConstraint) {
            if (!(_alertViewWidth || _alertViewHeight)) {
                _alertViewHeight = 200;
            }
             [_alertView addConstraintWidth:0 height:_alertViewHeight];
         }
    }
    
    /**2019-10-04 12:11:52 center X & center Y*/
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_alertView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-_alertViewCenter.x]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                        toItem:_alertView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-_alertViewCenter.y]];
}

#pragma mark - add Gesture
- (void)addSingleGesture
{
    self.userInteractionEnabled = YES;
    //单指单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgoundTapDismissEnable;
    //增加事件者响应者，
    [_backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
}

#pragma mark 手指点击事件
- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}

- (void)show
{
    if (self.superview == nil) {
        [kCurrentWindow addSubview:self];
    }
    self.alpha = 0;
    _alertView.transform = CGAffineTransformScale(_alertView.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _alertView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
    
}

- (void)hide
{
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            _alertView.transform = CGAffineTransformScale(_alertView.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            _alertView.transform = CGAffineTransformIdentity;
            [self removeFromSuperview];
        }];
    }
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

@end

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
@property (nonatomic, weak) UIView *tipView;
@property (nonatomic, weak) UITapGestureRecognizer *singleTap;
@end

//current window
#define kCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation TYShowAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgoundTapDismissEnable = YES;
        _alertViewEdging = 15;
        
        [self addBackgroundView];
        
        [self addSingleGesture];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)tipView
{
    //[[UIScreen mainScreen] bounds]
    if (self = [self init]) {
        
        [self addSubview:tipView];
        _tipView = tipView;
    }
    return self;
}

+ (instancetype)alertViewWithView:(UIView *)tipView
{
    return [[self alloc]initWithAlertView:tipView];
}

+ (void)showAlertViewWithView:(UIView *)alertView
{
    TYShowAlertView *showTipView = [self alertViewWithView:alertView];
    [showTipView show];
}

+ (void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY
{
    [self showAlertViewWithView:alertView
                        originY:originY backgoundTapDismissEnable:YES];
}

+ (void)showAlertViewWithView:(UIView *)alertView originY:(CGFloat)originY backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    TYShowAlertView *showTipView = [self alertViewWithView:alertView];
    showTipView.alertViewOriginY = originY;
    showTipView.backgoundTapDismissEnable = backgoundTapDismissEnable;
    [showTipView show];
}

- (void)addBackgroundView
{
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraintToView:_backgroundView edageInset:UIEdgeInsetsZero];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        
        [self addSubview:backgroundView];
        _backgroundView = backgroundView;
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraintToView:_backgroundView edageInset:UIEdgeInsetsZero];
        [self addSingleGesture];
    }
}
- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

- (void)layoutAlertView
{
    _tipView.translatesAutoresizingMaskIntoConstraints = NO;
    // center X
    [self addConstraintCenterXToView:_tipView CenterYToView:nil];
    
    // top Y
    if (_alertViewOriginY > 0) {
        [self addConstarintWithView:_tipView topView:self leftView:nil bottomView:nil rightView:nil edageInset:UIEdgeInsetsMake(_alertViewOriginY, 0, 0, 0)];
    }else {
        [self addConstraintCenterXToView:nil CenterYToView:_tipView];
    }
    
    if (!CGSizeEqualToSize(_tipView.frame.size,CGSizeZero)) {
        // width
        [_tipView addConstarintWidth:CGRectGetWidth(_tipView.frame) height:CGRectGetHeight(_tipView.frame)];
        
    }else {
        BOOL findAlertViewWidthConstraint = NO;
        for (NSLayoutConstraint *constraint in _tipView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                findAlertViewWidthConstraint = YES;
                break;
            }
        }
        
        if (!findAlertViewWidthConstraint) {
            [_tipView addConstarintWidth:CGRectGetWidth(self.frame)-2*_alertViewEdging height:0];
        }
    }
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
        self.translatesAutoresizingMaskIntoConstraints = 0;
        [kCurrentWindow addConstraintToView:self edageInset:UIEdgeInsetsZero];
        [self layoutAlertView];
    }
    self.alpha = 0;
    self.tipView.transform = CGAffineTransformScale(self.tipView.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        self.tipView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
    
}

- (void)hide
{
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tipView.transform = CGAffineTransformScale(self.tipView.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

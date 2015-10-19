//
//  TYAlertController.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertController.h"
#import "UIView+TYAutoLayout.h"

@interface TYAlertController ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, assign) TYAlertControllerStyle preferredStyle;

@property (nonatomic, assign) TYAlertTransitionAnimation transitionAnimation;

@property (nonatomic, assign) Class transitionAnimationClass;

@property (nonatomic, weak) UITapGestureRecognizer *singleTap;

@end

@implementation TYAlertController

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        [self configureController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation transitionAnimationClass:(Class)transitionAnimationClass
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _alertView = alertView;
        _preferredStyle = preferredStyle;
        _transitionAnimation = transitionAnimation;
        _transitionAnimationClass = transitionAnimationClass;
    }
    return self;
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:TYAlertControllerStyleAlert
                      transitionAnimation:TYAlertTransitionAnimationFade
                 transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:preferredStyle
                      transitionAnimation:TYAlertTransitionAnimationFade
                 transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimation:(TYAlertTransitionAnimation)transitionAnimation
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:preferredStyle
                      transitionAnimation:transitionAnimation
                 transitionAnimationClass:nil];
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle transitionAnimationClass:(Class)transitionAnimationClass
{
    return [[self alloc]initWithAlertView:alertView
                           preferredStyle:preferredStyle
                      transitionAnimation:TYAlertTransitionAnimationCustom
                 transitionAnimationClass:transitionAnimationClass];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    [self addBackgroundView];
    
    [self addSingleTapGesture];
    
    [self configureAlertView];
    
    [self.view layoutIfNeeded];
    
}

- (void)addBackgroundView
{
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self.view addSubview:backgroundView];
    _backgroundView = backgroundView;
    [self.view addConstraintToView:_backgroundView edageInset:UIEdgeInsetsZero];
}

- (void)addSingleTapGesture
{
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgoundTapDismissEnable;
  
    [self.backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        
        [self.view addSubview:backgroundView];
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView = backgroundView;
        [self.view addConstraintToView:_backgroundView edageInset:UIEdgeInsetsZero];
        [self addSingleTapGesture];
    }
}

- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

- (void)configureController
{
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    _backgoundTapDismissEnable = YES;
    _alertViewEdging = 15;
}

- (void)configureAlertView
{
    if (_alertView == nil) {
        NSLog(@"%@: alertView is nil",NSStringFromClass([self class]));
        return;
    }
    _alertView.userInteractionEnabled = YES;
    [self.view addSubview:_alertView];
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    switch (_preferredStyle) {
        case TYAlertControllerStyleActionSheet:
            [self layoutActionSheetStyleView];
            break;
        case TYAlertControllerStyleAlert:
            [self layoutAlertStyleView];
            break;
        default:
            break;
    }
}

#pragma mark - layout 

- (void)layoutAlertStyleView
{
    // center X
    [self.view addConstraintCenterXToView:_alertView CenterYToView:nil];
    
    // top Y
    if (_alertViewOriginY > 0) {
        [self.view addConstarintWithView:_alertView topView:self.view leftView:nil bottomView:nil rightView:nil edageInset:UIEdgeInsetsMake(_alertViewOriginY, 0, 0, 0)];
    }else {
        [self.view addConstraintCenterXToView:nil CenterYToView:_alertView];
    }
    
    if (!CGSizeEqualToSize(_alertView.frame.size,CGSizeZero)) {
        // width
        [_alertView addConstarintWidth:CGRectGetWidth(_alertView.frame) height:CGRectGetHeight(_alertView.frame)];

    }else {
        BOOL findAlertViewWidthConstraint = NO;
        for (NSLayoutConstraint *constraint in _alertView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                findAlertViewWidthConstraint = YES;
                break;
            }
        }
        
        if (!findAlertViewWidthConstraint) {
            [_alertView addConstarintWidth:CGRectGetWidth(self.view.frame)-2*_alertViewEdging height:0];
        }
    }
}

- (void)layoutActionSheetStyleView
{
    // center X
    [self.view addConstraintCenterXToView:_alertView CenterYToView:nil];
    
    [self.view addConstarintWithView:_alertView topView:nil leftView:self.view bottomView:self.view rightView:self.view edageInset:UIEdgeInsetsZero];
    
    if (CGRectGetHeight(_alertView.frame) > 0) {
        // height
        [_alertView addConstarintWidth:0 height:CGRectGetHeight(_alertView.frame)];
    }

}

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    [self dismissViewControllerAnimated:YES completion:self.dismissComplete];
}

#pragma mark - action

- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"TYAlertController dealloc");
}

@end

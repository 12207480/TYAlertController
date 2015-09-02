//
//  TYAlertController.m
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertController.h"

@interface TYAlertController ()

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, assign) TYAlertControllerStyle preferredStyle;
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

- (instancetype)initWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _alertView = alertView;
        _preferredStyle = preferredStyle;
    }
    return self;
}

+ (instancetype)alertControllerWithAlertView:(UIView *)alertView preferredStyle:(TYAlertControllerStyle)preferredStyle
{
    return [[self alloc]initWithAlertView:alertView preferredStyle:preferredStyle];
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    [self addSingleTapGesture];
    
    [self configureAlertView];
}

- (void)addSingleTapGesture
{
    if (!self.backgoundTapEnable) {
        return;
    }
    // 点击删除
    self.view.userInteractionEnabled = YES;
    //单指单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    //手指数
    singleTap.numberOfTouchesRequired = 1;
    //点击次数
    singleTap.numberOfTapsRequired = 1;
    //增加事件者响应者，
    [self.view addGestureRecognizer:singleTap];
}

- (void)configureController
{
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    self.backgoundTapEnable = YES;
}

- (void)configureAlertView
{
    if (_alertView == nil) {
        NSLog(@"%@: alertView is nil",NSStringFromClass([self class]));
        return;
    }
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
    NSLayoutConstraint *alertViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    // top Y
    CGFloat alertViewTopY = _alertViewTopY > 0 ? _alertViewTopY : (CGRectGetHeight(self.view.frame) - CGRectGetHeight(_alertView.frame))/2;
    NSLayoutConstraint *alertViewTopYConstraint = [NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:alertViewTopY];
    
    [_alertView addConstraint:[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetHeight(_alertView.frame)]];
    
    [_alertView addConstraint:[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetWidth(_alertView.frame)]];
    
    [self.view addConstraints:@[alertViewCenterXConstraint,alertViewTopYConstraint]];
}

- (void)layoutActionSheetStyleView
{
    // center X
    NSLayoutConstraint *alertViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    NSLayoutConstraint *alertViewButtomYConstraint = [NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSLayoutConstraint *alertViewLeftConstraint = [NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    NSLayoutConstraint *alertViewRightConstraint = [NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    [_alertView addConstraint:[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:CGRectGetHeight(_alertView.frame)]];
    
    [self.view addConstraints:@[alertViewCenterXConstraint,alertViewButtomYConstraint,alertViewLeftConstraint,alertViewRightConstraint]];
}

#pragma mark - action

- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:self.dismissComplete];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

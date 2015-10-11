//
//  TYAlertView.m
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertView.h"
#import "UIView+TYAutoLayout.h"

@interface TYAlertAction ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) TYAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(TYAlertAction *);
@end

@implementation TYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(TYAlertActionStyle)style handler:(void (^)(TYAlertAction *))handler
{
    return [[self alloc]initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(TYAlertActionStyle)style handler:(void (^)(TYAlertAction *))handler
{
    if (self = [super init]) {
        _title = title;
        _style = style;
        _enabled = YES;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    TYAlertAction *action = [[self class]allocWithZone:zone];
    action.title = self.title;
    action.style = self.style;
    return action;
}

@end


@interface TYAlertView ()

// text content View
@property (nonatomic, weak) UIView *textContentView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UIView *textFeildContentView;
@property (nonatomic, weak) NSLayoutConstraint *textFeildTopConstraint;
@property (nonatomic, strong) NSMutableArray *textFeilds;

// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *actions;

@property (nonatomic, assign) CGFloat contentViewSpace;
@property (nonatomic, assign) CGFloat textLabelSpace;
@property (nonatomic, assign) CGFloat contentViewEdge;

@end

#define kButtonTagOffset 1000
#define KButtonHeight    44
#define kTextFeildOffset 10000
#define kTextFeildHeight 30
#define kTextFeildBorderColor [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];

@implementation TYAlertView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self configureProperty];
        
        [self addContentViews];
        
        [self layoutContentViews];
        
        [self addTextLabels];
        
        [self layoutTextLabels];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [super init]) {
        
        _titleLable.text = title;
        _messageLabel.text = message;
        
    }
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    return [[self alloc]initWithTitle:title message:message];
}

- (void)configureProperty
{
    _contentViewSpace = 15;
    _contentViewEdge = 12;
    _textLabelSpace = 6;
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
    
    _textFieldBorderColor = kTextFeildBorderColor;
}

#pragma mark - add contentview

- (void)addContentViews
{
    UIView *textContentView = [[UIView alloc]init];
    [self addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFeildContentView = [[UIView alloc]init];
    [self addSubview:textFeildContentView];
    _textFeildContentView = textFeildContentView;
    
    UIView *buttonContentView = [[UIView alloc]init];
    buttonContentView.userInteractionEnabled = YES;
    [self addSubview:buttonContentView];
    _buttonContentView = buttonContentView;
}

- (void)addTextLabels
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_textContentView addSubview:titleLabel];
    _titleLable = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    messageLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_textContentView addSubview:messageLabel];
    _messageLabel = messageLabel;
}

- (void)addAction:(TYAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    [button setTitle:action.title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];
    
    [self layoutButtons];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textFeild))configurationHandler
{
    if (_textFeilds == nil) {
        _textFeilds = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFeildOffset + _textFeilds.count;
    textField.backgroundColor = [UIColor whiteColor];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFeildContentView addSubview:textField];
    [_textFeilds addObject:textField];
    
    [self layoutTextFeilds];
}

#pragma mark - layout contenview

- (void)layoutContentViews
{
    // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstarintWithView:_textContentView topView:self leftView:self bottomView:nil rightView:self edageInset:UIEdgeInsetsMake(_contentViewEdge, _contentViewEdge, 0, -_contentViewEdge)];
    
    // textFeildContentView
    _textFeildContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _textFeildTopConstraint = [self addConstarintWithTopView:_textContentView toBottomView:_textFeildContentView constarint:0];
    
    [self addConstarintWithView:_textFeildContentView topView:nil leftView:self bottomView:nil rightView:self edageInset:UIEdgeInsetsMake(0, _contentViewEdge, 0, -_contentViewEdge)];
    
    // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstarintWithTopView:_textFeildContentView toBottomView:_buttonContentView constarint:_contentViewSpace];
    
    [self addConstarintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edageInset:UIEdgeInsetsMake(0, _contentViewEdge, -_contentViewEdge, -_contentViewEdge)];
}

- (void)layoutTextLabels
{
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstarintWithView:_titleLable topView:_textContentView leftView:_textContentView bottomView:nil rightView:_textContentView edageInset:UIEdgeInsetsZero];
    
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstarintWithTopView:_titleLable toBottomView:_messageLabel constarint:_textLabelSpace];
    [_textContentView addConstarintWithView:_messageLabel topView:nil leftView:_textContentView bottomView:_textContentView rightView:_textContentView edageInset:UIEdgeInsetsZero];
}

- (void)layoutButtons
{
    UIButton *button = _buttons.lastObject;
    if (_buttons.count == 1) {
        [button addConstraintToView:_buttonContentView edageInset:UIEdgeInsetsZero];
        [button addConstarintWidth:0 height:KButtonHeight];
    }else if (_buttons.count == 2) {
        UIButton *firstButton = _buttons.firstObject;
        [_buttonContentView removeConstraintWithView:firstButton attribte:NSLayoutAttributeRight];
        [_buttonContentView addConstarintWithView:button topView:_buttonContentView leftView:nil bottomView:nil rightView:_buttonContentView edageInset:UIEdgeInsetsZero];
        [_buttonContentView addConstarintWithLeftView:firstButton toRightView:button constarint:_textLabelSpace];
        [_buttonContentView addConstarintEqualWithView:button widthToView:firstButton heightToView:firstButton];
    }else {
        if (_buttons.count == 3) {
            UIButton *firstBtn = _buttons[0];
            UIButton *secondBtn = _buttons[1];
            [_buttonContentView removeConstraintWithView:firstBtn attribte:NSLayoutAttributeRight];
            [_buttonContentView removeConstraintWithView:firstBtn attribte:NSLayoutAttributeBottom];
            [_buttonContentView removeConstraintWithView:secondBtn attribte:NSLayoutAttributeTop];
            [_buttonContentView addConstarintWithView:firstBtn topView:nil leftView:nil bottomView:0 rightView:_buttonContentView edageInset:UIEdgeInsetsZero];
            [_buttonContentView addConstarintWithTopView:firstBtn toBottomView:secondBtn constarint:_textLabelSpace];
            
        }
        UIButton *lastSecondBtn = _buttons[_buttons.count-2];
        [_buttonContentView removeConstraintWithView:lastSecondBtn attribte:NSLayoutAttributeBottom];
        [_buttonContentView addConstarintWithTopView:lastSecondBtn toBottomView:button constarint:_textLabelSpace];
        [_buttonContentView addConstarintWithView:button topView:nil leftView:_buttonContentView bottomView:_buttonContentView rightView:_buttonContentView edageInset:UIEdgeInsetsZero];
        [_buttonContentView addConstarintEqualWithView:button widthToView:nil heightToView:lastSecondBtn];
    }
}

- (void)layoutTextFeilds
{
    UITextField *textFeild = _textFeilds.lastObject;
    
    if (_textFeilds.count == 1) {
        // setup textFeildContentView
        _textFeildContentView.backgroundColor = _textFieldBorderColor;
        _textFeildContentView.layer.masksToBounds = YES;
        _textFeildContentView.layer.cornerRadius = 4;
        _textFeildContentView.layer.borderWidth = 0.5;
        _textFeildContentView.layer.borderColor = _textFieldBorderColor.CGColor;
        _textFeildTopConstraint.constant = -_contentViewSpace;
        [textFeild addConstraintToView:_textFeildContentView edageInset:UIEdgeInsetsZero];
        [textFeild addConstarintWidth:0 height:kTextFeildHeight];
    }else {
        UITextField *lastSecondTextFeild = _textFeilds[_textFeilds.count-2];
        [_textFeildContentView removeConstraintWithView:lastSecondTextFeild attribte:NSLayoutAttributeBottom];
        [_textFeildContentView addConstarintWithTopView:lastSecondTextFeild toBottomView:textFeild constarint:0.5];
        [_textFeildContentView addConstarintWithView:textFeild topView:nil leftView:_textFeildContentView bottomView:_textFeildContentView rightView:_textFeildContentView edageInset:UIEdgeInsetsZero];
        [_textFeildContentView addConstarintEqualWithView:textFeild widthToView:nil heightToView:lastSecondTextFeild];
    }
}

#pragma mark - action

- (void)actionButtonClicked:(UIButton *)button
{
    NSLog(@"actionButtonClicked tag:%ld",button.tag);
    TYAlertAction *action = _actions[button.tag - kButtonTagOffset];
    
    if (action.handler) {
        action.handler(action);
    }
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

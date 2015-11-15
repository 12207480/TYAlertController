//
//  TYAlertView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYAlertView.h"
#import "UIView+TYAlertView.h"
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
        _handler = handler;
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
@property (nonatomic, strong) NSMutableArray *textFeildSeparateViews;

// button content View
@property (nonatomic, weak) UIView *buttonContentView;
@property (nonatomic, weak) NSLayoutConstraint *buttonTopConstraint;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *actions;

@end

#define kAlertViewWidth 280
#define kContentViewEdge 15
#define kContentViewSpace 15

#define kTextLabelSpace  6

#define kButtonTagOffset 1000
#define kButtonSpace     6
#define KButtonHeight    44

#define kTextFeildOffset 10000
#define kTextFeildHeight 29
#define kTextFeildEdge  8
#define KTextFeildBorderWidth 0.5


@implementation TYAlertView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self configureProperty];
        
        [self addContentViews];
        
        [self addTextLabels];
        
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

#pragma mark - configure

- (void)configureProperty
{
    self.backgroundColor = [UIColor whiteColor];
    _alertViewWidth = kAlertViewWidth;
    _contentViewSpace = kContentViewSpace;
    
    _textLabelSpace = kTextLabelSpace;
    _textLabelContentViewEdge = kContentViewEdge;
    
    _buttonHeight = KButtonHeight;
    _buttonSpace = kButtonSpace;
    _buttonContentViewEdge = kContentViewEdge;
    _buttonCornerRadius = 4.0;
    _buttonFont = [UIFont fontWithName:@"HelveticaNeue" size:18];;
    _buttonDefaultBgColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    _buttonCancleBgColor = [UIColor colorWithRed:127/255.0 green:140/255.0 blue:141/255.0 alpha:1];
    _buttonDestructiveBgColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];
    
    _textFeildHeight = kTextFeildHeight;
    _textFeildEdge = kTextFeildEdge;
    _textFeildorderWidth = KTextFeildBorderWidth;
    _textFeildContentViewEdge = kContentViewEdge;
    
    _textFieldBorderColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    _textFieldBackgroudColor = [UIColor whiteColor];
    _textFieldFont = [UIFont systemFontOfSize:14];
    
    _buttons = [NSMutableArray array];
    _actions = [NSMutableArray array];
}

- (UIColor *)buttonBgColorWithStyle:(TYAlertActionStyle)style
{
    switch (style) {
        case TYAlertActionStyleDefault:
            return _buttonDefaultBgColor;
        case TYAlertActionStyleCancle:
            return _buttonCancleBgColor;
        case TYAlertActionStyleDestructive:
            return _buttonDestructiveBgColor;
            
        default:
            return nil;
    }
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

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
}

- (void)addAction:(TYAlertAction *)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = _buttonCornerRadius;
    [button setTitle:action.title forState:UIControlStateNormal];
    button.titleLabel.font = _buttonFont;
    button.backgroundColor = [self buttonBgColorWithStyle:action.style];
    button.enabled = action.enabled;
    button.tag = kButtonTagOffset + _buttons.count;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonContentView addSubview:button];
    [_buttons addObject:button];
    [_actions addObject:action];
    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
    
    [self layoutButtons];
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textFeild))configurationHandler
{
    if (_textFeilds == nil) {
        _textFeilds = [NSMutableArray array];
    }
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = kTextFeildOffset + _textFeilds.count;
    textField.font = _textFieldFont;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (configurationHandler) {
        configurationHandler(textField);
    }
    
    [_textFeildContentView addSubview:textField];
    [_textFeilds addObject:textField];
    
    if (_textFeilds.count > 1) {
        if (_textFeildSeparateViews == nil) {
            _textFeildSeparateViews = [NSMutableArray array];
        }
        UIView *separateView = [[UIView alloc]init];
        separateView.backgroundColor = _textFieldBorderColor;
        separateView.translatesAutoresizingMaskIntoConstraints = NO;
        [_textFeildContentView addSubview:separateView];
        [_textFeildSeparateViews addObject:separateView];
    }
    
    [self layoutTextFeilds];
}

- (NSArray *)textFieldArray
{
    return _textFeilds;
}

#pragma mark - layout contenview

- (void)layoutContentViews
{
    if (!_textContentView.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    if (_alertViewWidth) {
        [self addConstarintWidth:_alertViewWidth height:0];
    }
    
    // textContentView
    _textContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstarintWithView:_textContentView topView:self leftView:self bottomView:nil rightView:self edageInset:UIEdgeInsetsMake(_contentViewSpace, _textLabelContentViewEdge, 0, -_textLabelContentViewEdge)];
    
    // textFeildContentView
    _textFeildContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _textFeildTopConstraint = [self addConstarintWithTopView:_textContentView toBottomView:_textFeildContentView constarint:0];
    
    [self addConstarintWithView:_textFeildContentView topView:nil leftView:self bottomView:nil rightView:self edageInset:UIEdgeInsetsMake(0, _textFeildContentViewEdge, 0, -_textFeildContentViewEdge)];
    
    // buttonContentView
    _buttonContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _buttonTopConstraint = [self addConstarintWithTopView:_textFeildContentView toBottomView:_buttonContentView constarint:0];
    
    [self addConstarintWithView:_buttonContentView topView:nil leftView:self bottomView:self rightView:self edageInset:UIEdgeInsetsMake(0, _buttonContentViewEdge, -_contentViewSpace, -_buttonContentViewEdge)];
}

- (void)layoutTextLabels
{
    if (!_titleLable.translatesAutoresizingMaskIntoConstraints && !_messageLabel.translatesAutoresizingMaskIntoConstraints) {
        // layout done
        return;
    }
    // title
    _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstarintWithView:_titleLable topView:_textContentView leftView:_textContentView bottomView:nil rightView:_textContentView edageInset:UIEdgeInsetsZero];
    
    // message
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_textContentView addConstarintWithTopView:_titleLable toBottomView:_messageLabel constarint:_textLabelSpace];
    [_textContentView addConstarintWithView:_messageLabel topView:nil leftView:_textContentView bottomView:_textContentView rightView:_textContentView edageInset:UIEdgeInsetsZero];
}

- (void)layoutButtons
{
    UIButton *button = _buttons.lastObject;
    if (_buttons.count == 1) {
        _buttonTopConstraint.constant = -_contentViewSpace;
        [_buttonContentView addConstraintToView:button edageInset:UIEdgeInsetsZero];
        [button addConstarintWidth:0 height:_buttonHeight];
    }else if (_buttons.count == 2) {
        UIButton *firstButton = _buttons.firstObject;
        [_buttonContentView removeConstraintWithView:firstButton attribte:NSLayoutAttributeRight];
        [_buttonContentView addConstarintWithView:button topView:_buttonContentView leftView:nil bottomView:nil rightView:_buttonContentView edageInset:UIEdgeInsetsZero];
        [_buttonContentView addConstarintWithLeftView:firstButton toRightView:button constarint:_buttonSpace];
        [_buttonContentView addConstarintEqualWithView:button widthToView:firstButton heightToView:firstButton];
    }else {
        if (_buttons.count == 3) {
            UIButton *firstBtn = _buttons[0];
            UIButton *secondBtn = _buttons[1];
            [_buttonContentView removeConstraintWithView:firstBtn attribte:NSLayoutAttributeRight];
            [_buttonContentView removeConstraintWithView:firstBtn attribte:NSLayoutAttributeBottom];
            [_buttonContentView removeConstraintWithView:secondBtn attribte:NSLayoutAttributeTop];
            [_buttonContentView addConstarintWithView:firstBtn topView:nil leftView:nil bottomView:0 rightView:_buttonContentView edageInset:UIEdgeInsetsZero];
            [_buttonContentView addConstarintWithTopView:firstBtn toBottomView:secondBtn constarint:_buttonSpace];
            
        }
        
        UIButton *lastSecondBtn = _buttons[_buttons.count-2];
        [_buttonContentView removeConstraintWithView:lastSecondBtn attribte:NSLayoutAttributeBottom];
        [_buttonContentView addConstarintWithTopView:lastSecondBtn toBottomView:button constarint:_buttonSpace];
        [_buttonContentView addConstarintWithView:button topView:nil leftView:_buttonContentView bottomView:_buttonContentView rightView:_buttonContentView edageInset:UIEdgeInsetsZero];
        [_buttonContentView addConstarintEqualWithView:button widthToView:nil heightToView:lastSecondBtn];
    }
}

- (void)layoutTextFeilds
{
    UITextField *textFeild = _textFeilds.lastObject;
    
    if (_textFeilds.count == 1) {
        // setup textFeildContentView
        _textFeildContentView.backgroundColor = _textFieldBackgroudColor;
        _textFeildContentView.layer.masksToBounds = YES;
        _textFeildContentView.layer.cornerRadius = 4;
        _textFeildContentView.layer.borderWidth = _textFeildorderWidth;
        _textFeildContentView.layer.borderColor = _textFieldBorderColor.CGColor;
        _textFeildTopConstraint.constant = -_contentViewSpace;
        [_textFeildContentView addConstraintToView:textFeild edageInset:UIEdgeInsetsMake(_textFeildorderWidth, _textFeildEdge, -_textFeildorderWidth, -_textFeildEdge)];
        [textFeild addConstarintWidth:0 height:_textFeildHeight];
    }else {
        // textFeild
        UITextField *lastSecondTextFeild = _textFeilds[_textFeilds.count - 2];
        [_textFeildContentView removeConstraintWithView:lastSecondTextFeild attribte:NSLayoutAttributeBottom];
        [_textFeildContentView addConstarintWithTopView:lastSecondTextFeild toBottomView:textFeild constarint:_textFeildorderWidth];
        [_textFeildContentView addConstarintWithView:textFeild topView:nil leftView:_textFeildContentView bottomView:_textFeildContentView rightView:_textFeildContentView edageInset:UIEdgeInsetsMake(0, _textFeildEdge, -_textFeildorderWidth, -_textFeildEdge)];
        [_textFeildContentView addConstarintEqualWithView:textFeild widthToView:nil heightToView:lastSecondTextFeild];
        
        // separateview
        UIView *separateView = _textFeildSeparateViews[_textFeilds.count - 2];
        [_textFeildContentView addConstarintWithView:separateView topView:nil leftView:_textFeildContentView bottomView:nil rightView:_textFeildContentView edageInset:UIEdgeInsetsZero];
        [_textFeildContentView addConstarintWithTopView:separateView toBottomView:textFeild constarint:0];
        [separateView addConstarintWidth:0 height:_textFeildorderWidth];
    }
}

#pragma mark - action

- (void)actionButtonClicked:(UIButton *)button
{
    TYAlertAction *action = _actions[button.tag - kButtonTagOffset];
    
    [self hideView];
    
    if (action.handler) {
        action.handler(action);
    }
}

//- (void)dealloc
//{
//    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
//}

@end

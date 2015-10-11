//
//  TYAlertView.h
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/7.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "UIView+TYAlertView.h"

typedef enum : NSUInteger {
    TYAlertActionStyleDefault,
    TYAlertActionStyleCancle,
    TYAlertActionStyleDestructive,
} TYAlertActionStyle;


@interface TYAlertAction : NSObject <NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(TYAlertActionStyle)style handler:(void (^)(TYAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) TYAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end


@interface TYAlertView : UIView

@property (nonatomic, weak, readonly) UILabel *titleLable;
@property (nonatomic, weak, readonly) UILabel *messageLabel;

@property (nonatomic, strong) UIColor *textFieldBorderColor;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message;

- (void)addAction:(TYAlertAction *)action;

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

@end

//
//  ViewController.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "ViewController.h"
// contain this header
#import "UIView+TYAlertView.h"
// if you want blur efffect contain this 
#import "TYAlertController+BlurEffects.h"

#import "SettingModelView.h"
#import "ShareView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)showAlertViewAction:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"This is a message, the alert view containt text and textfiled. "];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    // 弱引用alertView 否则 会循环引用
    __typeof (alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
        NSLog(@"%@",action.title);
        for (UITextField *textField in weakAlertView.textFieldArray) {
            NSLog(@"%@",textField.text);
        }
    }]];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入账号";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
    }];
    
    // first way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    
    [alertController setViewWillShowHandler:^(UIView *alertView) {
        NSLog(@"ViewWillShow");
    }];
    
    [alertController setViewDidShowHandler:^(UIView *alertView) {
        NSLog(@"ViewDidShow");
    }];
    
    [alertController setViewWillHideHandler:^(UIView *alertView) {
        NSLog(@"ViewWillHide");
    }];
    
    [alertController setViewDidHideHandler:^(UIView *alertView) {
        NSLog(@"ViewDidHide");
    }];
    
    [alertController setDismissComplete:^{
        NSLog(@"DismissComplete");
    }];
    
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
    
    // second way ,use UIView Category
    //[alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
    
}
- (IBAction)showActionSheetAction:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"This is a message, the alert view style is actionsheet. "];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"默认2" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"默认1" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)blurEffectAlertViewAction:(id)sender {
    ShareView *shareView = [ShareView createViewFromNib];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
    
    // blur effect
    [alertController setBlurEffectWithView:self.view];
    
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)dropdwonAnimationAction:(id)sender {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"This is a message, the alert view containt dropdwon animation. "];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown];
    [self presentViewController:alertController animated:YES completion:nil];

    // or show,use UIView Category
    //[alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
}

- (IBAction)costomActonSheetAction:(id)sender {
    // customview from xib
    SettingModelView *settingModelView = [SettingModelView createViewFromNib];
    
    // fisrt way to show ,use UIView Category
//    [settingModelView showInController:self preferredStyle:TYAlertControllerStyleActionSheet backgoundTapDismissEnable:YES];
    
    // second way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:settingModelView preferredStyle:TYAlertControllerStyleActionSheet];
    alertController.backgoundTapDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)showAlertViewInWindowAction:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, but it can support long message, hahahhahahahahhahahahahhaahahhahahahahahhahahahahhahahahahahhahahahahahhahahahhahahhahahahahh. (NSTextAlignmentCenter)"];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
    }]];
    
    // first way to show ,use UIView Category
    [alertView showInWindowWithOriginY:200 backgoundTapDismissEnable:YES];
    
    // second way to show
    //[TYShowAlertView showAlertViewWithView:alertView originY:200 backgoundTapDismissEnable:YES];
}

- (IBAction)customViewInWindowAction:(id)sender {
    ShareView *shareView = [ShareView createViewFromNib];

    // use UIView Category
    [shareView showInWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

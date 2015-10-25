//
//  ViewController.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TYAlertView.h"
#import "UIImage+ImageEffects.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showAlertViewAction:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, complete sentence."];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];

    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
//    [alertView addAction:[TYAlertAction actionWithTitle:@"默认1" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
//        
//    }]];
    
//    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入账号";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
    }];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)showActionSheetAction:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, complete sentence."];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"默认2" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
    
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"默认1" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)blurEffectAlertViewAction:(id)sender {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"This is a blur effect on background, is beautiful effect"];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    
    UIImage *blurImage =[[UIImage snapshotImageWithView:self.view] applyLightEffect];
    UIImageView *blurImageView = [[UIImageView alloc]initWithImage:blurImage];
    alertController.backgroundView = blurImageView;
    
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)showAlertViewInWindowAction:(id)sender {
    
//    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    redView.backgroundColor = [UIColor redColor];
    //[redView showInWindowWithBackgoundTapDismissEnable:YES];
    //[redView showInController:self];
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, complete sentence."];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
    }]];
    
    [TYShowAlertView showAlertViewWithView:alertView originY:200 backgoundTapDismissEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

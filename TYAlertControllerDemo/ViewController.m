//
//  ViewController.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TYAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UIAlertController
}


- (IBAction)showAlertView:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, complete sentence."];

    __typeof (self) __weak weakSelf = self;

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
    }]];
    
//    [alertView addAction:[TYAlertAction actionWithTitle:@"默认1" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
//        
//    }]];
//    [alertView addAction:[TYAlertAction actionWithTitle:@"默认2" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
//        
//    }]];
//    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)showActionSheet:(id)sender {
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, complete sentence."];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"默认1" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)showAlertViewInWindow:(id)sender {
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    [redView showInWindowWithOriginY:60];
    //[redView showInController:self];
    //[TYShowAlertView showAlertViewWithView:redView originY:60];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

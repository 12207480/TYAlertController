//
//  ViewController.m
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "ViewController.h"
#import "TYAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showAlertView:(id)sender {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 120)];
    view.backgroundColor = [UIColor blueColor];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:view preferredStyle:TYAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)showActionSheet:(id)sender {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 120)];
    view.backgroundColor = [UIColor blueColor];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:view preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

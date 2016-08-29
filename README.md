# TYAlertController
Powerful, Easy to use alertView or popupView on controller and window, support blur effect, custom view and custom animation, use aotolayout.support iphone, ipad .

## CocoaPods
```
pod 'TYAlertController', '~> 1.1.6'
```

### ScreenShot
![image](https://github.com/12207480/TYAlertController/blob/master/screenshot/TYAlertControllerDemo.gif)

### Requirements
* Xcode 5 or higher
* iOS 7.0 or higher
* ARC

### Usage

1.copy TYAlertController Folder to your project, if you want to have blur effect ,you need copy Blur Effects Folder to your project.<br>
2. #import "UIView+TYAlertView.h", when you use it, if you want use blur effect, #import "TYAlertController+BlurEffects.h".<br>
3. you can use TYAlertController show in controller, or use TYShowAlertView show in window, or use Category UIView+TYAlertView convenient show alertview.<br>
4. check Demo，it have more usefull usage and example.

### usege demo

* alertView lifecycle block
```objc
// alertView lifecycle block
@property (copy, nonatomic) void (^viewWillShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidShowHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewWillHideHandler)(UIView *alertView);
@property (copy, nonatomic) void (^viewDidHideHandler)(UIView *alertView);

// dismiss controller completed block
@property (nonatomic, copy) void (^dismissComplete)(void);
```

* show in controller (tow way)(recommend)
```objc
TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"This is a message, the alert view containt text and textfiled. "];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];

    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入账号";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
    }];
    
    // first way to show
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
    
    // second way to show,use UIView Category
    //[alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
```

* show in window (tow way)
```objc
TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"TYAlertView" message:@"A message should be a short, but it can support long message"];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    // first way to show ,use UIView Category
    [alertView showInWindowWithOriginY:200 backgoundTapDismissEnable:YES];
    
    // second way to show
   // [TYShowAlertView showAlertViewWithView:alertView originY:200 backgoundTapDismissEnable:YES];
```

### Contact
if you find bug，please pull reqeust me <br>
if you have good idea，contact me, Email:122074809@qq.com


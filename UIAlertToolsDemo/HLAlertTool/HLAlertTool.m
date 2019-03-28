//
//  UCSAlertTool.m
//  UCSCommon
//
//  Created by Lucky on 2018/11/23.
//  Copyright © 2018年 simba.pro. All rights reserved.
//

#import "HLAlertTool.h"
#import <UIKit/UIKit.h>

#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.f

@interface HLAlertTool () <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *alertTitleArray;
@property (nonatomic, strong) NSMutableArray *alertActionArray;
@property (nonatomic, strong) NSMutableArray *sheetTitleArray;
@property (nonatomic, strong) NSMutableArray *sheetActionArray;
@property (nonatomic, strong) NSMutableArray *alertTypeArray;

@property (strong, nonatomic) UIWindow *alertWindow;

@end


@implementation HLAlertTool

//重写该方法，保证该对象不会被释放，如果被释放，iOS8以下的UIAlertView的回调时候会崩溃
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    static HLAlertTool *_shareAlertView = nil;
    dispatch_once(&onceToken, ^{
        if (_shareAlertView == nil) {
            _shareAlertView = [super allocWithZone:zone];
        }
    });
    return _shareAlertView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _alertTitleArray = [NSMutableArray array];
        _alertActionArray = [NSMutableArray array];
        _sheetTitleArray = [NSMutableArray array];
        _sheetActionArray = [NSMutableArray array];
        _alertTypeArray = [NSMutableArray array];
    }
    return self;
}

- (UIWindow *)alertWindow {
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIViewController *viewController = [[UIViewController alloc] init];
        _alertWindow.rootViewController = viewController;
    }
    return _alertWindow;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if ([self init]) {
        _alertTitle = title;
        _alertMessage = message;
    }
    return self;
}

- (void)setAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage {
    _alertTitle = alertTitle;
    _alertMessage = alertMessage;
}

- (void)addAlertActonWithTitle:(NSString *)title alertType:(HLAlertType)alertType aciton:(HLAlertAction)action {
    if (title.length > 0) {
        [_alertTitleArray addObject:title];
    } else {
        [_alertTitleArray addObject:@""];
    }
    
    [_alertActionArray addObject:action];
    
    NSNumber *number = [NSNumber numberWithInt:alertType];
    if ([number stringValue].length == 0) {
        number = @2;
    }
    
    [_alertTypeArray addObject:number];
}

- (void)addSheetActonWithTitle:(NSString *)title sheetType:(HLAlertType)sheetType aciton:(HLAlertAction)action{
    if (title.length > 0) {
        [_sheetTitleArray addObject:title];
    } else {
        [_sheetActionArray addObject:@""];
    }
    [_sheetActionArray addObject:action];
    
    NSNumber *number = [NSNumber numberWithInt:sheetType];
    if ([number stringValue].length == 0) {
        number = @2;
    }
    
    [_alertTypeArray addObject:number];
}

- (void)showAlert {
    if (_alertTitleArray.count == 0) {
        return;
    }
    [self showAlertController];
//  不再考虑ios8
//    if (IOS8) {
//    } else {
//        [self showAlertView];
//    }
}

- (void)showAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_alertTitle message:_alertMessage preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < _alertTitleArray.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:_alertTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            HLAlertAction ac = self->_alertActionArray[i];
            ac();
            
        }];
        [alert addAction:action];
    }
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

//- (void)showAlertView {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_alertTitle message:_alertMessage delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//    for (NSString *title in _alertTitleArray) {
//        [alert addButtonWithTitle:title];
//    }
//
//    [alert show];
//}

- (void)showSheet {
    if (_sheetTitleArray.count == 0) {
        return;
    }
    [self showActionSheetController];
//
//    if (IOS8) {
//    } else {
//        [self showActionSheet];
//    }
}

// 此写法需注意事项为取消项必须放在最后

- (void)showActionSheetController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_alertTitle message:_alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < _sheetTitleArray.count; i++) {
        
        NSNumber *number = _alertTypeArray[i];
        if ([number intValue] == HLAlertTypeCancel) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:_sheetTitleArray[i] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                [window makeKeyAndVisible];
                HLAlertAction ac = self->_sheetActionArray[i];
                ac();
                
            }];
            [alert addAction:action];
        } else if ([number intValue] == HLAlertTypeDestructive) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:_sheetTitleArray[i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                [window makeKeyAndVisible];
                HLAlertAction ac = self->_sheetActionArray[i];
                ac();
                
            }];
            [alert addAction:action];
        } else if ([number intValue] == HLAlertTypeDefault) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:_sheetTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                [window makeKeyAndVisible];
                HLAlertAction ac = self->_sheetActionArray[i];
                ac();
                
            }];
            [alert addAction:action];
        }
    }
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

//
//- (void)showActionSheet {
//
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:_alertTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:_alertMessage otherButtonTitles:nil, nil];
//
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//
//    for (NSString *title in _sheetTitleArray) {
//        [actionSheet addButtonWithTitle:title];
//    }
//
//    [actionSheet showInView:self.controller.view];
//}
//
//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    UCSAlertAction action = _alertActionArray[buttonIndex];
//    action();
//}
//
//#pragma mark - UIActionSheetDelegate
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    UCSAlertAction action = _sheetActionArray[buttonIndex];
//    action();
//
//}
//

- (void)showAlertViewWithAlertTitle:(NSString *)title
                       alertMessage:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                        comfirTitle:(NSString *)comfirTitle
                       comfirHandle:(HLAlertAction)comfirhandle
                       cancelHandle:(HLAlertAction)cancelhandle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Add the actions.
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (cancelhandle != nil) {
                cancelhandle();
            }
        }];
        [alertController addAction:cancelAction];
    }
    if (comfirTitle.length > 0) {
        UIAlertAction *comfirAction = [UIAlertAction actionWithTitle:comfirTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (comfirhandle != nil) {
                comfirhandle();
            }
            
        }];
        [alertController addAction:comfirAction];
    }
    
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertViewWithTextFiledAlertTitle:(NSString *)title
                                alertMessage:(NSString *)message
                                 cancelTitle:(NSString *)cancelTitle
                                 comfirTitle:(NSString *)comfirTitle
                             textFieldhandle:(HLAlertTextFiled)textFieldhandle
                                comfirHandle:(HLAlertAction)comfirhandle
                                cancelHandle:(HLAlertAction)cancelhandle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textFieldhandle(textField);
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        //        textField.secureTextEntry = YES;
    }];
    // Add the actions.
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (cancelhandle != nil) {
                cancelhandle();
            }
            
            
        }];
        [alertController addAction:cancelAction];
    }
    if (comfirTitle.length > 0) {
        UIAlertAction *comfirAction = [UIAlertAction actionWithTitle:comfirTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (comfirhandle != nil) {
                comfirhandle();
            }
            
        }];
        [alertController addAction:comfirAction];
    }
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showSheetViewWithSheetTitle:(NSString *)title
                       sheetMessage:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                        comfirTitle:(NSString *)comfirTitle
                       comfirHandle:(HLAlertAction)comfirhandle
                       cancelHandle:(HLAlertAction)cancelhandle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // Add the actions.
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (cancelhandle != nil) {
                cancelhandle();
            }
            
        }];
        [alertController addAction:cancelAction];
    }
    if (comfirTitle.length > 0) {
        UIAlertAction *comfirAction = [UIAlertAction actionWithTitle:comfirTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (comfirhandle != nil) {
                comfirhandle();
            }
        }];
        [alertController addAction:comfirAction];
    }
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showSheetOtherViewWithSheetTitle:(NSString *)title
                            sheetMessage:(NSString *)message
                             cancelTitle:(NSString *)cancelTitle
                              otherTitle:(NSString *)otherTitle
                             comfirTitle:(NSString *)comfirTitle
                            comfirHandle:(HLAlertAction)comfirhandle
                             otherHandle:(HLAlertAction)otherhandle
                            cancelHandle:(HLAlertAction)cancelhandle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // Add the actions.
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (cancelhandle != nil) {
                cancelhandle();
            }
            
        }];
        [alertController addAction:cancelAction];
    }
    if (comfirTitle.length > 0) {
        UIAlertAction *comfirAction = [UIAlertAction actionWithTitle:comfirTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (comfirhandle != nil) {
                comfirhandle();
            }
            
        }];
        [alertController addAction:comfirAction];
    }
    
    if (otherTitle.length > 0) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            [window makeKeyAndVisible];
            if (otherhandle != nil) {
                otherhandle();
            }
            
        }];
        [alertController addAction:otherAction];
    }
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end


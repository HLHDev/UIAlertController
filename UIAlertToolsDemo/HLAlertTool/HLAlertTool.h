//
//  UCSAlertTool.h
//  UCSCommon
//
//  Created by Lucky on 2018/11/23.
//  Copyright © 2018年 simba.pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HLAlertAction)(void);
typedef void (^HLAlertTextFiled)(UITextField *textFiled);

typedef NS_ENUM(NSInteger, HLAlertType){
    HLAlertTypeCancel = 0,
    HLAlertTypeDestructive,
    HLAlertTypeDefault
};

@interface HLAlertTool : NSObject

@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *alertMessage;

// 现实多个action的alert和sheet
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)setAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage;
- (void)addAlertActonWithTitle:(NSString *)title alertType:(HLAlertType)alertType aciton:(HLAlertAction)action;
- (void)addSheetActonWithTitle:(NSString *)title sheetType:(HLAlertType)sheetType aciton:(HLAlertAction)action;

// 多个action要调用show
- (void)showAlert;
- (void)showSheet;

// 普通的alert
- (void)showAlertViewWithAlertTitle:(NSString *)title
                       alertMessage:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                        comfirTitle:(NSString *)comfirTitle
                       comfirHandle:(HLAlertAction)comfirhandle
                       cancelHandle:(HLAlertAction)cancelhandle;
// 包含输入框alert
- (void)showAlertViewWithTextFiledAlertTitle:(NSString *)title
                                alertMessage:(NSString *)message
                                 cancelTitle:(NSString *)cancelTitle
                                 comfirTitle:(NSString *)comfirTitle
                             textFieldhandle:(HLAlertTextFiled)textFieldhandle
                                comfirHandle:(HLAlertAction)comfirhandle
                                cancelHandle:(HLAlertAction)cancelhandle;


// 两个sheet
- (void)showSheetViewWithSheetTitle:(NSString *)title
                       sheetMessage:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                        comfirTitle:(NSString *)comfirTitle
                       comfirHandle:(HLAlertAction)comfirhandle
                       cancelHandle:(HLAlertAction)cancelhandle;

// 三个sheet
- (void)showSheetOtherViewWithSheetTitle:(NSString *)title
                            sheetMessage:(NSString *)message
                             cancelTitle:(NSString *)cancelTitle
                              otherTitle:(NSString *)otherTitle
                             comfirTitle:(NSString *)comfirTitle
                            comfirHandle:(HLAlertAction)comfirhandle
                             otherHandle:(HLAlertAction)otherhandle
                            cancelHandle:(HLAlertAction)cancelhandle;


@end

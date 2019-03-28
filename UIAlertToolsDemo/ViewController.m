//
//  ViewController.m
//  UIAlertToolsDemo
//
//  Created by H&L on 2019/3/28.
//  Copyright © 2019 hzsmac. All rights reserved.
//

#import "ViewController.h"
#import "HLAlertTool/HLAlertTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)alert:(id)sender {
    HLAlertTool *alertTool = [[HLAlertTool alloc] init];
    [alertTool showAlertViewWithAlertTitle:@"提示" alertMessage:@"是否确定要取消" cancelTitle:@"取消" comfirTitle:@"确定" comfirHandle:^{
        NSLog(@"确定");
    } cancelHandle:^{
        NSLog(@"取消");
    }];
}

- (IBAction)sheet:(id)sender {
    HLAlertTool *sheetTool = [[HLAlertTool alloc] init];
    [sheetTool showSheetViewWithSheetTitle:@"提示" sheetMessage:@"" cancelTitle:@"取消" comfirTitle:@"确定" comfirHandle:^{
        NSLog(@"确定");
    } cancelHandle:^{
        NSLog(@"取消");
    }];
}

- (IBAction)more:(id)sender {
    HLAlertTool *alertTool = [[HLAlertTool alloc] initWithTitle:@"提示" message:@"删除将不再出现"];
    [alertTool addAlertActonWithTitle:@"取消" alertType:HLAlertTypeCancel aciton:^{
        
    }];
    [alertTool addAlertActonWithTitle:@"确定" alertType:HLAlertTypeDefault aciton:^{
        
    }];
    
    [alertTool addAlertActonWithTitle:@"再想想" alertType:HLAlertTypeDestructive aciton:^{
        
    }];
    [alertTool showAlert];
}

@end

//
//  WebViewController.h
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WebViewControllerWebUrlType) {
    WebViewControllerWebUrlRegisteredType = 0, //注册
    WebViewControllerWebUrlPasswordType = 2//忘记密码
};

@interface WebViewController : BaseViewController
@property (nonatomic, assign) WebViewControllerWebUrlType webUrlType;
@end

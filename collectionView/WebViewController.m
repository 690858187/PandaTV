//
//  WebViewController.m
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "WebViewController.h"
#import "NSObject+Private.h"
#define RegisteredURL @"http://m.panda.tv/mregist"
#define PasswordURL   @"http://m.panda.tv/password_reset"
@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy)   NSString *URL;
@end

@implementation WebViewController

#pragma mark-----life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"注册";
    [self setupView];
    [self layoutUI];
    [self requestData];
    
}

- (void)setupView {
    
    //web view
    self.webView = [UIWebView new];
    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
    switch (self.webUrlType) {
        case WebViewControllerWebUrlRegisteredType:
            self.URL = RegisteredURL;
            break;
        case WebViewControllerWebUrlPasswordType:
            self.URL = PasswordURL;
            break;
            
        default:
            break;
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]];
    [self.webView loadRequest:urlRequest];
}

- (void)layoutUI {
    
    //web view
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark-----Private Method

- (void)requestData {
    
}
@end

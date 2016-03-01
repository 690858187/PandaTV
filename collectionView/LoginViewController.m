//
//  LoginViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextFieldView.h"
#import "WebViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) LoginTextFieldView *phoneView;
@property (nonatomic, strong) LoginTextFieldView *keyView;
@property (nonatomic, strong) UIImageView *phoneImg;
@property (nonatomic, strong) UIImageView *keyImg;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *registeredLable;
@property (nonatomic, strong) UILabel *forgetPasswordLable;
@property (nonatomic, copy)   NSString *phone;
@property (nonatomic, copy)   NSString *key;
@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    [self setupView];
    [self layoutUI];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [self.view addGestureRecognizer:tap];
    
}

- (void)setupView {
    self.phoneView = [[LoginTextFieldView alloc] initWithFrame:CGRectZero ];
    self.phoneView.textField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneView.textField.layer.cornerRadius = 2;
    self.phoneView.textField.placeholder = @"帐号 (请输入你的手机号)";
    self.phoneView.leftImageView.image = [UIImage imageNamed:@"ico_user"];
    self.phoneView.placeholderFont = [UIFont systemFontOfSize:14];
    self.phoneView.placeholderColor = [UIColor grayColor];
    self.phoneView.textField.delegate = self;
    [self.view addSubview:self.phoneView];
    [self.phoneView.textField becomeFirstResponder];
    
    self.keyView = [[LoginTextFieldView alloc] initWithFrame:CGRectZero];
    self.keyView.textField.delegate = self;
    self.keyView.textField.layer.cornerRadius = 2;
    self.keyView.textField.placeholder = @"密码";
    self.keyView.leftImageView.image = [UIImage imageNamed:@"ico_key"];
    self.keyView.textField.leftViewMode = UITextFieldViewModeAlways;
    self.keyView.placeholderFont = [UIFont systemFontOfSize:14];
    self.keyView.placeholderColor = [UIColor grayColor];
    self.keyView.textField.secureTextEntry = YES;
    [self.view addSubview:self.keyView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[Common imageWithColor:kBackColor_tone size:CGSizeMake(100, 40)] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    
    self.registeredLable = [UILabel new];
    self.registeredLable.text = @"立即注册 >";
    self.registeredLable.userInteractionEnabled = YES;
    self.registeredLable.textColor = kBackColor_tone;
    self.registeredLable.textAlignment = NSTextAlignmentLeft;
    self.registeredLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.registeredLable];
    
    
    self.forgetPasswordLable = [UILabel new];
    self.forgetPasswordLable.text = @"忘记密码";
    self.forgetPasswordLable.userInteractionEnabled = YES;
    self.forgetPasswordLable.textColor = kBackColor_tone;
    self.forgetPasswordLable.textAlignment = NSTextAlignmentRight;
    self.forgetPasswordLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.forgetPasswordLable];
    
    UITapGestureRecognizer *registeredTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registeredTapAction:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
   // registeredTap.cancelsTouchesInView = NO;
     UITapGestureRecognizer *forgetPasswordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPasswordTappAction:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
   // forgetPasswordTap.cancelsTouchesInView = NO;
    [self.registeredLable addGestureRecognizer:registeredTap];
    [self.forgetPasswordLable addGestureRecognizer:forgetPasswordTap];
    
}

- (void)layoutUI {
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(30);
        make.width.equalTo(@(screen_width-40));
        make.height.equalTo(@40);
    }];

    [self.keyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.width.height.equalTo(self.phoneView);
        make.top.equalTo(self.phoneView.mas_bottom).offset(20);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneView);
        make.height.equalTo(@40);
        make.top.equalTo(self.keyView.mas_bottom).offset(25);
    }];
    
    [self.registeredLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(15);
    }];
    
    [self.forgetPasswordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.height.equalTo(self.registeredLable);
        make.right.equalTo(self.loginBtn);
    }];
    
}

#pragma mark-----Private Method

- (void)loginBtnAction:(UIButton *)sender {
    self.phone = self.phoneView.textField.text;
    self.key   = self.keyView.textField.text;
    //判断手机号和密码是否为空
    if (!StringHasValue(self.phone)||!StringHasValue(self.key )) {
        
        [Common messageWithString:@"用户名和密码不能为空"];
        return;
    }
//    //判断手机号格式是否正确
//    LoginParam *param = [LoginParam paramWithAccount:self.phone Password:self.key];
//    [LoginHttp LoginWithSearchParam:param HomeDataBlcok:^(LoginData *data, NSError *error) {
//        
//    }];
    
    
}

- (void)registeredTapAction:(UITapGestureRecognizer *)sender {
    WebViewController *vc = [WebViewController new];
    vc.webUrlType = WebViewControllerWebUrlRegisteredType;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetPasswordTappAction:(UITapGestureRecognizer *)sender {
    WebViewController *vc = [WebViewController new];
    vc.webUrlType = WebViewControllerWebUrlPasswordType;
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)tapAction:(UITapGestureRecognizer *)sender {
//    [self.view endEditing:YES];
//}

#pragma mark-----UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (self.phoneView.textField==textField) {
        self.phoneView.layer.borderWidth  = 2.5;
        self.phoneView.layer.borderColor = kColor(248, 132, 16, 1).CGColor;
        self.keyView.layer.borderWidth  = 1.5;
        self.keyView.layer.borderColor  = kColor(241, 241, 241, 1).CGColor ;
    }
    else
    {
        self.keyView.layer.borderWidth  = 2.5;
        self.keyView.layer.borderColor  = kColor(248, 132, 16, 1).CGColor;
        self.phoneView.layer.borderWidth  = 1.5;
        self.phoneView.layer.borderColor  =  kColor(241, 241, 241, 1).CGColor;
    }
}


@end

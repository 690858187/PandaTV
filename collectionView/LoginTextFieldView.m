//
//  FLYLoginTextField.m
//  tnar
//
//  Created by 1234 on 15/12/10.
//  Copyright © 2015年 彭侃. All rights reserved.
//

#import "LoginTextFieldView.h"

@implementation LoginTextFieldView
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
    
    self.leftImageView = [[UIImageView alloc] init];
    [self addSubview:self.leftImageView];
    self.textField = [[UITextField alloc] init];
    [self addSubview:self.textField];
    
    
    
    
}
- (void)layoutUI {
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(15);
        make.right.equalTo(self);
        make.height.top.equalTo(self);
        
    }];
    
}
#pragma mark----getting&&setting
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self.textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont  = placeholderFont;
    [self.textField setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    
    
}

@end

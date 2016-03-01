//
//  FLYLoginTextField.h
//  tnar
//
//  Created by 1234 on 15/12/10.
//  Copyright © 2015年 彭侃. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextFieldView : UIView
@property (nonatomic,strong)UIColor *placeholderColor;
@property (nonatomic,strong)UIFont *placeholderFont;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIImageView *leftImageView;
- (id)initWithFrame:(CGRect)frame;
@end

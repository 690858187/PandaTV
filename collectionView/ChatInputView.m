//
//  chatInputView.m
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "ChatInputView.h"

@interface ChatInputView ()
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIButton *addChatBtn;
@end

@implementation ChatInputView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame ]) {
        self.backgroundColor = [UIColor whiteColor];
        [self regNotification];
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor =kColor(230, 230, 230, 1);
    [self addSubview:self.lineView];
    
    self.chatTF = [UITextField new];
    self.chatTF.placeholder = @"说点什么吧!";
    [self.chatTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [self.chatTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.chatTF.layer.borderWidth = 0.5;
    self.chatTF.layer.borderColor = kColor(200, 200, 200, 1).CGColor;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 10, 0)];
    leftView.backgroundColor = [UIColor clearColor];
    self.chatTF.leftView = leftView;
    self.chatTF.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:self.chatTF];
    
    self.addChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addChatBtn setBackgroundImage:[UIImage imageNamed:@"gift_switch_btn_normal" ] forState:UIControlStateNormal];
    [self.addChatBtn addTarget:self action:@selector(addChatBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addChatBtn];
    
}
- (void)layoutUI {
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@0.5);
        
    }];
    
    [self.chatTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView).offset(15);
        make.right.equalTo(self.addChatBtn.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.7);
    }];
    
    [self.addChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.chatTF.mas_right).offset(15);
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.top.equalTo(self.chatTF);
        make.height.equalTo(self.chatTF);
        make.width.equalTo(self.addChatBtn.mas_height);
    }];
}
#pragma mark-----Private Method
- (void)addChatBtnAction:(UIButton *)sender {
    if (self.addChatBlock) {
        self.addChatBlock();
    }
}
#pragma mark - reg & unreg notification

- (void)regNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)unregNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - notification handler

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    
    CGRect inputFieldRect = self.frame;
    inputFieldRect.origin.y += yOffset;
    [UIView animateWithDuration:duration animations:^{
        self.frame = inputFieldRect;
    }];
}

@end

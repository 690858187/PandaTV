//
//  JZYTextView.m
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "JZYTextView.h"

@interface JZYTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation JZYTextView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:14];
        [self setupView];
        [self layoutUI];
        [self addObserver];
    }
    return self;
}

- (void)setupView {
    
    //placeholder Label
    self.placeholderLabel = [UILabel new];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
    self.placeholderLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.placeholderLabel];
    
    
}

- (void)layoutUI {
    
    //placeholder Label
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self).offset(6);
        make.top.equalTo(self).offset(8);
    }];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    //根据文字计算高度
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    self.placeholderLabel.height= [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self).offset(8);
        make.height.equalTo(@([self getPlaceholderHeightWithPlaceholder:self.placeholder]));
    }];
    
} 


- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidChange) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark-----Private Method

- (void)TextDidChange {
    self.placeholderLabel.hidden = self.hasText;
}

- (CGFloat )getPlaceholderHeightWithPlaceholder:(NSString *)placeholder {
    
    CGSize maxSize =CGSizeMake(self.width,MAXFLOAT);
    return [placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
}
#pragma mark-----getting&&setting

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

@end

//
//  LiveTextDetailTableViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/19.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LiveTextDetailTableViewCell.h"

@interface LiveTextDetailTableViewCell ()

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation LiveTextDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kTable_BackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
    self.titleLable = [UILabel new];
    self.titleLable.text = @"直播详情";
    self.titleLable.textColor = kColor(57, 57, 57, 1);
    self.titleLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLable];
    
    self.textView = [UITextView new];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = kColor(143, 143, 143, 143);
    [self.contentView addSubview:self.textView];
    
}
- (void)layoutUI {
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.height.equalTo(@20);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.titleLable.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
}
- (void)updateUIWithTextStr:(NSString *)textStr {
    self.textView.text = textStr;
}
@end

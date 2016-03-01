//
//  BaseSearchNavigationBar.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "BaseSearchNavigationBar.h"

@interface BaseSearchNavigationBar ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIButton *leftBtn;

@end

@implementation BaseSearchNavigationBar
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.barTintColor = kBackColor_tone;
        self.barStyle = UIBarStyleBlackOpaque;
        [self setupView];
        [self layoutUI];
        
    }
    return self;
}
- (void)setupView {
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.text = @"搜索房间ID,主播名称";
    self.searchBar.delegate = self;
    [self addSubview:self.searchBar];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"ico_return_normal"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
    
}
- (void)layoutUI {
    
    [self.searchBar  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(@(64/2-20));
        make.left.equalTo(self.leftBtn.mas_right);
        make.right.equalTo(self.rightBtn.mas_left);
        make.height.equalTo(@40);
        
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar);
        make.width.height.equalTo(@25);
        make.right.equalTo(self).offset(-10);
        
    }];
    
    
}
#pragma mark-----Private Method
- (void)rightBtnAction:(UIButton *)sender {
    
}
- (void)leftBtnAction:(UIButton *)sender {
    
}
@end

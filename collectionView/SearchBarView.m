//
//  SearchBarView.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SearchBarView.h"

@interface SearchBarView ()<UISearchBarDelegate>

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;
//@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation SearchBarView
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kBackColor_tone;
        [self setupView];
        [self layoutUI];
        
    }
    return self;
}
- (void)setupView {
    
    self.searchBar = [[UISearchBar alloc] init];
   // self.searchBar.barStyle = UIBarStyleBlackOpaque;
    self.searchBar.placeholder = @"搜索房间ID,主播名称";
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.delegate = self;
    //self.searchBar.showsBookmarkButton = YES;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    [self addSubview:self.searchBar];
  // 去除搜索框背景色
    for (UIView *view in self.searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[self.rightBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self addSubview:self.rightBtn];
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setImage:[UIImage imageNamed:@"ico_return_normal"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
    
//    self.rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
//    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.rightImageView.userInteractionEnabled = YES;
//    [self addSubview:self.rightImageView];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBtnAction)];
//    [self.rightImageView addGestureRecognizer:tap];
    
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
        make.width.height.equalTo(@44);
        make.right.equalTo(self).offset(-5);
        
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBar);
        make.width.equalTo(@(10*3));
        make.height.equalTo(@(18*3));
        make.left.equalTo(self).offset(5);
        
    }];
    
    
}
#pragma mark-----Private Method
- (void)rightBtnAction:(UIButton *)sender {
    if (self.searchBlock) {
        self.searchBlock();
    }
}
- (void)leftBtnAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
    
}
#pragma mark-----UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (!StringHasValue(searchText)) {
        
        if (self.searchClearBlock) {
            self.searchClearBlock();
        }
    }
    
}
@end

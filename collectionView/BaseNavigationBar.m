//
//  BaseNavigationBar.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "BaseNavigationBar.h"

@interface BaseNavigationBar ()
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIButton *rightBtn;

@end
@implementation BaseNavigationBar
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.barTintColor = kBackColor_tone;
        self.barStyle = UIBarStyleBlackOpaque;
        [self setupView];
        [self layoutUI];
        self.hasRightBtn = YES;
        self.hasBackImg = YES;
        
    }
    return self;
}
- (void)setupView {
    

    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_logo"]];
    [self addSubview:self.bgImageView];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
    
    

}
- (void)layoutUI {
    
    [self.bgImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(@(64/2-20));
        make.width.equalTo(@(166/2));
        make.height.equalTo(@(71/2));
        
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.width.height.equalTo(@44);
        make.right.equalTo(self).offset(-5);
        
    }];

    
}
- (void)rightBtnAction:(UIButton *)sender {
    
    if (self.sBlcok) {
        
        self.sBlcok();
    }
    
    
}
#pragma mark----getting&&setting
- (void)setHasBackImg:(BOOL)hasBackImg {
    _hasBackImg = hasBackImg;
    self.bgImageView.hidden = !hasBackImg;
}
- (void)setHasRightBtn:(BOOL)hasRightBtn {
    _hasRightBtn = hasRightBtn;
    self.rightBtn.hidden = !hasRightBtn;
}

@end

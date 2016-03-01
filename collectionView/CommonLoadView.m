//
//  CommonLoadView.m
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "CommonLoadView.h"

@interface CommonLoadView ()
@property (nonatomic,strong)UIImageView *loadImgView;
@property (nonatomic,strong)UILabel *loadLable;
@property (nonatomic,strong)UILabel *loadFailLable;
@end

@implementation CommonLoadView
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
    self.loadImgView = [UIImageView new];
    self.loadImgView.userInteractionEnabled = YES;
    [self addSubview:self.loadImgView];
    
    self.loadLable = [UILabel new];
    self.loadLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.loadLable];
    
    self.loadFailLable = [UILabel new];
    self.loadFailLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.loadFailLable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    [self.loadImgView addGestureRecognizer:tap];
    [self.loadFailLable addGestureRecognizer:tap];
    [self.loadLable addGestureRecognizer:tap];
    
}
- (void)layoutUI {
    
    [self.loadImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.width.equalTo(@100);
        make.height.equalTo(@110);
    }];
    [self.loadLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.top.equalTo(self.loadImgView.mas_bottom);
        make.height.equalTo(@30);
    }];
    [self.loadFailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.top.equalTo(self.loadLable.mas_bottom);
        make.height.equalTo(@30);
    }];
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    if (self.loadingFailBlock) {
        self.loadingFailBlock();
    }
}
#pragma mark-----getting&&setting
- (void)setLoadingSuccful:(BOOL)loadingSuccful {
    _loadingSuccful = loadingSuccful;
    if (loadingSuccful) {
        self.loadImgView.image = [UIImage imageNamed:@"panda1"];
        self.loadLable.text = @"努力加载中";
    }
    else
    {
        self.loadImgView.image = [UIImage imageNamed:@"panda2"];
        self.loadLable.text = @"页面加载失败";
        self.loadFailLable.text = @"请点击页面刷新";
    }
}
@end

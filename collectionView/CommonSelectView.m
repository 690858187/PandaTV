//
//  CommonSelectView.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "CommonSelectView.h"
#define BASE_TAG 100
@interface CommonSelectView ()
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *backLineView;
@property (nonatomic,strong)NSMutableArray *btnGroupArr;
@property (nonatomic,strong)UIButton *lastBtn;
@property (nonatomic,strong)UIButton *lastClickBtn;
@end

@implementation CommonSelectView
- (id)initWithFrame:(CGRect)frame TitleGroupArr:(NSArray *)titleGroupArr
{
    
    if (self = [super initWithFrame:frame]) {
       
        self.btnGroupArr = [[NSMutableArray alloc] init];
        self.titleGroupArr = [[NSMutableArray alloc] initWithArray:titleGroupArr];
        self.backgroundColor = kTable_BackColor;
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    int i=0;
    for (NSString *str in self.titleGroupArr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:str forState:UIControlStateNormal];
        if (i==0) {
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.lastClickBtn = btn;
        }
        else
        {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = BASE_TAG+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%f",self.frame.size.height);

        [self addSubview:btn];
        [self.btnGroupArr addObject:btn];
        i++;
    }
    self.backLineView = [[UIView alloc] init];
    self.backLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.backLineView];

    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBackColor_tone;
    [self addSubview:self.lineView];
    
}
- (void)layoutUI {
    
    __block int i=0;
    for (UIButton *btn in self.btnGroupArr) {
        if (self.lastBtn) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.top.bottom.equalTo(self);
                make.height.equalTo(self);
                make.top.equalTo(self);
                make.width.equalTo(@(screen_width/self.btnGroupArr.count));
                make.left.equalTo(self.lastBtn.mas_right);
            }];
        }
        else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.top.bottom.equalTo(self);
                make.height.equalTo(self);
                make.top.equalTo(self);
                make.width.equalTo(@(screen_width/self.btnGroupArr.count));
                make.left.equalTo(self);
            }];
            
        }
        self.lastBtn = btn;
        i++;
    }
    
    [self.backLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@2.5);
        make.width.equalTo(@(screen_width/self.btnGroupArr.count));
    }];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
#pragma mark----Private Method
- (void)btnAction:(UIButton *)sender {
    
    for (UIButton *btn in self.btnGroupArr) {
        
        if (btn==sender) {
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    self.lineView.transform = CGAffineTransformMakeTranslation((sender.tag-BASE_TAG)*(screen_width/self.btnGroupArr.count), 0);
    
    if (self.selectTypeBlcok) {
        
        self.selectTypeBlcok(sender.tag-BASE_TAG);
    }
    self.lastClickBtn = sender;
}
#pragma mark-----getting&&setting
- (void)setCurrentPage:(NSInteger )currentPage {
    _currentPage = currentPage;
    self.lineView.transform = CGAffineTransformMakeTranslation(currentPage*(screen_width/self.btnGroupArr.count), 0);
    for (UIButton *btn in self.btnGroupArr) {
        
        if (btn.tag ==currentPage+BASE_TAG) {
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }

}

@end

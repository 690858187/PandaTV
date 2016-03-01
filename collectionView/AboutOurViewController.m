//
//  AboutOurViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "AboutOurViewController.h"

@interface AboutOurViewController ()
@property (nonatomic,strong)UIImageView *img;
@end

@implementation AboutOurViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    [self setupView];
    [self layoutUI];
}
- (void)setupView {
    self.img = [[UIImageView alloc] init];
    self.img.image = [UIImage imageNamed:@"aboutbg"];
    [self.view addSubview:self.img];
}
- (void)layoutUI {
   [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
       
       
       make.centerX.equalTo(self.view);
       make.top.equalTo(self.view).offset(150/2);
       make.width.equalTo(@(151));
       make.height.equalTo(self.img.mas_width).multipliedBy(0.5);
   }];
}
@end

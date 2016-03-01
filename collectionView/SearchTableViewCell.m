//
//  SearchTableViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/12.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SearchTableViewCell.h"

@interface SearchTableViewCell ()


@property (nonatomic,strong)UIImageView *imgView;

@end

@implementation SearchTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
    
}
- (void)setupView {
    
    self.titleLable = [UILabel new];
    [self.contentView addSubview:self.titleLable];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.clipsToBounds = YES;
    self.imgView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgViewAction:)];
    [self.imgView addGestureRecognizer:tap];
}
- (void)layoutUI {
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.equalTo(@200);
        make.height.equalTo(self.contentView);
        
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@13);
        make.centerX.equalTo(self.mas_right).offset(-25);
    }];
    
}
#pragma mark-----Private Method
- (void)clickImgViewAction:(UITapGestureRecognizer *)tap {
    if (self.clearBlock) {
        self.clearBlock(self);
    }
    
}
#pragma mark-----getting&&setting
- (void)setImg:(UIImage *)img {
    _img = img;
    self.imgView.image = img;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = title;
}
- (void)setImgSize:(CGSize )imgSize {
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(imgSize.width));
    }];
}
@end

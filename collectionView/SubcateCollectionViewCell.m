//
//  SubcateCollectionViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SubcateCollectionViewCell.h"
#define kSpaching 5
@interface SubcateCollectionViewCell()

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLable;
@end

@implementation SubcateCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
    self.backView = [[UIImageView alloc] init];
    self.backView.layer.cornerRadius =2;
    self.backView.layer.borderWidth = 0.3;
    [self.contentView addSubview:self.backView];
    
    self.imageView = [[UIImageView alloc] init];
    [self.backView addSubview:self.imageView];
    
    self.titleLable = [UILabel new];
    self.titleLable.textColor = [UIColor blackColor];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.titleLable];

}
- (void)layoutUI {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kSpaching);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(kSpaching);
        make.right.equalTo(self.contentView).offset(-kSpaching/2);

    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.backView);
        make.height.equalTo(self.backView).multipliedBy(0.8);
        
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self.backView);
        make.height.equalTo(self.backView).multipliedBy(0.2);
        
    }];

    
}
- (void)updateUIWith:(SubcateData *)data {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[data.img clearURL]] placeholderImage:[UIImage imageNamed:@"defaultcolumnbg"]];
    self.titleLable.text = data.cname;
    
}
- (void)updateUIFrame:(NSIndexPath *)indexPath {
    
    switch (indexPath.row%3) {
        case 0:
        {
            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kSpaching);
                make.bottom.equalTo(self.contentView);
                make.top.equalTo(self.contentView).offset(kSpaching);
                make.right.equalTo(self.contentView).offset(-kSpaching/2);
            }];
        }
            break;
        case 1:
        {
            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kSpaching/2);
                make.bottom.equalTo(self.contentView);
                make.top.equalTo(self.contentView).offset(kSpaching);
                make.right.equalTo(self.contentView).offset(-kSpaching/2);
            }];
        }
            break;
        case 2:
        {
            [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kSpaching/2);
                make.bottom.equalTo(self.contentView);
                make.top.equalTo(self.contentView).offset(kSpaching);
                make.right.equalTo(self.contentView).offset(-kSpaching);
            }];
        }
            break;
            
        default:
            break;
    }
    
}
@end

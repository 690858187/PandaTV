//
//  CollectionViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/4.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#define kSpaching 5
@interface HomeCollectionViewCell ()

@property (nonatomic,strong)YYAnimatedImageView *backImageView;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)UIImageView *userImageView;
@property (nonatomic,strong)UILabel *numWatcherLable;
@property (nonatomic,strong)UIView *blackBackView;
@end

@implementation HomeCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
    self.backImageView = [[YYAnimatedImageView alloc] init];
    self.backImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.backImageView];
    
    self.titleLable = [UILabel new];
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.font = [UIFont systemFontOfSize:13];
    [self.backImageView addSubview:self.titleLable];
    
    
    self.blackBackView = [[UIView alloc] init];
    //[Common iOS8BlurEffect:self.blackBackView];
    self.blackBackView.backgroundColor = kColor(20, 20, 20, 0.8);
    [self.backImageView addSubview:self.blackBackView];
    
    
    self.nameLable = [UILabel new];
    self.nameLable.textColor = kColor(230, 230, 230, 1);
    self.nameLable.font = [UIFont systemFontOfSize:10];
    [self.backImageView addSubview:self.nameLable];
    
    self.userImageView = [[UIImageView alloc] init];
    self.userImageView.image = [UIImage imageNamed:@"people"];
    [self addSubview:self.userImageView];
    
    self.numWatcherLable = [UILabel new];
    self.numWatcherLable.textColor = kColor(23, 102, 234, 1);
    self.numWatcherLable.textAlignment = NSTextAlignmentRight;
    self.numWatcherLable.font = [UIFont systemFontOfSize:10];
    [self.backImageView addSubview:self.numWatcherLable];
    
}
- (void)layoutUI {
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self).offset(kSpaching);
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-kSpaching/2);
        
        
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.nameLable.mas_top);
        make.height.equalTo(@15);
    }];
    
    [self.blackBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.backImageView);
        make.top.equalTo(self.nameLable);
        make.bottom.equalTo(self);
    }];
    
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(self.titleLable);
        make.bottom.equalTo(self);
    
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.equalTo(@10);
        make.right.equalTo(self.numWatcherLable.mas_left);
        make.bottom.equalTo(self).offset(-3);
        
    }];
    
    [self.numWatcherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.titleLable);
        make.width.equalTo(@40);
        make.height.equalTo(self.titleLable);
        make.bottom.equalTo(self.nameLable);
        
    }];
    
}
- (void)updateUIWithHomeData:(HomeHotLiveData *)data {
    
    [self.backImageView setImageWithURL:[NSURL URLWithString:[data.bigimg clearURL]] placeholder:[UIImage imageNamed:@"defaultlivebg"]];
    self.titleLable.text = data.title;
    self.nameLable.text = data.nickname;
    NSString *WatcherStr;
    if (data.person_num>=10000) {
        
        WatcherStr = [NSString stringWithFormat:@"%.1f万",(float)data.person_num/10000];
    }
    else {
        WatcherStr = [NSString stringWithFormat:@"%.f",(float)data.person_num];
    }
    self.numWatcherLable.text = [NSString stringWithFormat:@"%@",WatcherStr];

}
- (void)updateUIWithLiveData:(LiveData *)data {
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[data.pictures.img clearURL]] placeholderImage:[UIImage imageNamed:@"defaultlivebg"]];
    self.titleLable.text = data.name;
    self.nameLable.text = data.userinfo.nickName;
    NSString *WatcherStr;
    if (data.person_num>=10000) {
        
        WatcherStr = [NSString stringWithFormat:@"%.1f万",(float)data.person_num/10000];
    }
    else {
          WatcherStr = [NSString stringWithFormat:@"%.f",(float)data.person_num];
    }
    self.numWatcherLable.text = [NSString stringWithFormat:@"%@",WatcherStr];

    
}
- (void)updateUIWithSearchLiveData:(SearchDatas *)data {
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[data.pictures.img clearURL]] placeholderImage:[UIImage imageNamed:@"defaultlivebg"]];
    self.titleLable.text = data.name;
    self.nameLable.text = data.nickname;
    NSString *WatcherStr;
    if (data.person_num>=10000) {
        
        WatcherStr = [NSString stringWithFormat:@"%.1f万",(float)data.person_num/10000];
    }
    else {
        WatcherStr = [NSString stringWithFormat:@"%.f",(float)data.person_num];
    }
    self.numWatcherLable.text = [NSString stringWithFormat:@"%@",WatcherStr];

}
- (void)updateUIFrame:(NSIndexPath *)indexPath {
    
    if (indexPath.row%2==0) {
       
        [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.equalTo(self).offset(kSpaching);
            make.right.equalTo(self).offset(-kSpaching/2);
            make.bottom.equalTo(self);
        }];
    }
    else
    {
        [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(kSpaching/2);
            make.top.equalTo(self).offset(kSpaching);
            make.right.equalTo(self).offset(-kSpaching);
            make.bottom.equalTo(self);
        }];
    }
}
@end

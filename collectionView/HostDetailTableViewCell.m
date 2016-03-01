//
//  HostDetailTableViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "HostDetailTableViewCell.h"

@interface HostDetailTableViewCell ()

@property (nonatomic,strong)UIImageView *photoImgView;
@property (nonatomic,strong)UIImageView *liveStateImgView;
@property (nonatomic,strong)UILabel *liveStateLable;
@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)UILabel *liveNameLable;
@property (nonatomic,strong)UILabel *liverDetailLable;
@property (nonatomic,strong)UIView *lineView;
@end

@implementation HostDetailTableViewCell

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
   
    self.photoImgView = [UIImageView new];
    self.photoImgView.layer.cornerRadius = 60/2;
    self.photoImgView.clipsToBounds = YES;
    [self.contentView addSubview:self.photoImgView];
    
    self.nameLable = [UILabel new];
    self.nameLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLable];
    
    self.liveStateImgView = [UIImageView new];
    self.liveStateImgView.image = [UIImage imageNamed:@"host_playing"];
    [self.contentView addSubview:self.liveStateImgView];
    
    self.liveStateLable = [UILabel new];
    self.liveStateLable.text = @"正在直播";
    self.liveStateLable.font = [UIFont systemFontOfSize:9];
    self.liveStateLable.textAlignment = NSTextAlignmentCenter;
    self.liveStateLable.textColor = [UIColor whiteColor];
    [self.liveStateLable sizeToFit];
    [self.contentView addSubview:self.liveStateLable];

    
    self.liveNameLable = [UILabel new];
    self.liveNameLable.font = [UIFont systemFontOfSize:12];
    self.liveNameLable.textColor = kBackColor_tone;
    [self.contentView addSubview:self.liveNameLable];
    
    self.liverDetailLable = [UILabel new];
    self.liverDetailLable.font = [UIFont systemFontOfSize:13];
    self.liverDetailLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.liverDetailLable];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = kColor(213, 213, 213, 1);
    [self.contentView addSubview:self.lineView];
}

- (void)layoutUI {
    
    [self.photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.height.equalTo(@60);
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.photoImgView.mas_right).offset(10);
        make.top.equalTo(self.photoImgView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@20);
    }];
    
    [self.liveStateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.nameLable);
        make.width.equalTo(@42);
        make.height.equalTo(@19);
        make.top.equalTo(self.nameLable.mas_bottom);
    }];
    
    [self.liveStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.liveStateImgView);
        make.bottom.equalTo(self.liveStateImgView);
        make.height.equalTo(@12);
    }];
    
    [self.liveStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@12);
        make.left.right.bottom.equalTo(self.liveStateImgView);
    }];

    
    [self.liveNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.liveStateImgView.mas_right).offset(5);
        make.right.equalTo(self.contentView);
        make.height.equalTo(self.liveStateLable);
        make.centerY.equalTo(self.liveStateLable);
    }];
    
    [self.liverDetailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.nameLable);
        make.height.equalTo(@20);
        make.top.equalTo(self.liveNameLable.mas_bottom).offset(5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
    
}

- (void)updateUIWith:(LiveRoomData *)data {

    [self.photoImgView sd_setImageWithURL:[NSURL URLWithString: [data.info.hostinfo.avatar clearURL]] placeholderImage:nil];
    self.nameLable.text = data.info.hostinfo.name;
    self.liveNameLable.text = data.info.roominfo.name;
    [data.info.hostinfo.bamboos floatValue];
    
    NSString *fans, *bamboos;
    if ([data.info.roominfo.fans floatValue]>=10000) {
        fans = [NSString stringWithFormat:@"%.1f万",[data.info.roominfo.fans floatValue]/10000];
    }
    else {
        fans = data.info.roominfo.fans;
    }
    
    if ([data.info.hostinfo.bamboos floatValue]>=10000) {
        bamboos = [NSString stringWithFormat:@"%.1f",[data.info.hostinfo.bamboos floatValue]/10000];
    }
    else {
        bamboos = data.info.hostinfo.bamboos;
    }
    self.liverDetailLable.text = [NSString stringWithFormat:@"粉丝: %@  身高: %@m",
                                  fans,bamboos];
    
}
@end

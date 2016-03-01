//
//  MyTableViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)NSArray *titleGroupArr;
@property (nonatomic,strong)NSArray *imgGroupArr;
@property (nonatomic,strong)UISwitch *switchView;
@end

@implementation MyTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        [self layoutUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setupView {

    self.img = [[UIImageView alloc] init];
    [self.contentView addSubview:self.img];
    
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLable];
    
    self.switchView = [[UISwitch alloc] init];
    self.switchView.onTintColor =  kColor(55, 164,233, 1);
    [self.switchView setOn:YES];
    [self.switchView addTarget:self action:@selector(switchViewAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchView];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = kColor(200, 200, 200, 1);
    [self.contentView addSubview:self.lineView];

}
- (void)layoutUI {
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(5);
        make.right.equalTo(self.contentView);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}
- (void)updateUIWithIndexPath:(NSIndexPath *)indexPath {
    self.switchView.hidden = YES;
    if (indexPath.row==1||indexPath.row==4) {
        self.contentView.backgroundColor = kColor(240, 240, 240, 1);
        self.img.hidden = YES;
        self.titleLable.hidden = YES;
        
    }else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.img.image = [UIImage imageNamed:self.imgGroupArr[indexPath.row]];
        self.titleLable.text = self.titleGroupArr[indexPath.row];
        if (indexPath.row!=0) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else {
            self.switchView.hidden = NO;
        }
    }
}
#pragma mark-----private method
- (void)switchViewAction:(UISwitch *)sender {
    
}
#pragma mark-----getting&&setting
- (NSArray *)titleGroupArr {
    if (!_titleGroupArr) {
        _titleGroupArr = [NSArray arrayWithObjects:@"开播提醒",@"",@"我的关注",@"我的任务",@"",@"意见反馈",@"关于我们", nil];
    }
    return _titleGroupArr;
}
- (NSArray *)imgGroupArr {
    if (!_imgGroupArr) {
        _imgGroupArr = [NSArray arrayWithObjects:@"broadcast_remind",@"",@"my_attention",@"ico_task",@"",@"feed_back",@"about", nil];
    }
    return _imgGroupArr;

}
@end

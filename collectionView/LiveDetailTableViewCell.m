//
//  LiveDetailTableViewCell.m
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LiveDetailTableViewCell.h"

@interface LiveDetailTableViewCell ()

@property (nonatomic,strong)UILabel *titleLable;


@end

@implementation LiveDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kColor(238, 238, 238, 1);
        [self setupView];
        [self layoutUI];
    }
    return self;
}
- (void)setupView {
    
}
- (void)layoutUI {
    
}
@end

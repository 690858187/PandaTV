//
//  SearchTableViewCell.h
//  collectionView
//
//  Created by 1234 on 15/12/12.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTableViewCellDelegate <NSObject>

@end

@interface SearchTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImage *img;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,assign)CGSize imgSize;
@property (nonatomic,copy) void(^clearBlock)(SearchTableViewCell *cell);
@property (nonatomic,weak)id<SearchTableViewCellDelegate>delegate;
@end

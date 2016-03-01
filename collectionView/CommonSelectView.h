//
//  CommonSelectView.h
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonSelectView : UIView
@property (nonatomic,strong)NSArray *titleGroupArr;
/** 设置可移动lineView的transform*/
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,copy)void (^selectTypeBlcok)(NSInteger selectType);
- (id)initWithFrame:(CGRect)frame
      TitleGroupArr:(NSArray *)titleGroupArr;
@end

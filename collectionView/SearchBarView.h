//
//  SearchBarView.h
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBarView : UIView
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,copy)void(^backBlock)();
@property (nonatomic,copy)void(^searchBlock)();
@property (nonatomic,copy)void(^searchClearBlock)();
@end

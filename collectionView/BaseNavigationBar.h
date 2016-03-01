//
//  BaseNavigationBar.h
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseNavigationBar : UINavigationBar
/**是否显示右键*/
@property (nonatomic,assign)BOOL hasRightBtn;
/**是否显示背景图片*/
@property (nonatomic,assign)BOOL hasBackImg;

@property (nonatomic,assign)BOOL isSearch;
@property (nonatomic,copy)void (^sBlcok)();
- (id)initWithFrame:(CGRect)frame;
@end

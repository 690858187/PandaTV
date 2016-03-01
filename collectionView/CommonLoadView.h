//
//  CommonLoadView.h
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonLoadView : UIView
@property (nonatomic,copy)void(^loadingFailBlock)();
@property (nonatomic,assign)BOOL loadingSuccful;
@end

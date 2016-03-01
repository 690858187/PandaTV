//
//  Comment.h
//  collectionView
//
//  Created by 1234 on 15/12/10.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonLoadView.h"

@interface Common : NSObject
@property (nonatomic,strong)CommonLoadView *loadView;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (void)messageWithString:(NSString *)aString;
+ (void)clearTableFootView:(UITableView *)tableView;
/**
 *  添加模糊背景色
 *
 *  @param view 添加背景色的控件
 */
+ (void)iOS8BlurEffect:(UIView *)view;
- (void)showLoadingViewInSubView:(UIView *)subView;
- (void)hideLoadingView;

// 判断字符串是否有值
#define StringHasValue(str)            (str && [str isKindOfClass:[NSString class]] && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)
/**
 *  获取分享房间URL网址
 *
 *  @param str 房间编号
 *
 *  @return 分享房间URL网址
 */
#define ShareURLRoomWithID(str)        [NSString stringWithFormat:@"http://panda.tv/room?roomid=%@",str]
@end

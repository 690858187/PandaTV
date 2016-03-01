//
//  NSDictionary+Private.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Private)
/**
 *  返回错误代码
 *
 *  @return 返回错误代码数字
 */
- (NSInteger)error;
/**
 *  返回错误代码描述
 *
 *  @return 返回错误信息描述
 */
- (NSString *)errmsg;
/**
 *  返回信息数组
 *
 *  @return 返回信息数组
 */
- (NSArray *)data;
/**
 *  未知信息
 *
 *  @return 未知信息
 */
- (NSString *)authseq;

#pragma mark-----提交返回信息返回数据解析头
/**
 *  返回错误代码
 *
 *  @return 返回错误代码数字:200:成功 601:失败
 */
- (NSInteger)status;
/**
 *  返回错误代码描述
 *
 *  @return 返回错误信息描述
 */
- (NSString *)error_msg;
@end

//
//  NSObject+Private.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id resposeObject);
typedef void(^failBlock)(NSError *error);
@interface NSObject (Private)
/**
 *  检查网络
 *
 *  @return 检查是否有网络
 */
+ (BOOL)hasNetWork;
/**
 *  请求数据API
 *
 *  @param param   请求参数
 *  @param success 请求成功返回数据
 *  @param error   请求失败返回数据
 */
+ (void)requestDataWithParam:(NSDictionary *)param
                         Url:(NSString *)url
                     success:(successBlock)success
                        fail:(failBlock)fail;
/**
 *  请求数据API
 *
 *  @param param   请求参数
 *  @param success 请求成功返回数据
 *  @param error   请求失败返回数据
 */
+ (void)commitContentWithParam:(NSDictionary *)param
                         Url:(NSString *)url
                     success:(successBlock)success
                        fail:(failBlock)fail;
@end

//
//  NSDictionary+Private.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "NSDictionary+Private.h"

@implementation NSDictionary (Private)
- (NSInteger)error {
    
   return [[self objectForKey:@"errno"] integerValue];
}

- (NSString *)errmsg {
    
    return [self objectForKey:@"errmsg"];
}

- (NSArray *)data {
    
    return [self objectForKey:@"data"];
}

- (NSString *)authseq {
    
    return [self objectForKey:@"authseq"];
}

#pragma mark-----提交返回信息返回数据解析头

- (NSInteger)status {
  return [[self objectForKey:@"status"] integerValue];
}

- (NSString *)error_msg {
    return [self objectForKey:@"error_msg"];
}

@end

//
//  NSObject+Private.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "NSObject+Private.h"
#import "PandaBaseNetManager.h"
#import "NSDictionary+Private.h"
@implementation NSObject (Private)
+ (BOOL)hasNetWork {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    __block isHasNetWork;
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status!=AFNetworkReachabilityStatusNotReachable) {
            
            isHasNetWork = YES;
        }else {
            isHasNetWork = NO;
        }
        
    }];
    
    return isHasNetWork;
}
+ (void)requestDataWithParam:(NSDictionary *)param
                         Url:(NSString *)url
                     success:(successBlock)success
                        fail:(failBlock)fail {
    
    if (![self hasNetWork]) {
        
//        NSError* error = [NSError errorWithDomain:@"无网络连接" code:0 userInfo:nil];
//        fail(error);
//        return;
    }
    [[PandaBaseNetManager share].http POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *result = responseObject;
        NSArray *arr = [result data];
        if (result) {
            
            if (arr.count) {
                success([result data]);

            }
            else {
                NSError *error = [[NSError alloc] initWithDomain:[result errmsg] code:[result error] userInfo:nil];
                fail(error);

            }
        }
       else
       {
        NSError *error = [[NSError alloc] initWithDomain:[result errmsg] code:[result error] userInfo:nil];
        fail(error);
       }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail(error);
    }];
    
}

+ (void)commitContentWithParam:(NSDictionary *)param
                           Url:(NSString *)url
                       success:(successBlock)success
                          fail:(failBlock)fail {
    if (![self hasNetWork]) {
        
        //        NSError* error = [NSError errorWithDomain:@"无网络连接" code:0 userInfo:nil];
        //        fail(error);
        //        return;
    }
    [[PandaBaseNetManager share].http POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *result = responseObject;
        NSArray *arr = [result data];
        if (result) {
            
            if (arr.count) {
                success([result data]);
                
            }
            else {
                NSError *error = [[NSError alloc] initWithDomain:[result error_msg] code:[result status] userInfo:nil];
                fail(error);
                
            }
        }
        else
        {
            NSError *error = [[NSError alloc] initWithDomain:[result error_msg] code:[result status] userInfo:nil];
            fail(error);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail(error);
    }];
    

}
@end

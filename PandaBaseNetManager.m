//
//  PandaBaseNetManager.m
//  collectionView
//
//  Created by 1234 on 15/12/4.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "PandaBaseNetManager.h"

@interface PandaBaseNetManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager* httpManager;

@end

@implementation PandaBaseNetManager
+(PandaBaseNetManager *)share {
    
    static dispatch_once_t onceToken;
    static PandaBaseNetManager *netManager;
    dispatch_once(&onceToken, ^{
        netManager = [[PandaBaseNetManager alloc] init];
        netManager.httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//        netManager.httpManager.responseSerializer.acceptableContentTypes = [netManager.httpManager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    
    });
    return netManager;
}
- (void)cancelHttps {

    [self.http.operationQueue cancelAllOperations];
}
- (AFHTTPRequestOperationManager*)http {
//    self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    //默认返回JSON类型（可以不写）
//    self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [self.httpManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [self.httpManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    return self.httpManager;
}
@end

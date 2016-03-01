//
//  PandaBaseNetManager.h
//  collectionView
//
//  Created by 1234 on 15/12/4.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
@interface PandaBaseNetManager : NSObject

@property (nonatomic,strong)AFHTTPRequestOperationManager *http;

+(PandaBaseNetManager *)share;

- (void)cancelHttps;
@end

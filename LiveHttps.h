//
//  LiveHttps.h
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LiveData;
@class LiveParam;
typedef void(^LiveDataBlock)(NSArray *result,NSError *error);

@interface LiveHttps : NSObject

+(void)requestDataWithHomeParam:(LiveParam *)param
                  HomeDataBlcok:(LiveDataBlock)success;

@end

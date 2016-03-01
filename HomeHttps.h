//
//  HomeHttps.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeTopParam;
@class HomeTopData;

@class HomeHotLiveParam;
@class HomeHotLiveData;

typedef void(^HomeDataBlcok)(NSArray *result,NSError *error);
typedef void(^HomeHotLiveDataBlcok)(NSArray *result,NSError *error);

@interface HomeHttps : NSObject

@end

@interface HomeTopHttps :NSObject

+(void)requestDataWithHomeParam:(HomeTopParam *)param
                  HomeDataBlcok:(HomeDataBlcok)success;

@end


@interface HomeHotLiveHttps : NSObject

+(void)requestDataWithHomeParam:(HomeHotLiveParam *)param
                  HomeDataBlcok:(HomeHotLiveDataBlcok)success;

@end
//
//  SearchHttps.h
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchParams;
@class SearchDatas;
typedef void(^SearchDataBlock)(NSArray *result,NSError *error);

@interface SearchHttps : NSObject

+(void)requestDataWithSearchParam:(SearchParams *)param
                  HomeDataBlcok:(SearchDataBlock)success;


@end

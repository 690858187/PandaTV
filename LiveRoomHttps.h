//
//  LiveRoomHttps.h
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveRoomData;
@class LiveRoomParams;
typedef void(^LiveRoomDataBlock)(LiveRoomData *result,NSError *error);
@interface LiveRoomHttps : NSObject
+(void)requestDataWithLiveRoomParam:(LiveRoomParams *)param
                  HomeDataBlcok:(LiveRoomDataBlock)success;
@end

//
//  LiveRoomParams.m
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LiveRoomParams.h"

@implementation LiveRoomParams
+ (id)paramsWithRoomid:(NSInteger)roomid {

    LiveRoomParams *params = [[LiveRoomParams alloc] init];
    params.type = @"json";
    params.roomid = roomid;
    return params;
}
@end

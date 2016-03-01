//
//  LiveRoomHttps.m
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LiveRoomHttps.h"
#define LiveRoomURL @"http://api.m.panda.tv/ajax_get_liveroom_baseinfo?"
@implementation LiveRoomHttps
+(void)requestDataWithLiveRoomParam:(LiveRoomParams *)param
                  HomeDataBlcok:(LiveRoomDataBlock)success {
    [self requestDataWithParam:[param mj_keyValues] Url:LiveRoomURL success:^(id resposeObject) {
        NSDictionary *resopsedic = resposeObject;
        if (resopsedic) {
            LiveRoomData *result = [LiveRoomData mj_objectWithKeyValues:resopsedic];
            success(result,nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];

    
}
@end

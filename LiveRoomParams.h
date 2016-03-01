//
//  LiveRoomParams.h
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveRoomParams : NSObject
@property (nonatomic,assign)NSInteger roomid;
@property (nonatomic,copy)NSString *type;
+ (id)paramsWithRoomid:(NSInteger)roomid;
@end

//
//  LiveRoomDatas.h
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//
@class LiveRoomInfo;
@class LiveRoomHostinfo;
@class LiveRoomRoominfo;
@class LiveRoomVideoinfo;
@class LiveRoomUserinfo;
@class LiveRoomInfo;
@class LiveRoomStream_addr;

#import <Foundation/Foundation.h>
/**
 *  1
 */
@interface LiveRoomData : NSObject
@property (nonatomic,strong)LiveRoomInfo        *info;
@end

/**
 *  2
 */
@interface LiveRoomInfo : NSObject
@property (nonatomic,strong)LiveRoomHostinfo    *hostinfo;
@property (nonatomic,strong)LiveRoomRoominfo    *roominfo;
@property (nonatomic,strong)LiveRoomVideoinfo   *videoinfo;
@property (nonatomic,strong)LiveRoomUserinfo    *userinfo;
@end
/**
 *  3
 */
@interface LiveRoomHostinfo : NSObject
@property (nonatomic,copy)NSString *rid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *bamboos;
@end
/**
 *  3
 */
@interface LiveRoomRoominfo : NSObject
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *classification;
@property (nonatomic,copy)NSString *cate;
@property (nonatomic,copy)NSString *bulletin;
@property (nonatomic,copy)NSString *details;
@property (nonatomic,copy)NSString *person_num;
@property (nonatomic,copy)NSString *fans;
@property (nonatomic,copy)NSString *remind_content;
@property (nonatomic,copy)NSString *remind_time;
@property (nonatomic,copy)NSString *remind_status;
@end
/**
 *  3
 */
@interface LiveRoomVideoinfo : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *stream_addr;
@property (nonatomic,copy)NSString *room_key;
@property (nonatomic,copy)NSString *plflag;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *sign;
@property (nonatomic,copy)NSString *ts;
@end
/**
 *  4
 */
@interface LiveRoomStream_addr : NSObject
@property (nonatomic,copy)NSString *HD;
@property (nonatomic,copy)NSString *OD;
@property (nonatomic,copy)NSString *SD;
@end
/**
 *  3
 */
@interface LiveRoomUserinfo : NSObject
@property (nonatomic,copy)NSString *rid;
@property (nonatomic,copy)NSString *identity;
@property (nonatomic,copy)NSString *is_followed;
@property (nonatomic,copy)NSString *sp_identity;
@end
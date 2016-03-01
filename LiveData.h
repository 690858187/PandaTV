//
//  LiveData.h
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LivePicture;
@class LiveUserinfo;
@interface LiveData : NSObject
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString *ver;
@property (nonatomic,copy)NSString *createtime;
@property (nonatomic,copy)NSString *updatetime;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *hostid;
@property (nonatomic,assign)NSInteger person_num;
@property (nonatomic,copy)NSString *announcement;
@property (nonatomic,copy)NSString *classification;
@property (nonatomic,strong)LivePicture *pictures;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *duration;
@property (nonatomic,copy)NSString *schedule;
@property (nonatomic,copy)NSString *remind_switch;
@property (nonatomic,copy)NSString *remind_content;
@property (nonatomic,copy)NSString *level;
@property (nonatomic,copy)NSString *stream_status;
@property (nonatomic,copy)NSString *classify_switch;
@property (nonatomic,copy)NSString *reliable;
@property (nonatomic,copy)NSString *fans;
@property (nonatomic,strong)LiveUserinfo *userinfo;
//@property (nonatomic,copy)NSString *bigimg;
//@property (nonatomic,copy)NSString *nickname;
//@property (nonatomic,copy)NSString *title;
//@property (nonatomic,copy)NSString *notice;
//@property (nonatomic,copy)NSString *details;
//@property (nonatomic,copy)NSString *order;
//@property (nonatomic,copy)NSString *url;

@end

@interface LivePicture : NSObject

@property (nonatomic,copy)NSString *img;

@end

@interface LiveUserinfo : NSObject

@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *rid;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *userName;

@end
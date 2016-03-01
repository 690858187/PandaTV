//
//  HomeData.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeData : NSObject

@end

@interface HomeTopData : NSObject
@property (nonatomic,assign)NSInteger roomid;
@property (nonatomic,copy)NSString *qcm_img;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *qcmsint1;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *room_key;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *notice;
@property (nonatomic,copy)NSString *classification;
@property (nonatomic,copy)NSString *person_num;
@property (nonatomic,copy)NSString *details;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *schedule;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *stream_status;
@property (nonatomic,copy)NSString *order;
@property (nonatomic,copy)NSString *bigimg;
@property (nonatomic,copy)NSString *stream_addr;
@property (nonatomic,copy)NSString *plflag;

@end


@interface HomeHotLiveData : NSObject
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *ver;
@property (nonatomic,copy)NSString *createtime;
@property (nonatomic,copy)NSString *updatetime;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *hostid;
@property (nonatomic,assign)NSInteger person_num;
@property (nonatomic,copy)NSString *announcement;
@property (nonatomic,copy)NSString *classification;
@property (nonatomic,copy)NSString *pictures;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *duration;
@property (nonatomic,copy)NSString *schedule;
@property (nonatomic,copy)NSString *remind_switch;
@property (nonatomic,copy)NSString *remind_content;
@property (nonatomic,copy)NSString *stream_status;
@property (nonatomic,copy)NSString *classify_switch;
@property (nonatomic,copy)NSString *reliable;
@property (nonatomic,copy)NSString *fans;
@property (nonatomic,assign)NSInteger roomid;
@property (nonatomic,copy)NSString *bigimg;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *notice;
@property (nonatomic,copy)NSString *details;
@property (nonatomic,copy)NSString *order;
@property (nonatomic,copy)NSString *url;

@end

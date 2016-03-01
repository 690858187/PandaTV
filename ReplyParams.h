//
//  ReplyParams.h
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyParam : NSObject
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *access_subtype;
@property (nonatomic, copy)NSString *package;
@property (nonatomic, copy)NSString *appkey;
@property (nonatomic, copy)NSString *app_version;
@property (nonatomic, copy)NSString *mac;
@property (nonatomic, copy)NSString *resolution;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *protocol_version;
@property (nonatomic, copy)NSString *version_code;
@property (nonatomic, copy)NSString *device_model;
@property (nonatomic, copy)NSString *timezone;
@property (nonatomic, copy)NSString *carrier;
@property (nonatomic, copy)NSString *os;
@property (nonatomic, copy)NSString *cpu;
@property (nonatomic, copy)NSString *sdk_version;
@property (nonatomic, copy)NSString *device_id;
@property (nonatomic, copy)NSString *access;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *os_version;
@property (nonatomic, copy)NSString *idmd5;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *sdk_type;
@property (nonatomic, copy)NSString *device_uuid;
@property (nonatomic, copy)NSString *reply_id;
@property (nonatomic, copy)NSString *feedback_id;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *channel;
+ (id)paramWithContent:(NSString *)content;
@end

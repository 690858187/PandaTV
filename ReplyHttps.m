//
//  ReplyHttps.m
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "ReplyHttps.h"
#define ReplyHttpsUrl @"http://fb.umeng.com/api/v2/feedback/reply/new"
@implementation ReplyHttps
+(void)replyCommentWithSearchParam:(ReplyParam *)param
                     HomeDataBlcok:(ReplyDataDataBlock)success {
    [self requestDataWithParam:[param mj_keyValues] Url:ReplyHttpsUrl success:^(id resposeObject) {
        if (resposeObject) {
            success([ReplyData mj_objectWithKeyValues:resposeObject],nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];

}
@end

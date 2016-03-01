//
//  ReplyHttps.h
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReplyData;
@class ReplyParam;
typedef void(^ReplyDataDataBlock)(ReplyData *data,NSError *error);

@interface ReplyHttps : NSObject
+(void)replyCommentWithSearchParam:(ReplyParam *)param
                    HomeDataBlcok:(ReplyDataDataBlock)success;
@end

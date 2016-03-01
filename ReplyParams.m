//
//  ReplyParams.m
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "ReplyParams.h"

@implementation ReplyParam
+ (id)paramWithContent:(NSString *)content {
    ReplyParam *param = [[ReplyParam alloc] init];
    param.uid = @"65cdfeb6c922c95e78d3f4bca26cb326";
    param.access_subtype = @"Unknown";
    param.package = @"com.panda.videoliveplatform";
    param.appkey = @"55e55378e0f55af8d3000a41";
    param.app_version = @"1.0.0.1092";
    param.mac = @"c0:ee:fb:04:45:2f";
    param.resolution = @"1080*1920";
    param.type = @"user_reply";
    param.protocol_version = @"2.0";
    param.version_code = @"1092";
    param.device_model = @"A0001";
    param.timezone = @"8";
    param.carrier = @"China Mobile";
    param.os = @"iOS";
    param.cpu = @"ARMv7 Processor rev 1 (v7l)";
    param.sdk_version = @"5.4.0.20150727";
    param.device_id = @"864587026823766";
    param.access = @"Wi-Fi";
    param.country = @"CN";
    param.os_version = @"4.4.4";
    param.idmd5 = @"65cdfeb6c922c95e78d3f4bca26cb326";
    param.content = content;
    param.sdk_type = @"iOS";
    param.device_uuid = @"8752c656-489b-4752-947d-f185ca6377cf";
    param.reply_id = @"R0411a2c7-e73e-49cc-8ea5-7897f28b6eca";
    param.feedback_id = @"C5f74a39b-4abe-44c4-98e3-fec38e870a2c";
    param.language = @"zh";
    param.channel = @"baidushouzhu";
    return param;
}
@end

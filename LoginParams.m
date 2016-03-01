//
//  LoginParams.m
//  PandaTV
//
//  Created by 1234 on 15/12/25.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LoginParams.h"
#import "NSString+MD5HexDigest.h"
#import <CommonCrypto/CommonDigest.h>
@implementation LoginParam
+ (id)paramWithAccount:(NSString *)account
                Password:(NSString *)password {
    LoginParam *param = [[LoginParam alloc] init];
    param.account = @"15827535160";
    param.password = [self md5:[NSString stringWithFormat:@"%@123456",password]];
    param.channel = @"1";
    param.authseq = @"d59508697f3dd1419a9aa4d0d5062225";
    param.__version = @"1.0.0.1092";
    param.__plat    = @"android";
    return param;
}

+ (NSString *)md5:(NSString*)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


@end

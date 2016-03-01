//
//  LoginHttps.m
//  PandaTV
//
//  Created by 1234 on 15/12/25.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LoginHttps.h"

#define LoginURL @"http://u.panda.tv/ajax_login?account=15827535160&password=Gjo8%2FuVjaj%2FDdH3XxhZsUw%3D%3D%0A&channel=1&authseq=d59508697f3dd1419a9aa4d0d5062225&__version=1.0.0.1092&__plat=android"

@implementation LoginHttp
+(void)LoginWithSearchParam:(LoginParam *)param
                     HomeDataBlcok:(LoginDataBlock)success {
    [self requestDataWithParam:[param mj_keyValues] Url:LoginURL success:^(id resposeObject) {
        NSDictionary *resopseArr = resposeObject;
        if (resposeObject) {
            success([LoginData mj_objectWithKeyValues:resposeObject],nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];

    
}
@end

//
//  LoginHttps.h
//  PandaTV
//
//  Created by 1234 on 15/12/25.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginParam;
@class LoginData;
typedef void(^LoginDataBlock)(LoginData *data,NSError *error);

#pragma mark-----用户登陆

@interface LoginHttp : NSObject
+(void)LoginWithSearchParam:(LoginParam *)param
                     HomeDataBlcok:(LoginDataBlock)success;
@end

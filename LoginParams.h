//
//  LoginParams.h
//  PandaTV
//
//  Created by 1234 on 15/12/25.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParam : NSObject
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *authseq;
@property (nonatomic, copy) NSString *__version;
@property (nonatomic, copy) NSString *__plat;
+ (id)paramWithAccount:(NSString *)account
                Password:(NSString *)password;
@end

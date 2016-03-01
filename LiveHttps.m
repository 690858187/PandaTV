//
//  LiveHttps.m
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LiveHttps.h"
#define LiveURL @"http://api.m.panda.tv/ajax_live_lists?__version=1.0.0.1084&__plat=android&pageno=1&pagenum=10&status=2&order=person_num"
@implementation LiveHttps
+(void)requestDataWithHomeParam:(LiveParam *)param
                  HomeDataBlcok:(LiveDataBlock)success {
    [self requestDataWithParam:[param mj_keyValues] Url:LiveURL success:^(id resposeObject) {
        NSDictionary *resopseArr = resposeObject;
        if (resposeObject) {
            NSArray *arr = [LiveData mj_objectArrayWithKeyValuesArray:[resopseArr objectForKey:@"items"]];
            success(arr,nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];

}
@end

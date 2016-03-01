//
//  SearchHttps.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SearchHttps.h"
#define SearchURL @"http://api.m.panda.tv/ajax_search?__version=1.0.0.1092&__plat=android"
@implementation SearchHttps
+(void)requestDataWithSearchParam:(SearchParams *)param
                  HomeDataBlcok:(SearchDataBlock)success {
    [self requestDataWithParam:[param mj_keyValues] Url:SearchURL success:^(id resposeObject) {
        NSDictionary *resopseArr = resposeObject;
        if (resposeObject) {
            NSArray *arr = [SearchDatas mj_objectArrayWithKeyValuesArray:[resopseArr objectForKey:@"items"]];
            NSLog(@"%@",[resopseArr objectForKey:@"total"]);
            NSLog(@"%@",[resopseArr objectForKey:@"items"]);
            success(arr,nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];

}
@end

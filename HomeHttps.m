//
//  HomeHttps.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//
//广告URL
#define kAdUrl @"http://api.m.panda.tv/ajax_rmd_ads_get?__version=1.0.0.1072&__plat=android"
//热门URL
#define kHotUrl @"http://api.m.panda.tv/ajax_rmd_hotlives_get?__version=1.0.0.1072&__plat=android"
#import "HomeHttps.h"

@implementation HomeHttps

@end

@implementation HomeTopHttps
+(void)requestDataWithHomeParam:(HomeParam *)param
                  HomeDataBlcok:(HomeDataBlcok)success {
    
    [self requestDataWithParam:[param mj_keyValues] Url:kAdUrl success:^(id resposeObject) {
       
      
        
        if (resposeObject) {
            
            NSArray *arr = [HomeTopData mj_objectArrayWithKeyValuesArray:resposeObject];
            success(arr,nil);
        }
        
    } fail:^(NSError *error) {
       
        success(nil,error);
    }];
    
}
@end

@implementation HomeHotLiveHttps
+(void)requestDataWithHomeParam:(HomeHotLiveParam *)param
                    HomeDataBlcok:(HomeHotLiveDataBlcok)success {
    [self requestDataWithParam:[param mj_keyValues] Url:kHotUrl success:^(id resposeObject) {
        
        if (resposeObject) {
            
            NSArray *arr = [HomeHotLiveData mj_objectArrayWithKeyValuesArray:resposeObject];
            success (arr,nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];
}

@end
//
//  SubcateHttps.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SubcateHttps.h"
#define  SubcateURL   @"http://api.m.panda.tv/ajax_get_all_subcate?__plat=android&__version=1.0.0.1072"
@implementation SubcateHttps
+(void)requestDataWithHomeParam:(HomeTopParam *)param
                  HomeDataBlcok:(SubcateDataBlock)success {
    
    [self requestDataWithParam:[param mj_keyValues] Url:SubcateURL success:^(id resposeObject) {
        
        if (resposeObject) {
            NSArray *arr = [SubcateData mj_objectArrayWithKeyValuesArray:resposeObject];
            success(arr,nil);
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];
    
}
@end

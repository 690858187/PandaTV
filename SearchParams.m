//
//  SearchParams.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "SearchParams.h"

@implementation SearchParams
+(id)paramsWithKeyword:(NSString *)keyword
                  Status:(NSInteger)status
                Pageno:(NSInteger)pageno
               Pagenum:(NSInteger)pagenum{
    
    SearchParams *param = [[SearchParams alloc] init];
    param.keyword = keyword;
    param.status = status;
    param.pagenum = pagenum;
    param.pageno = pageno;
    return param;
}
@end

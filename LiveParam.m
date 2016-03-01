//
//  LiveParam.m
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "LiveParam.h"

@implementation LiveParam
+(id)paramWithPageno:(NSInteger)pageno
             Pagenum:(NSInteger)pagenum
              status:(NSInteger)status {
    LiveParam *param = [[LiveParam alloc] init];
    param.pageno = pageno;
    param.pagenum = pagenum;
    param.status = status;
    return param;
}
+(id)paramWithCate:(NSString *)cate
            Pageno:(NSInteger)pageno
           Pagenum:(NSInteger)pagenum
            status:(NSInteger)status {
    LiveParam *param = [[LiveParam alloc] init];
    param.pageno = pageno;
    param.pagenum = pagenum;
    param.status = status;
    param.cate = cate;
    return param;
}
@end

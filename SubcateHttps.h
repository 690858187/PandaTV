//
//  SubcateHttps.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SubcateData;
@class SubcateParam;

typedef void(^SubcateDataBlock)(NSArray *result,NSError *error);
@interface SubcateHttps : NSObject
+(void)requestDataWithHomeParam:(SubcateParam *)param
                  HomeDataBlcok:(SubcateDataBlock)success;
@end

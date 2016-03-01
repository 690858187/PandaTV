//
//  SearchParams.h
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchParams : NSObject
@property (nonatomic,copy)NSString *keyword;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger pageno;
@property (nonatomic,assign)NSInteger pagenum;
+(id)paramsWithKeyword:(NSString *)keyword
              Status:(NSInteger)status
                Pageno:(NSInteger)pageno
               Pagenum:(NSInteger)pagenum;
@end

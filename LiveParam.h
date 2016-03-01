//
//  LiveParam.h
//  collectionView
//
//  Created by 1234 on 15/12/8.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveParam : NSObject
@property (nonatomic,copy)NSString *cate;
@property (nonatomic,assign)NSInteger pageno;
@property (nonatomic,assign)NSInteger pagenum;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,copy)NSString *order;
/**
 *  直播列表
 *
 *  @param pageno  页码
 *  @param pagenum 一页显示个数
 *  @param status  直播状态:2(直播)3:(未直播)
 *
 *  @return nil
 */
+(id)paramWithPageno:(NSInteger)pageno
             Pagenum:(NSInteger)pagenum
              status:(NSInteger)status;
/**
 *  分类直播列表
 *
 *  @param cate    分类标识
 *  @param pageno  页码
 *  @param pagenum 一页显示个数
 *  @param status  直播状态:2(直播)3:(未直播)
 *
 *  @return nil
 */
+(id)paramWithCate:(NSString *)cate
            Pageno:(NSInteger)pageno
            Pagenum:(NSInteger)pagenum
            status:(NSInteger)status;

@end

//
//  SearchData.h
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchPictures;
@interface SearchDatas : NSObject
@property (nonatomic,copy)NSString *md5;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *roomid;
@property (nonatomic,copy)NSString *hostid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *style;
//@property (nonatomic,copy)NSString * class;
@property (nonatomic,copy)NSString *classification;
@property (nonatomic,assign)NSInteger person_num;
@property (nonatomic,copy)NSString *bamboos;
@property (nonatomic,assign)NSInteger fans;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,strong)SearchPictures *pictures;
@property (nonatomic,copy)NSString *updatetime;
@property (nonatomic,copy)NSString *url_footprint;
@property (nonatomic,copy)NSString *se;

@end

@interface SearchPictures : NSObject
@property (nonatomic,copy)NSString *img;
@end
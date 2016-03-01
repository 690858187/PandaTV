//
//  CollectionViewCell.h
//  collectionView
//
//  Created by 1234 on 15/12/4.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeHotLiveData;
@class LiveData;
@class SearchDatas;
@interface HomeCollectionViewCell : UICollectionViewCell
- (id)initWithFrame:(CGRect)frame;
/**
 *  首页
 *
 *  @param data 首页model
 */
- (void)updateUIWithHomeData:(HomeHotLiveData *)data;
/**
 *  直播
 *
 *  @param data 直播model
 */
- (void)updateUIWithLiveData:(LiveData *)data;
- (void)updateUIFrame:(NSIndexPath *)indexPath;
- (void)updateUIWithSearchLiveData:(SearchDatas *)data;
@end

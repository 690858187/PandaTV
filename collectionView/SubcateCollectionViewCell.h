//
//  SubcateCollectionViewCell.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubcateData;
@interface SubcateCollectionViewCell : UICollectionViewCell
- (id)initWithFrame:(CGRect)frame;
- (void)updateUIFrame:(NSIndexPath *)indexPath;
- (void)updateUIWith:(SubcateData *)data;
@end

//
//  Header.h
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#ifndef Header_h
#define Header_h

//RGBa颜色
#define kColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
//背景颜色基调
#define kBackColor_tone kColor(24, 147,231, 1)
#define kSpaching 5
#define screen_height [UIScreen mainScreen].bounds.size.height
#define screen_width  [UIScreen mainScreen].bounds.size.width
#define kTarBar_height 49
#define kNavBar_height 64
#define kTable_BackColor kColor(234, 234, 234, 1)

//友盟appkey
#define UMAppKey @"567a3e03e0f55a3963003f25"
#define APPPushKey @"567a3e03e0f55a3963003f25"


#endif /* Header_h */

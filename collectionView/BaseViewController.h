//
//  BaseVC.h
//  collectionView
//
//  Created by 1234 on 15/12/15.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLoadView.h"
@interface BaseViewController : UIViewController
/**
 *  进入主播房间详情界面
 *
 *  @param roomid 主播房间号
 */
- (void)presentLiveRoomViewControllerWithRoomid:(NSInteger)roomid;
@end

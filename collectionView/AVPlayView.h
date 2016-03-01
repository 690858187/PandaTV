//
//  AVPlayView.h
//  shipin
//
//  Created by 1234 on 15/12/22.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
typedef NS_ENUM(NSInteger, AVPlayViewShowStatus) {
    AVPlayViewShowStatusNormal = 0,          // 默认竖屏
    AVPlayViewShowStatusFull         // 满屏
};

@interface AVPlayView : UIView
/** 页面展示状态：默认：AVPlayViewShowStatusNormal*/
@property (nonatomic, assign) AVPlayViewShowStatus *showStatus;
/** 视频串流地址*/
@property (nonatomic, copy) NSString * URLStr;

@property (nonatomic, strong) AVPlayerItem *playerItem;
/** 分享网址*/
@property (nonatomic, copy) NSString *shareURLStr;

- (id)initWithFrame:(CGRect)frame
             URLStr:(NSString *)URLStr
     ViewController:(UIViewController *)viewController;

/**
 *  播放视频
 */
- (void)play;

@end

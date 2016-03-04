//
//  AVPlayView.h
//  播放
//
//  Created by 1234 on 16/3/3.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AVPlayView : UIView
/** 改变屏幕大小状态block :(isLarge:确定当前屏幕所处状态)*/
@property (nonatomic, copy) void (^changeStateBlock)(BOOL isLarge);
/**
 *  视频开始播放
 */
- (void)play;
/**
 *  视频停止播放
 */
- (void)pause;
@end

//
//  AVPlayView.m
//  shipin
//
//  Created by 1234 on 15/12/22.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "AVPlayView.h"
#import "AVPlayControlView.h"
@interface AVPlayView ()

@property (nonatomic, strong) AVPlayControlView *playControlView;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) PlayerView *playerView;
/** 控制器*/
@property (nonatomic, strong) UIViewController *superViewController;

@end

@implementation AVPlayView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
        [self addObserver];
        _showStatus = AVPlayViewShowStatusNormal;
    }
    return self;
}

- (void)setupView {
    
    self.playerView = [PlayerView new];
    self.playerItem = [AVPlayerItem  playerItemWithURL:[NSURL URLWithString:@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = self.player;
    [self addSubview:self.playerView];
    [self play];
    
    self.playControlView = [AVPlayControlView new];
    [self addSubview:self.playControlView];
    
    
       
}
- (void)layoutUI {

    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.playControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.playerView);
    }];
    
}

#pragma mark-----addObserver
- (void)addObserver
{
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
}

#pragma mark----- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    AVPlayerItem *playItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        //正在读取播放状态
        if (playItem.status == AVPlayerItemStatusReadyToPlay) {
//            self.playButton.enabled = YES;
            //获取视频播放总长度
            CMTime duration = self.playerItem.duration;
            //转换成秒
            CGFloat totalSecond = duration.value / duration.timescale;
//            //转换成播放时间
//            _totalTime = [self convertTime:totalSecond];
            
            
        }
        //加载播放失败
        else if (playItem.status == AVPlayerItemStatusFailed) {
            
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = playItem.duration;
//        CGFloat totalDuration = CMTimeGetSeconds(duration);
//        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
    
    
    
}


#pragma mark------Common Method

/**
 *  播放器播放
 */

- (void)play {
    
    [self.playerView.player play];
}

- (void)dealloc {
    
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
}

#pragma mark-----getting&&setting

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

@end

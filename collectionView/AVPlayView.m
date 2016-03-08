//
//  AVPlayView.m
//  播放
//
//  Created by 1234 on 16/3/3.
//  Copyright © 2016年 XDBB. All rights reserved.
//
#import "AVPlayView.h"
#import "AVPlayControlView.h"
#import "AVPlayControlFullView.h"
@interface AVPlayView ()<AVPlayerViewControllerDelegate>
{   //当前视频所处状态，默认为非全屏
    BOOL isLarge;
}

@property (nonatomic, strong) AVPlayer *player;
/** */
@property (nonatomic, strong) AVPlayerViewController *playViewVC;

@property (nonatomic, strong) AVPlayControlView *playControlView;
@property (nonatomic, strong) AVPlayControlFullView *playControlFullView;
/** 视频所处视图的固定宽度*/
@property (nonatomic, assign) CGFloat width;
/** 视频所处视图的固定高度*/
@property (nonatomic, assign) CGFloat height;

@end

@implementation AVPlayView

#pragma mark-----life cycle

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
        [self addObserver];
        isLarge = NO;
    }
    return self;
}

#pragma mark-----添加通知

- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenFull) name:LIVE_FULL_SCREEN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenNoFull) name:LIVE_NO_FULL_SCREEN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenFullNormal) name:LIVE_FULL_SCREEN_NORMAL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenNoFullRoating) name:LIVE_FULL_SCREEN_ROTATING object:nil];
};


- (void)setupView {
    
    [self addSubview:self.playViewVC.view];
    
    self.playControlView = [AVPlayControlView new];
    __weak AVPlayView *weakSelf = self;
    self.playControlView.changeStatusBlock = ^(BOOL isControlLarge){
        if (weakSelf.changeStateBlock) {
            weakSelf.changeStateBlock(!isControlLarge);
        }
    };
    [self addSubview:self.playControlView];
    
    self.playControlFullView = [AVPlayControlFullView new];
    self.playControlFullView.hidden = YES;
    [self addSubview:self.playControlFullView];
    self.playControlFullView.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)layoutUI {
    [self.playControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.playControlFullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(screen_width));
        make.width.equalTo(@(screen_height));
        make.center.equalTo(self);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playViewVC.view.frame = self.bounds;
    [self.playControlFullView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(screen_width));
        make.width.equalTo(@(screen_height));
        make.center.equalTo(self);
    }];
}

#pragma mark-----Private Method

#pragma mark-----Public Method

- (void)play {
    [self.playViewVC.player play];
}

- (void)pause {
    [self.playViewVC.player pause];
}

#pragma mark-----NotificationCenter

- (void)changeScreenFull {
    self.playControlView.hidden = YES;
    self.playControlFullView.hidden = NO;
}

- (void)changeScreenNoFull {
    self.playControlView.hidden = NO;
    self.playControlFullView.hidden = YES;
}

- (void)changeScreenFullNormal {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.playControlFullView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }];
}

- (void)changeScreenNoFullRoating {
    [UIView animateWithDuration:0.5 animations:^{
        self.playControlFullView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }];

    
}

#pragma mark-----getting&&setting

- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithURL:[NSURL URLWithString:AVHttp_1]];
    }
    return _player;
}

- (AVPlayerViewController *)playViewVC {
    if (!_playViewVC) {
        _playViewVC = [[AVPlayerViewController alloc] init];
        _playViewVC.player = self.player;
        _playViewVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _playViewVC.allowsPictureInPicturePlayback = NO;//是否允许画中画播放
        _playViewVC.delegate = self;
        _playViewVC.showsPlaybackControls = NO;
    }
    return _playViewVC;
}
@end

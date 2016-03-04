//
//  AVPlayControlView.m
//  PandaTV
//
//  Created by 1234 on 16/1/18.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "AVPlayControlView.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#define STAY_BTN_STATUS_TIME 3.0f
@interface AVPlayControlView ()<UMSocialUIDelegate>
{
    BOOL btnStatus;         //按钮状态 YES：默认显示3秒后消失
    BOOL animationFinish;    //记录按钮动画是否完成
    BOOL isControlLarge;
}
/** 返回*/
@property (nonatomic, strong) UIButton *backButton;
/** 分享*/
@property (nonatomic, strong) UIButton *shareButton;
/** 人数*/
@property (nonatomic, strong) UIButton *peopleNumButton;
/** 播放器状态*/
@property (nonatomic, strong) UIButton *playViewStatusButton;

@end


@implementation AVPlayControlView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor clearColor];
        btnStatus = YES;
        animationFinish = NO;
        isControlLarge = NO;
        [self setupView];
        [self layoutUI];
        [self starAnimation];
    }
    return self;
}

- (void)setupView {

    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearViewTapAction:)];
    [self addGestureRecognizer:tap];
    
    NSArray *btnNormalGroupArr = [NSArray arrayWithObjects:@"btn_return_normal",@"btn_share_normal",@"",@"btn_full_screen_normal", nil];
    NSArray *btnHoverGroupArr = [NSArray arrayWithObjects:@"btn_return_hover",@"btn_share_hover",@"",@"btn_full_screen_hover", nil];
    
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:btnNormalGroupArr[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:btnHoverGroupArr[i]] forState:UIControlStateHighlighted];
        [self addSubview:button];
        
        switch (i) {
            case 0:
                self.backButton = button;
                [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                self.shareButton = button;
                [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                self.peopleNumButton = button;
                [button addTarget:self action:@selector(watchPeople:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                self.playViewStatusButton = button;
                [button addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
    }
}

- (void)layoutUI {
    
    CGFloat spaching = 15.0f;
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@35);
        make.top.equalTo(self).offset(spaching);
        make.left.equalTo(self).offset(spaching);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.backButton);
        make.top.equalTo(self).offset(spaching);
        make.right.equalTo(self).offset(-spaching);
    }];
    
    [self.peopleNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.backButton);
        make.bottom.equalTo(self).offset(-spaching);
        make.left.equalTo(self.backButton);
    }];
    
    [self.playViewStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.backButton);
        make.bottom.equalTo(self).offset(-spaching);
        make.right.equalTo(self.shareButton);
    }];
}


#pragma mark-----Private Method

- (void)back:(UIButton *)sender {
    
    [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)share:(UIButton *)sender {
    
    [UMSocialQQHandler setSupportWebView:NO];
    NSArray *shareName = [NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ, nil];
    [UMSocialSnsService presentSnsIconSheetView:[self viewController] appKey:UMAppKey shareText:ShareURLRoomWithID(self.shareURLStr) shareImage:nil shareToSnsNames:shareName delegate:self];
}

- (void)watchPeople:(UIButton *)sender {
    
}

- (void)changeStatus:(UIButton *)sender {
    
    if (self.changeStatusBlock) {
        isControlLarge = !isControlLarge;
        self.changeStatusBlock(isControlLarge);
    }
}

/**
 *  按钮显示和消失动画
 */

- (void)starAnimation {
    
    [self performSelector:@selector(clearViewTapAction:) withObject:nil afterDelay:STAY_BTN_STATUS_TIME];
}

/**
 *  背景图点击效果
 *
 *  @param tap 点击手势
 */

- (void)clearViewTapAction:(UITapGestureRecognizer *)tap {
    
    if (isControlLarge) {
        return;
    }
    if (tap) {
        self.backButton.hidden = !self.backButton.hidden;
        self.shareButton.hidden = !self.shareButton.hidden ;
        self.peopleNumButton.hidden = !self.peopleNumButton.hidden;
        self.playViewStatusButton.hidden = !self.playViewStatusButton.hidden;
        
        if (!self.backButton.hidden) {
             [self starAnimation];
        }
        else {
            [[NSObject class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(clearViewTapAction:) object:nil];
        }
    }
    else {
        self.backButton.hidden = YES;
        self.shareButton.hidden = YES;
        self.peopleNumButton.hidden = YES;
        self.playViewStatusButton.hidden = YES;
    }

}

/**
 *  获取视图所在控制器
 *
 *  @return 返回视图所在控制器
 */

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

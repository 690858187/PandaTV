//
//  AVPlayControlFullView.m
//  PandaTV
//
//  Created by 1234 on 16/3/4.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "AVPlayControlFullView.h"

@interface AVPlayControlFullView ()
{   /** 返回按钮*/
    UIButton *backBtn;
    /** 暂停按钮*/
    UIButton *suspendedBtn;
    /** 重复按钮*/
    UIButton *repeatBtn;
}
@end

@implementation AVPlayControlFullView

#pragma mark-----life cycle

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        [self layoutUI];
    }
    return self;
}

- (void)setupView {
    
    self.frame = CGRectMake(0, 0, screen_height, screen_width);
    
    for (int i=0; i<3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"about"] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        switch (i) {
            case 0:
                backBtn = btn;
                [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                suspendedBtn = btn;
                [suspendedBtn addTarget:self action:@selector(suspendedBtnAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                repeatBtn = btn;
                [repeatBtn addTarget:self action:@selector(repeatBtnAction) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
    }

    
}

- (void)layoutUI {
    
}

#pragma mark-----Private Method

- (void)backBtnAction {
    
}

- (void)suspendedBtnAction {
    
}

- (void)repeatBtnAction {
    
    
}

#pragma mark-----Public  Method

#pragma mark-----Notification Method

@end

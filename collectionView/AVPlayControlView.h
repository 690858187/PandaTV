//
//  AVPlayControlView.h
//  PandaTV
//
//  Created by 1234 on 16/1/18.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVPlayControlView : UIView
@property (nonatomic, copy) NSString *shareURLStr;
@property (nonatomic, copy) void (^changeStatusBlock)();
- (id)initWithFrame:(CGRect)frame ;
@end

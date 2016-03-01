//
//  chatInputView.h
//  collectionView
//
//  Created by 1234 on 15/12/14.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatInputView : UIView
@property (nonatomic,copy)void (^addChatBlock)();
@property (nonatomic,strong)UITextField *chatTF;
@end

//
//  BaseVC.m
//  collectionView
//
//  Created by 1234 on 15/12/15.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "BaseViewController.h"
#import "LiveRoomViewController.h"
@interface BaseViewController ()
//@property (nonatomic,strong)CommonLoadView *loadView;
@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib
    
}
- (void)presentLiveRoomViewControllerWithRoomid:(NSInteger)roomid {
    
    LiveRoomViewController *vc = [[LiveRoomViewController alloc] init];
    vc.roomid = roomid;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
#pragma mark-----touchesBegan

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark-----屏幕方向旋转

@end

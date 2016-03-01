//
//  BaseNavigationController.m
//  collectionView
//
//  Created by 1234 on 15/12/9.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "BaseNavigationController.h"
#import "SearchViewController.h"
#import "BaseSearchNavigationBar.h"
@interface BaseNavigationController ()
@end

@implementation BaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor_tone;
    
    [self setupView];
    [self layoutUI];
    
    
}
- (void)setupView {
    
    self.navBar = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    __block BaseNavigationController *weakSelf = self;
    self.navBar.sBlcok = ^(){
        BaseSearchNavigationBar *bar = [[BaseSearchNavigationBar alloc] init];
        
        SearchViewController *vc = [[SearchViewController alloc] init];
        [weakSelf presentViewController:vc animated:YES completion:nil];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[BaseSearchNavigationBar class] toolbarClass:nil];
        
        
        
    };
    [self.view addSubview: self.navBar];
}
- (void)layoutUI {
    
  
}

@end

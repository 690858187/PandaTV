//
//  Comment.m
//  collectionView
//
//  Created by 1234 on 15/12/10.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "Common.h"

@implementation Common
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (void)messageWithString:(NSString *)aString {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:aString
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
     [alertView show];
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:aString preferredStyle:UIAlertControllerStyleActionSheet];
   
}
+ (void)clearTableFootView:(UITableView *)tableView {
    UIView *footView = [UIView new];
    tableView.tableFooterView = footView;
}
+ (void)iOS8BlurEffect:(UIView *)view {
    
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    
    effectView.frame = view.bounds;
    
    [view addSubview:effectView];
}
- (void)showLoadingViewInSubView:(UIView *)subView {
    
    self.loadView = [CommonLoadView new];
    __weak BaseViewController *weakSelf = self;
    self.loadView.loadingFailBlock = ^(){};
    [subView addSubview:self.loadView];
    [self.loadView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(subView);
    }];
}
- (void)hideLoadingView {
    self.loadView.hidden = YES;
}

@end

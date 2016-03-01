//
//  ReplyViewController.m
//  PandaTV
//
//  Created by 1234 on 15/12/24.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "ReplyViewController.h"
#import "JZYTextView.h"
static NSString *const kRemindStr = @"用着不爽吗？来吐槽吧——————";
@interface ReplyViewController ()

@property (nonatomic, strong) JZYTextView *textView;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation ReplyViewController

#pragma mark-----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"意见反馈";
    self.view.backgroundColor = kColor(245, 245, 245, 1);
    [self setupView];
    [self layoutUI];
}

- (void)setupView {
    
    //text view
    self.textView = [JZYTextView new];
    self.textView.placeholder = kRemindStr;
    self.textView.placeholderColor = [UIColor grayColor];
    self.textView.textColor = [UIColor grayColor];
    [self.view addSubview:self.textView];
    
    //commit btn
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn setBackgroundImage:[Common imageWithColor:kBackColor_tone size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];

}

- (void)layoutUI {
    
    //text view
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@150);
    }];
    
    //commit btn
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.height.equalTo(@35);
        make.top.equalTo(self.textView.mas_bottom).offset(30);
    }];
}

#pragma mark-----Private Method

- (void)commitBtnAction:(UIButton *)sender {
    
    ReplyParam *param = [ReplyParam paramWithContent:self.textView.text];
    [ReplyHttps replyCommentWithSearchParam:param HomeDataBlcok:^(ReplyData *data, NSError *error) {
        if (StringHasValue(data.feedback_id)&&data.created_at!=0) {
            
        }else {
            
        }
    }];
}
@end

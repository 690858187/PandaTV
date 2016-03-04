//
//  MyViewController.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"

#import "LoginViewController.h"
#import "ReplyViewController.h"
#import "AboutOurViewController.h"

static NSString *const MyTableViewCellReuseIdentifier = @"MyTableViewCellReuseIdentifier";
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *mainTable;
@end

@implementation MyViewController

#pragma mark-----life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self layoutUI];
}

- (void)setupView {
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.mainTable.dataSource = self;
    self.mainTable.delegate = self;
    self.mainTable.scrollEnabled=NO;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.tableHeaderView = [self creatTableHeaderView];
    [self.mainTable registerClass:[MyTableViewCell class] forCellReuseIdentifier:MyTableViewCellReuseIdentifier];
    [self.view addSubview:self.mainTable];
    
}
- (void)layoutUI {
    
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.top.equalTo(self.view).offset(-20);
    }];
}

#pragma mark----tableHeaderView
- (UIView *)creatTableHeaderView {
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    headView.backgroundColor = kBackColor_tone;
    headView.image = [UIImage imageNamed:@"account_bg"];
    headView.userInteractionEnabled = YES;
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"head_img_normal"];
    img.layer.cornerRadius = 60/2;
    [headView addSubview:img];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"点此登陆";
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLab];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.centerY.equalTo(headView);
        make.width.height.equalTo(@90);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headView);
        make.height.equalTo(@20);
        make.centerX.equalTo(headView);
        make.top.equalTo(img.mas_bottom).offset(15);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewAction)];
    [headView addGestureRecognizer:tap];
    return headView;
}
#pragma mark----UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCellReuseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MyTableViewCellReuseIdentifier];
    }
    [cell updateUIWithIndexPath:indexPath];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==1||indexPath.row==4) {
        return 15;
    }
    else {
        return 44;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0://开播提醒
            
            break;
        case 1://nil
            
            break;
        case 2://我的关注
            
            break;
        case 3://我的任务
            
            break;
        case 4://nil
            
            break;
        case 5://意见反馈
        {
            ReplyViewController *vc = [[ReplyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6://关于我们
        {
            AboutOurViewController *vc = [[AboutOurViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark-----private method
- (void)headViewAction {
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

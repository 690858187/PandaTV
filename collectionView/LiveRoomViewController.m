#import "LiveRoomViewController.h"
#import "CommonSelectView.h"
#import "HostDetailTableViewCell.h"
#import "LiveDetailTableViewCell.h"
#import "LiveTextDetailTableViewCell.h"
#import "chatInputView.h"   //聊天输入框
#import "AVPlayView.h"      //播放页面
#define URL @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"

#define PlayView_Height  screen_width*9/16 //播放页面高度
#define SelectView_Height 40                //选择控制器高度
#define ScrollView_Height screen_height-PlayView_Height-SelectView_Height-20 //主scrollView高度
#define InputView_Height  50                //输入框高度

static NSString *const  kHostDetailTableViewCellReuseIdentifier = @"kHostDetailTableViewCellReuseIdentifier";
static NSString *const  kLiveDetailTableViewCellReuseIdentifier = @"kLiveDetailTableViewCellReuseIdentifier";
static NSString *const  kLiveTextDetailTableViewCellReuseIdentifier = @"kLiveTextDetailTableViewCellReuseIdentifier";
@interface LiveRoomViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)AVPlayView *avPlayView;
@property (nonatomic,strong)CommonSelectView *selectView;
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UITableView *liverDetailTableView;
@property (nonatomic,strong)UITableView *chatTableView;
@property (nonatomic,strong)LiveRoomData *roomData;
@property (nonatomic,strong)ChatInputView *inputView;
@property (nonatomic,assign)UIInterfaceOrientation orientation;
- (void)addChatAction;
@end
@implementation LiveRoomViewController

#pragma mark----addObserver

- (void)addObserver {
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenOrientationNotification) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
   
   
}

#pragma mark----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认为不知道
    self.orientation = UIInterfaceOrientationUnknown;
    [self setupView];
    [self layoutUI];
    [self addObserver];
    [self requestData];
}
- (void)setupView {
    
    
    self.selectView = [[CommonSelectView alloc] initWithFrame:CGRectZero TitleGroupArr:@[@"聊天",@"主播详情"]];
    __weak LiveRoomViewController *weakSelfs = self;
    self.selectView.selectTypeBlcok = ^(NSInteger selectType){
        [weakSelfs.view endEditing:YES];
        [weakSelfs.mainScrollView setContentOffset:CGPointMake(screen_width*selectType, 0) animated:NO];
    };
    [self.view addSubview:self.selectView];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, PlayView_Height+SelectView_Height+20, screen_width,ScrollView_Height)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.backgroundColor = kTable_BackColor;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(screen_width*2, ScrollView_Height);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    
    for (int i=0; i<2; i++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(screen_width*i, 0, screen_width, ScrollView_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        [self.mainScrollView addSubview:tableView];
        switch (i) {
            case 0://聊天
            {
                self.chatTableView = tableView;
            }
                break;
            case 1://主播详情
            {
                
                self.liverDetailTableView = tableView;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [tableView registerClass:[HostDetailTableViewCell class] forCellReuseIdentifier:kHostDetailTableViewCellReuseIdentifier];
                [tableView registerClass:[LiveDetailTableViewCell class] forCellReuseIdentifier:kLiveDetailTableViewCellReuseIdentifier];
                [tableView registerClass:[LiveTextDetailTableViewCell class] forCellReuseIdentifier:kLiveTextDetailTableViewCellReuseIdentifier];
            }
                break;

                
            default:
                break;
        }
        
    }
    
    self.inputView = [[ChatInputView alloc] initWithFrame:CGRectMake(0, self.mainScrollView.height-InputView_Height, screen_width, InputView_Height)];
    self.inputView.addChatBlock = ^(){
    };
    [self.mainScrollView addSubview:self.inputView];
    
    
    self.avPlayView = [[AVPlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16)];
    self.avPlayView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.avPlayView];
    //视频开始播放
    [self.avPlayView play];
    __weak LiveRoomViewController *weakSelf = self;
    self.avPlayView.transform = CGAffineTransformIdentity;
    self.avPlayView.changeStateBlock = ^(BOOL isLarge){
        
        if (isLarge) { //点击全屏化之后才支持屏幕检测，否者不支持
            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.avPlayView.transform = CGAffineTransformMakeRotation(M_PI_2);
            }];
            weakSelf.avPlayView.frame = CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
            weakSelf.mainScrollView.hidden = YES;
            weakSelf.selectView.hidden = YES;
            //此时屏幕的旋转方向是向左
            weakSelf.orientation = UIDeviceOrientationLandscapeLeft;
        }
        else {
            [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
            
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.avPlayView.transform = CGAffineTransformMakeRotation(0);
            }];
            
            weakSelf.avPlayView.frame = CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.width*9/16);
            weakSelf.mainScrollView.hidden = NO;
            weakSelf.selectView.hidden = NO;
            weakSelf.orientation = UIInterfaceOrientationUnknown;
        }
    };


}

- (void)layoutUI {
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(SelectView_Height));
        make.top.equalTo(self.avPlayView.mas_bottom);
    }];
}

#pragma mark-----UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView ==self.chatTableView) {
        
        return nil;
    }
    else {
       
        switch (indexPath.row) {
            case 0:
            {
                 HostDetailTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:kHostDetailTableViewCellReuseIdentifier forIndexPath:indexPath];
                [cell updateUIWith:self.roomData];
                return cell;
            }
                break;
            case 1:
            {
                LiveTextDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLiveTextDetailTableViewCellReuseIdentifier forIndexPath:indexPath];
                [cell updateUIWithTextStr:self.roomData.info.roominfo.bulletin];
                
                return cell;
            }
                break;
                
            default:
                break;
        }
        
    }
    return nil;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView ==self.chatTableView) {
        
        return 0;
    }
    else {
        return 2;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView ==self.chatTableView) {
        
        return 0;
    }
    else {
        switch (indexPath.row) {
            case 0:
            {
                return 100;
            }
                break;
            case 1:
            {
                return 200;
            }
                break;
            default:
                break;
        }
        
       
    }
    return 0;
}
#pragma mark-----Private Method
- (void)requestData {
    
    LiveRoomParams *params = [LiveRoomParams paramsWithRoomid:self.roomid];
    [LiveRoomHttps requestDataWithLiveRoomParam:params HomeDataBlcok:^(LiveRoomData *result, NSError *error) {
        
        if (!error) {
            self.roomData = result;
            //self.avPlayView.shareURLStr = result.info.roominfo.id;
            [self.liverDetailTableView reloadData];
        }else {
            
            
        }
        
    }];
}

- (void)addChatAction {
    
}

#pragma mark-----页面旋转

- (void)screenOrientationNotification {
    NSLog(@"UIDevice:(orientation)%ld",(long)[UIDevice currentDevice].orientation);
    NSLog(@"UIDeviceOrientationUnknown:%ld",(long)UIDeviceOrientationUnknown);
    NSLog(@"UIDeviceOrientationPortrait:%ld",(long)UIDeviceOrientationPortrait);
    NSLog(@"UIDeviceOrientationPortraitUpsideDown:%ld",(long)UIDeviceOrientationPortraitUpsideDown);
    NSLog(@"UIDeviceOrientationLandscapeLeft:%ld",(long)UIDeviceOrientationLandscapeLeft);
    NSLog(@"UIDeviceOrientationLandscapeRight:%ld",(long)UIDeviceOrientationLandscapeRight);
    NSLog(@"UIDeviceOrientationFaceUp:%ld",(long)UIDeviceOrientationFaceUp);
    NSLog(@"UIDeviceOrientationFaceDown:%ld",(long)UIDeviceOrientationFaceDown);
    if ([UIDevice currentDevice].orientation== UIDeviceOrientationLandscapeRight&&self.orientation==UIDeviceOrientationLandscapeLeft) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.avPlayView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }];
        self.avPlayView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.orientation = UIDeviceOrientationLandscapeRight;
    }
    else if ([UIDevice currentDevice].orientation== UIDeviceOrientationLandscapeLeft&&self.orientation==UIDeviceOrientationLandscapeRight)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.avPlayView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
        self.avPlayView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.orientation = UIDeviceOrientationLandscapeLeft;
    }
}

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}



@end

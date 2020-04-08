//
//  RTBingsResultController.m
//  STP
//
//  Created by Kris on 2017/10/31.
//  Copyright © 2017年 STP. All rights reserved.
//

#import "STPBingsResultController.h"
#if !(TARGET_IPHONE_SIMULATOR)
#import "STPBluetoothManager.h"
#import "STPOpmodeObject.h"
#endif
#import "STPConnectReadyController.h"

typedef NS_ENUM(NSInteger,STPDeviceBindResult){
    STPDeviceBindResultStart = 0,
    STPDeviceBindResultTimeout, //超时
    STPDeviceBindResultFirstBinded, //第一次绑定
    STPDeviceBindResultHaveBinded, // 已经绑定
    STPDeviceBindResultHaveBindedByOthers // 已被别人绑定
};

@interface STPBingsResultController ()
@property (nonatomic,assign) STPDeviceBindResult bindResult;
@property (nonatomic,strong) RACDisposable *signal;

@property (nonatomic,strong) UILabel *tipsLabel;
@end

@implementation STPBingsResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *connetImage = [UIImageView new];
    [self.view addSubview:connetImage];
    connetImage.image = [UIImage imageNamed:@"connecting_000"];
    [connetImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
        make.width.mas_equalTo(connetImage.image.size.width);
        make.height.mas_equalTo(connetImage.image.size.height);
    }];
    NSMutableArray * searchArray = [NSMutableArray new];
    for(int i =1 ; i < 29 ; i++){
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"connecting_%03d",i]];
        if(image){
            [searchArray addObject:image];
        }
    }
    connetImage.animationImages = searchArray;
    [connetImage setAnimationDuration:2];
    [connetImage setAnimationRepeatCount:-1];
    [connetImage startAnimating];
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = UIColorHex(0x4a4a4a);
    titleLabel.text = @"网络连接中，请耐心等待...";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(connetImage.mas_bottom).offset(40);
    }];
    _tipsLabel = titleLabel;
    
#if !(TARGET_IPHONE_SIMULATOR)
    [STPBluetoothManager sharedInstance].bleStateBlock = ^(STPBleState bleState) {
        if (bleState == STPBleStateWritable) {
            STPOpmodeObject *object = [[STPOpmodeObject alloc]init];
            NSString *wifiName = [NSString stringWithFormat:@"%@",_wifiSSid];
            NSString *name64String = [[wifiName dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            object.wifiSSid= name64String;
            if ([_wifiPassword containsString:@"#"]) {
                _wifiPassword = [_wifiPassword stringByReplacingOccurrencesOfString:@"#" withString:@"\\#"];
            }
            
            // STP TODO : 在此需要将用户ID发送到硬件设备，用于硬件设备绑定用户。userid (需要替换)
            object.wifiPassword = [NSString stringWithFormat:@"v1#%@#%@#",_wifiPassword,@"userid"]; // 用户ID
            [[STPBluetoothManager sharedInstance] setOpmodeObject:object];
            [self bindResultCountdown];
        }
    };
    [[STPBluetoothManager sharedInstance] connectDevice];
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)bindResultCountdown
{
    RACSignal *racSignal  = [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] timeout:30 onScheduler:[RACScheduler currentScheduler]];
    _signal = [racSignal subscribeNext:^(id x) {
        // STP TODO : 在此处循环请求 当前用户是否绑定成功设备。
//        [STPDeviceApi getDeviceBindInfo:^(STPBindInfo * _Nullable response, NSError * _Nullable error) {
//
//        if ([bindInfo.deviceID isNotBlank]){
//            if(bindInfo.isFirstBinded) {//首次绑定设备
//                self.bindResult = STPDeviceBindResultFirstBinded;
//            } else if(bindInfo.isBinded){
//                self.bindResult = STPDeviceBindResultHaveBinded;
//            } else{
//                self.bindResult = STPDeviceBindResultHaveBindedByOthers;
//            }
//        }
//        }];
        
    } error:^(NSError *error) {
        self.bindResult = STPDeviceBindResultTimeout;
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
#if !(TARGET_IPHONE_SIMULATOR)
    [[STPBluetoothManager sharedInstance] cancelAllConnect];
#endif
}

-(void)setBindResult:(STPDeviceBindResult)bindResult
{
    bindResult = STPDeviceBindResultFirstBinded;
    if (!self.signal.isDisposed) [self.signal dispose];
    if (bindResult == STPDeviceBindResultTimeout) {
      
        NSLog(@"网络配置失败");
    }
    if (bindResult == STPDeviceBindResultFirstBinded) {
        _tipsLabel.text = @"连接成功";
    }
    if (bindResult == STPDeviceBindResultHaveBinded) {
        NSArray *viewControllers = self.navigationController.viewControllers;
        UIViewController *alboutVC = nil;
        if (alboutVC) {
            [self.navigationController popToViewController:alboutVC animated:YES];
        }else{
            [self popViewController];
        }
    }
    if(bindResult == STPDeviceBindResultHaveBindedByOthers){
       
    }
}

-(void)popViewController
{
        [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

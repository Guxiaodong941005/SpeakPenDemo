//
//  PDConfigNetStepTwoController.m
//  Pudding
//
//  Created by Kris on 16/3/4.
//  Copyright © 2016年 Zhi Kuiyu. All rights reserved.
//

#import "STPSelectNetController.h"
#import "ReactiveObjC.h"
#import "STPBingsResultController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <sys/utsname.h>


@interface STPSelectNetController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;              //   title
@property (nonatomic, weak) UITextField * wifiNameTxtField;
@property (nonatomic, weak) UITextField * wifiPsdTxtField;
@property (nonatomic, weak) UIButton * wifiBtn;
@end

@implementation STPSelectNetController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化导航
    self.title = @"配置网络";
    UIImageView *successImage = [UIImageView new];
    [self.view addSubview:successImage];
    successImage.image = [UIImage imageNamed:@"img_topimage_wifi"];
    successImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300 * HeightScale);
    
    UIButton * backImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [backImage addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backImage setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    backImage.frame = CGRectMake(5, 130, 50, 44);
    [self.view addSubview:backImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SX(60), SCREEN_HEIGHT, SCREEN_WIDTH - SX(120), 44)];
    self.titleLabel.text = @"配置网络";
    self.titleLabel.textAlignment = NSTextAlignmentCenter ;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [ UIColor clearColor];
    [self.view addSubview:self.titleLabel];
    
    UITextField * wifiNameTxtField = [UITextField new];
    wifiNameTxtField.placeholder = @"请输入WiFi账号";
    wifiNameTxtField.returnKeyType = UIReturnKeyNext;
    wifiNameTxtField.textColor = [UIColor blackColor];
    wifiNameTxtField.backgroundColor = [UIColor clearColor];
    wifiNameTxtField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:wifiNameTxtField];
    [wifiNameTxtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(successImage.mas_bottom).offset(10);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(45);
    }];
    _wifiNameTxtField = wifiNameTxtField;
    _wifiNameTxtField.text = [self wiFiSSID];
    _wifiNameTxtField.returnKeyType = UIReturnKeyNext;
    _wifiNameTxtField.delegate=self;

    UITextField * wifiPsdTxtField =[UITextField new];
    wifiPsdTxtField.placeholder = @"请输入WiFi密码";
    wifiPsdTxtField.returnKeyType = UIReturnKeyGo;
    wifiPsdTxtField.secureTextEntry = YES;
    wifiPsdTxtField.keyboardType = UIKeyboardTypeAlphabet;
    wifiPsdTxtField.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:wifiPsdTxtField];
    _wifiPsdTxtField = wifiPsdTxtField;
    _wifiPsdTxtField.returnKeyType = UIReturnKeyDone;
    _wifiPsdTxtField.delegate=self;
    
    [wifiPsdTxtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wifiNameTxtField.mas_left);
        make.right.mas_equalTo(wifiNameTxtField.mas_right);
        make.height.mas_equalTo(wifiNameTxtField.mas_height);
        make.top.mas_equalTo(wifiNameTxtField.mas_bottom).offset(20);
    }];
    UIButton *secBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secBtn setImage:[UIImage imageNamed:@"icon_eyes_close"] forState:UIControlStateNormal];
    [secBtn setImage:[UIImage imageNamed:@"icon_eyes_open"] forState:UIControlStateSelected];
    secBtn.frame = CGRectMake(0, 0, 26, 13);
    wifiPsdTxtField.rightView = secBtn;
    wifiPsdTxtField.rightViewMode = UITextFieldViewModeAlways;
    @weakify(self);
    [[secBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * btn) {
        @strongify(self);
        [btn setSelected:!btn.isSelected];
        self.wifiPsdTxtField.secureTextEntry = !btn.isSelected;
    }];
    
    
    UILabel * alertLab = [UILabel new];
    alertLab.textAlignment = NSTextAlignmentLeft;
    alertLab.textColor = UIColorHex(0xabaeb2);
    alertLab.text = @"注:暂不支持链接5GWiFi";
    alertLab.numberOfLines = 0;
    alertLab.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:alertLab];
    [alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wifiNameTxtField.mas_left);
        make.top.mas_equalTo(wifiPsdTxtField.mas_bottom);
        make.height.mas_equalTo(20);
    }];

    UIButton *wifiBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [wifiBtn setTitle:@"连接WiFi" forState:UIControlStateNormal];
    wifiBtn.layer.cornerRadius = 45 *0.5;
    wifiBtn.layer.masksToBounds = true;
    [wifiBtn addTarget:self action:@selector(checkWifiPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wifiBtn];
    [wifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wifiNameTxtField.mas_left);
        make.right.mas_equalTo(wifiNameTxtField.mas_right);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-100);
    }];
    
    
}

-(NSString *)wiFiSSID
{
#if TARGET_OS_SIMULATOR
    return @"(simulator)";
#else
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        
        return nil;
        
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    
    return wifiName;
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)checkWifiPassWord
{   NSString *password = self.wifiPsdTxtField.text;
    [self connectWifiAction:password];
}

#pragma mark - action: 连接 wifi点击
- (void)connectWifiAction:(NSString*)password{
    STPBingsResultController *resultVC = [STPBingsResultController new];
    resultVC.wifiSSid = self.wifiNameTxtField.text;
    resultVC.wifiPassword = password;
    [self.navigationController pushViewController:resultVC animated:YES];
}

- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------- UITextFieldDelegate ------------------------

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.wifiNameTxtField) {
        [self.wifiPsdTxtField becomeFirstResponder];
    }else if (textField == self.wifiPsdTxtField){
        [self checkWifiPassWord];
    }
    return YES;
}

@end

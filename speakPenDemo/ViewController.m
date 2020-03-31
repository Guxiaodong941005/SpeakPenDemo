//
//  ViewController.m
//  speakPenDemo
//
//  Created by roobo on 2020/3/29.
//  Copyright © 2020 stp. All rights reserved.
//

#import "ViewController.h"
#import <SpeakPen/STPAuthApi.h>
#import <SpeakPen/STPDeviceApi.h>
#import <SpeakPen/STPAccessConfig.h>
#import <SpeakPen/STPUserApi.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"speakPen 演示demo";
    [self setupFunctionItem];
       
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    STPAccessConfiger.developEnv = RBDevelopEnv_Alpha;
    STPAccessConfiger.appID = @"c476a0173003";
        
    [STPAuthApi login:@"18112632108" passWord:@"23456789" completionBlock:^(STPUserModel * _Nonnull user, NSError * _Nonnull error) {
        NSString *tips = @"登录成功";
        NSString *message = @"点击下面列表测试";
        if (error) {
            tips = @"登录失败";
            message = error.description;
        } else {
            if (user.devices.count > 0) {
               STPAccessConfiger.currDeviceID = [[user.devices firstObject] deviceID];
            }
        }
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:tips message:message preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
               NSLog(@"确定");
           }];
           [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
           //将action添加到控制器
           [alertVc addAction :sureBtn];
           //展示
           [self presentViewController:alertVc animated:YES completion:nil];
           
    }];
    // Do any additional setup after loading the view.
}

-(void)setupFunctionItem
{
     _dataArray = @[
                    @"获取当前用户的设备",
                    @"获取设备硬件信息",
                    @"获取设备的详细信息",
                    @"关闭设备",
                    @"修改设备的名称",
                    @"修改设备音量",
                    @"检测新版本",
                    @"新版本升级",
                    @"设备重启",
                    @"修改用户名称",
                    ];
}

#pragma mark ------------------- UITableViewDelegate ------------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text =[NSString stringWithFormat:@"%ld——%@",(long)indexPath.row,_dataArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        switch (indexPath.row) {
               case 0:
            {
                //获取当前用户的所有设备
                [STPDeviceApi getDeviceList:YES block:^(NSArray<STPDeviceModel *> * _Nonnull device, NSError * _Nonnull error) {
                    NSLog(@"--获取设备列表-%@-----%@",device,error);
                }];
            }
                break;
                case 1:
            {
                          //获取当前用户的所有设备
                [STPDeviceApi getHardwareInfo:^(STPHardwareModel *deviceDict, NSError * _Nonnull error) {
                     NSLog(@"获取设备硬件信息: %@---%@",deviceDict,error);
                }];
            }
                break;
                case 2:
            {
                [STPDeviceApi getDeviceDetail:^(STPDevicesDetail * _Nonnull detail, NSError * _Nonnull error) {
                      NSLog(@"获取设备详情: %@---%@",detail,error);
                }];
            }
                break;
                case 3:
            {
                //关闭设备
                [STPDeviceApi shutdownDevice:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
                case 4:
            {
                // 修改设备名称
                [STPDeviceApi updateDeviceName:@"点读笔1" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
                case 5:
            {
                // 修改设备音量
                [STPDeviceApi changeDeviceVolume:50 block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    NSLog(@"-修改设备音量----%d-------%@",isSuccess,error);
                }];
            }
                break;
                case 6:
            {
                // 检测新版本
                [STPDeviceApi checkDeviceVersion:^(BOOL update, NSString * _Nonnull version, NSError * _Nullable error) {
                    
                }];
            }
                break;
                case 7:
            {
                //更新新版本
                [STPDeviceApi updateDevice:^(id  _Nonnull response, NSError * _Nullable error) {
                    
                }];
            }
                break;
                case 8:
            {
                [STPDeviceApi restartDevice:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
                case 9:
            {
                [STPUserApi updateUserName:@"我是新用户" completionBlock:^(BOOL isSucceed, NSError * _Nullable error) {
                    
                }];
            }
                break;
            default:
                break;
        }
}
@end

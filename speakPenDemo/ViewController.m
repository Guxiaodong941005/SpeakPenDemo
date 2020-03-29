//
//  ViewController.m
//  speakPenDemo
//
//  Created by roobo on 2020/3/29.
//  Copyright © 2020 stp. All rights reserved.
//

#import "ViewController.h"
#import <SpeakPen/RBAuthApi.h>
#import <SpeakPen/RBPlayerApi.h>
#import <SpeakPen/RBDeviceApi.h>
#import <SpeakPen/RBAccessConfig.h>
#import <SpeakPen/RBUserApi.h>

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
    RBAccessConfiger.developEnv = RBDevelopEnv_Alpha;
    RBAccessConfiger.userID = @"st:189386d98ebda2c80fc3d0a2005dfbd9";
    RBAccessConfiger.currDeviceID = @"4000002D00000025";
    RBAccessConfiger.accessToken = @"22004bd4f36af36708e43d44024268f8";
    RBAccessConfiger.appID = @"NjMzMWQxMzFhY2Ey";
    // Do any additional setup after loading the view.
}

-(void)setupFunctionItem
{
     _dataArray = @[
                    @"获取声波配网文件",
                    @"更改管理员",
                    @"删除所绑定的设备(删除慎重)",
                    @"添加其他用户到设备成员组",
                    @"从当前设备成员组中删除用户",
                    @"获取当前用户的设备",
                    @"获取设备硬件信息",
                    @"获取设备的详细信息",
                    @"发送文本",
                    @"关闭设备",
                    @"修改设备的名称",
                    @"修改设备音量",
                    @"发送语音",
                    @"检测新版本",
                    @"新版本升级",
                    @"获取一级大分类",
                    @"获取当前模块的专辑列表",
                    @"获取当前分类的资源列表",
                    @"播放资源",
                    @"播放停止",
                    @"获取播放状态",
                    @"获取宝宝信息",
                    @"获取宝宝心理模型",
                    @"增加宝宝信息",
                    @"获取播放记录",
                    @"删除播放记录",
                    @"收藏播放资源",
                    @"取消资源收藏",
                    @"资源收藏列表",
                    @"上传宝宝头像",
                    @"音频资源搜索",
                    @"获取自定义的专辑列表",
                    @"获取聊天记录",
                    @"重置当前自定义专辑资源",
                    @"获取自定义专辑中资源列表",
                    @"获取自定义命令(耳灯童锁)",
                    @"设备重启",
                    @"设置单曲播放",
                    @"设置列表播放",
                    @"获取声波配网的结果",
                    @"增加资源到自定义专辑",
                    @"删除资源到自定义专辑",
                    @"删除宝宝",
                    @"增加宝宝标签",
                    @"上传语音",
                    @"上传图片",
                    @"修改宝宝信息",
                     @"获取闹钟",
                     @"增加闹钟",
                     @"修改闹钟",
                     @"删除闹钟",
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
                [RBDeviceApi getSoundWave:@"roobo " wifiPsd:@"roobo@2016" block:^(NSString *urlString, NSError * _Nonnull error) {
                    NSLog(@"-网络结果-------%@---------%@---%@",urlString,error,[NSThread currentThread]);
                }];
            }
                break;
            case 1:
            {
                //修改管理员
                 [RBUserApi changeManager:@"st:189386d98ebda2c80fc3d0a2005dfbd9" block:^(BOOL isSuccess, NSError * error) {
                     NSLog(@"-修改管理员--%d-----%@---------",isSuccess,error);
                 }];
            }
                break;
            case 2:
            {
                //删除所绑定的设备
                [RBDeviceApi deleteDevice:^(BOOL isSuccess, NSError * _Nonnull error) {
                     NSLog(@"-删除所绑定的设备--%d-----%@---------",isSuccess,error);
                }];
                
            }
                break;
            case 3:
            {
                //添加其他用户到设备成员组中（邀请成员）
                [RBUserApi inviteUser:@"13341122739" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                     NSLog(@"添加其他用户到设备成员组中（邀请成员） =  %d:%@",isSuccess,error);
                }];
            }
                break;
            case 4:
            {
                //从当前设备成员组中删除用户
                [RBUserApi deleteUser:@"st:189386d98ebda2c80fc3d0a2005dfbd9" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    NSLog(@"从当前设备成员组中删除用户 =  %d%@",isSuccess,error);
                }];
            }
                break;
            case 5:
            {
                //获取当前用户的所有设备
                [RBDeviceApi getDeviceList:YES block:^(NSArray<RBDeviceModel *> * _Nonnull device, NSError * _Nonnull error) {
                    NSLog(@"--获取设备列表-%@-----%@",device,error);
                } ];
                
            }
                break;
            case 6:
            {
                [RBDeviceApi getHardwareInfo:^(RBHardwareModel *deviceDict, NSError * _Nonnull error) {
                     NSLog(@"获取设备硬件信息: %@---%@",deviceDict,error);
                }];
            }
                break;
            case 7:
            {
             
                [RBDeviceApi getDeviceDetail:^(RBDevicesDetail * _Nonnull detail, NSError * _Nonnull error) {
                      NSLog(@"获取设备详情: %@---%@",detail,error);
                }];
            }
                break;
            case 8:
            {
                
               
            }
                 break;
            case 9:
            {
                //重启设备
                [RBDeviceApi shutdownDevice:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];

            }
                break;
            case 10:
            {
                // 修改设备名称
                [RBDeviceApi updateDeviceName:@"小伙伴1" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
               
            }
                break;
            case 11:
            {
                // 修改设备音量
               [RBDeviceApi changeDeviceVolume:50 block:^(BOOL isSuccess, NSError * _Nonnull error) {
                   NSLog(@"-修改设备音量----%d-------%@",isSuccess,error);
               }];
                
            }
                break;
            case 12:
            {

            }
                break;
            case 13:
            {
                // 检测新版本
                [RBDeviceApi checkDeviceVersion:^(BOOL update, NSString * _Nonnull version, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 14:
            {
                //更新新版本
                [RBDeviceApi updateDevice:^(id  _Nonnull response, NSError * _Nullable error) {
                    
                }];
                
            }
                break;
            case 15:
            {
                [RBPlayerApi getCategoryList:0  block:^(RBCategoryList *response, NSError * _Nullable error) {
                    
                }];
            }
                break;
           
            case 16:
            {
                //获取专辑列表
                [RBPlayerApi getAlbumList:@"18" page:1 block:^(RBAlbumList * _Nullable list, NSError * _Nullable error) {
                    NSLog(@"%@",list);
                }];
                
            }
                break;
            case 17:
            {
                [RBPlayerApi getResourceList:@"7745" page:1 count:10 block:^(RBResourceList * _Nullable list, NSError * _Nullable error) {
                    NSLog(@"%@",list);
                }];
               
            }
                break;
            case 18:
            {
               [RBPlayerApi playResource:0 aID:@"7745" rID:@"485728" block:^(id  _Nullable response, NSError * _Nullable error) {
                   
               }];
            }
                break;
            case 19:
            {
                [RBPlayerApi stopResource:@"1" block:^(BOOL response, NSError * _Nullable error) {
                    
                }];
            }
            break;
            case 20:
            {
               [RBPlayerApi getPlayState:^(RBPlayInfoModel * _Nonnull response, NSError * _Nullable error) {
                    
                }];
            }
             break;
            case 21:
            {
                [RBUserApi getBabyList:^(NSArray<RBBabyModel *> * _Nonnull babyModels, NSError * _Nonnull error) {
                    
                }];
//               [RBUserApi getBabyInfo:^(RBBabyModel *babyInfo, NSError * _Nonnull error) {
//                    NSLog(@"-宝宝信息---%@---%@",babyInfo,error);
//               }];
            }
                break;
            case 22:
            {
                [RBUserApi getGrowthModel:@"385" block:^(RBBabyGrowthModel *growthModel, NSError * _Nonnull error) {
                    NSLog(@"%@",growthModel);
                }];
            }
                break;
             case 23:
            {
//                [RBUserApi addBabyInfo:@"小宝宝" birthday:@"2013-10-01" gender:@"boy" block:^(BOOL response, NSError * _Nonnull error) {
//
//                }];
                RBBabyModel *babyModel = [RBBabyModel new];
                babyModel.nickname = @"小宝宝TEST";
                babyModel.gender = @"girl";
                babyModel.birthday = @"2001-10-01";
                 babyModel.tags = @"";
                [RBUserApi addBabyInfo:babyModel block:^(RBBabyModel * babyModel, NSError * error) {
                    
                }];
            }
                break;
            case 24:
            {
              [RBPlayerApi getPlayHistoy:@"0" block:^(id  _Nullable response, NSError * error) {
                   NSLog(@"-播放历史---%@---%@",response,error);
              } ];
            }
                break;
            case 25:
            {
                [RBPlayerApi deletePlayHistoy:@[@"1"]block:^(BOOL success, NSError * error) {
                    NSLog(@"-删除历史---%d---%@",success,error);
                } ];
            }
                break;
            case 26:
            {
                RBCollectionModel *model = [RBCollectionModel new];
                model.rID = @"485704";
                model.src = @"aires";
                model.aID = @"7745";
                RBCollectionModel *model1 = [RBCollectionModel new];
                model1.src = @"aires";
                model1.aID = @"7745";
               [RBPlayerApi addCollection:@[model,model1] block:^(id  _Nullable response, NSError * error) {
                   
               }];
            }
                break;
            case 27:
            {
               [RBPlayerApi deleteCollection:@[@"96",@"97"] block:^(BOOL response, NSError * error) {
                   
               }];
            }
                break;
            case 28:
            {
                [RBPlayerApi getCollectionList:1 page:1 block:^(RBCollectionList *list, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 29:
            {
                
                NSString *imagePath  = [[NSBundle mainBundle] pathForResource:@"rbTestPig" ofType:@"png"];
                [RBUserApi uploadBabyAvatar:@"35" avatarImage:[UIImage imageWithContentsOfFile:imagePath]  progressBlock:^(NSProgress * _Nonnull progress) {

                } resultBlock:^(id  _Nonnull response, NSError * _Nullable error) {
                    NSLog(@"%@",response);
                }];
            }
                break;
            case 30:
            {
                [RBPlayerApi searchResource:@"儿歌" page:1 type:3 block:^(RBSearchResultList *searchList, NSError *error) {
                    NSLog(@"%@---%@",searchList,error);
                }];
            }
                break;
            case 31:
            {
                [RBPlayerApi getCustomAlbumList:^(id  _Nonnull response, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 32:
            {
                [RBDeviceApi getChatMessageList:@"0" block:^(id  _Nonnull response, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 33:
            {
                [RBPlayerApi resetCustomAlbum:@"61277" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 34:
            {
                [RBPlayerApi getResourceList:@"61278" page:1 count:20  block:^(RBResourceList * _Nullable list, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 35:
            {
                [RBDeviceApi sendCustomCommand:@{@"lock":@1} block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 36:
            {
                [RBDeviceApi restartDevice:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 37:
            {
//                [RBPlayerApi setPlayMode:1 block:^(id  _Nullable response, NSError * _Nullable error) {
//
//                }];
            }
                break;
            case 38:
            {
//                [RBPlayerApi setPlayMode:2 block:^(id  _Nullable response, NSError * _Nullable error) {
//
//                }];
            }
                break;
            case 39:
            {
                [RBDeviceApi getDeviceBindInfo:^(RBBindInfo * _Nullable response, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 40:
            {
                [RBPlayerApi addCustomResource:@[@"516016"] aID:@"61278" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 41:
            {
                [RBPlayerApi delCustomResource:@[@"516016"] aID:@"61278" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 42:
            {
                [RBUserApi deleteBabyInfo:@[@"30",@"31"] block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    NSLog(@"%d---%@",isSuccess,error);
                }];
            }
                break;
                case 43:
            {
                [RBUserApi addBabyTags:@"标签1" babyID:@"50" block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
                case 44:
            {
                 NSString *armPath  = [[NSBundle mainBundle] pathForResource:@"VoiceAmrFile" ofType:@"amr"];
                [RBDeviceApi sendVoice:armPath length:3 progressBlock:^(NSProgress * _Nonnull progress) {
                    
                } resultBlock:^(id  _Nonnull response, NSError * _Nullable error) {
                    
                }];
            }
                break;
                case 45:
            {
                NSString *imagePath  = [[NSBundle mainBundle] pathForResource:@"rbTestPig" ofType:@"png"];
                [RBUserApi addAvatar:[UIImage imageWithContentsOfFile:imagePath] progressBlock:^(NSProgress * _Nonnull progress) {
                    
                } resultBlock:^(RBAvatarModel * _Nonnull avatarModel, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 46:
            {
                RBBabyModel *babyModel = [RBBabyModel new];
                babyModel.nickname = @"小宝宝修改";
                babyModel.gender = @"boy";
                babyModel.birthday = @"2006-10-01";
                babyModel.babyId = @"47";
                [RBUserApi editBabyInfo:babyModel block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 47:
            {
               
                [RBDeviceApi getAlarmList:^(RBAlarmList * _Nonnull alarmList, NSError * _Nullable error) {
                    
                }];
            }
                break;
            case 48:
            {
                RBAlarmModel *modle = [RBAlarmModel new];
                modle.type = 1;
                modle.name = @"起床";
                modle.timezone =  [NSTimeZone localTimeZone].abbreviation;
                modle.repeat =  @"-1";
                modle.timer = 10*3600;
                modle.status = YES;
                [RBDeviceApi addAlarm:modle block:^(RBAlarmModel *model, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 49:
            {
                RBAlarmModel *modle = [RBAlarmModel new];
                modle.alarmId = @"41";
                modle.timezone =  [NSTimeZone localTimeZone].abbreviation;
                modle.status = NO;
                modle.name = @"起床";
                modle.repeat =  @"-1";
                modle.timer = 10*3600;
                [RBDeviceApi editAlarm:modle block:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            case 50:
            {
                [RBPlayerApi cleanPlayHistory:^(BOOL isSuccess, NSError * _Nonnull error) {
                    
                }];
            }
                break;
            default:
                break;
        }
}
@end

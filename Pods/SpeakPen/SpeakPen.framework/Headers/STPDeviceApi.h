//
//  STPDeviceApi.h
//  Pods
//
//  Created by kris on 16/11/12.
//
//

#import <Foundation/Foundation.h>
#import "STPDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STPDeviceApi : NSObject

#pragma mark ------------------- 设备信息 ------------------------

/**
 获取配网的结果  建议采用定时轮询
 */
+(void)getDeviceBindInfo:(void (^)(STPBindInfo* _Nullable response, NSError *_Nullable error))block;

/**
 获取用户的所有设备

 @param currDetail 是否显示当前控制设备的详情  YES等于同时调用getDeviceDetail
 */
+ (void)getDeviceList:(BOOL)currDetail block:(void(^)(NSArray <STPDeviceModel*>*device,NSError* _Nullable error))block;

/**
 获取设备详细信息
 */
+ (void)getDeviceDetail:(nonnull void (^)(STPDevicesDetail *detail,NSError* _Nullable error))block;

/**
  获取设备硬件信息
 */
+ (void)getHardwareInfo:(nonnull void(^)(STPHardwareModel *hardMode,NSError* _Nullable error))block;


#pragma mark ------------------- 设备控制 ------------------------

/**
 重启设备
 @param block isSucceed 是否成功 error 错误信息
 */
+ (void)restartDevice:(void (^)(BOOL isSuccess,NSError *error))block;

/**
 关闭设备
 @param block isSucceed 是否成功 error 错误信息
 */
+ (void)shutdownDevice:(void (^)(BOOL isSuccess,NSError* _Nullable error))block;

/**
 修改设备的名称
 @param deviceName 新的名称
 */
+ (void)updateDeviceName:(NSString *_Nonnull)deviceName block:(void (^)(BOOL isSuccess,NSError* _Nullable error)) block;

/**
 修改设备音量
 @param voiceValue 音量值 最小值0 最大值100

 */
+ (void)changeDeviceVolume:(NSInteger )voiceValue block:(void (^)(BOOL isSuccess,NSError* _Nullable error)) block;

/**
 解除绑定当前的设备
 */
+ (void)unbindDevice:(void (^)(BOOL isSuccess,NSError *_Nullable error)) block;

#pragma mark -------------------版本升级------------------------

/**
    检测是否有新版本
 */
+(void)checkDeviceVersion:(void (^)(BOOL update,NSString *version,NSError * _Nullable error))block;

/**
    设备升级
 */
+(void)updateDevice:(void (^)(id response, NSError * _Nullable error))block;

@end
NS_ASSUME_NONNULL_END

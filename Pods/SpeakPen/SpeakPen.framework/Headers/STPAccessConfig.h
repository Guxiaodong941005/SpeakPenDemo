//
//  STPAccessConfig.h
//  SpeakPenAPIDemo
//
//  Created by kris on 2017/4/19.
//  Copyright © 2017年 kris. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RBDevelopEnv) {
    RBDevelopEnv_Relese = 0,// 发布环境
    RBDevelopEnv_Dedug,// 开发环境
    RBDevelopEnv_Alpha,// 测试环境
};


#define STPAccessConfiger [STPAccessConfig defaultConfig]
/**
  stp sdk 全局配置文件
 */
@interface STPAccessConfig : NSObject


/**
 开发环境   分为开发和发布环境
 */
@property(nonatomic,assign) RBDevelopEnv developEnv;

/**
  app id 服务器会给第三方
 */
@property(nonatomic,strong,nonnull) NSString* appID;

/**
   登录用户的id
 */
@property(nonatomic,strong,nonnull) NSString *userID;

/**
   登录用户的accessToken
 */
@property(nonatomic,strong,nonnull) NSString *accessToken;

/**
  当前连接的设备ID 当切换控制设备时 需要更改currDeviceID值
 */
@property(nonatomic,strong,nonnull) NSString *currDeviceID;


/**
 获取配置类
 */
+ (instancetype)defaultConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;

/**
 清空资源配置文件
 */
+(void)clearLoginUserData;

@end

NS_ASSUME_NONNULL_END

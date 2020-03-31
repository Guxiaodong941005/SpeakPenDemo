//
//  STPUserApi.h
//  Pods
//
//  Created by kris on 2017/8/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "STPUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface STPUserApi : NSObject

#pragma mark ------------------- 用户权限 ------------------------
/**
 更改用户名称
 @param userID 用户id
 @param name 用户备注
 */
+ (void)updateUserRemark:(NSString *)userID name:(NSString *)name block:(void (^)(BOOL  isSuccess,NSError *error)) block;
/**
 更改管理员 注意：注意当前用户是管理员
 @param userID 用户的ID
 */
+ (void)changeManager:(NSString *)userID block:(void (^)(BOOL isSuccess, NSError* _Nullable error ))block;

/**
 添加用户到成员组 注意：注意当前用户是管理员
 
 @param phone 用户的手机号码
 */
+ (void)inviteUser:(nonnull NSString *)phone block:(void (^)(BOOL isSuccess,NSError*_Nullable error))block;

/**
 从当前设备成员组中删除用户 注意：注意当前用户是管理员
 
 @param userID 用户 id
 */
+ (void)deleteUser:(nonnull NSString *)userID block:(void (^)(BOOL isSuccess,NSError *_Nullable error))block;

/**
 上传图片接口
 @param image 图片资源
 */
+ (void)addAvatar:(UIImage *)image progressBlock:(void(^)(NSProgress *progress))progressBlock resultBlock:(void (^)(STPAvatarModel *avatarModel, NSError * _Nullable))resultBlock;

/**
 更改用户昵称
 @param name 名称
 */
+ (void)updateUserName:(NSString *_Nonnull)name completionBlock:(nullable void (^)(BOOL isSucceed,NSError * _Nullable error)) completionBlock;

/**
 退出登录
 */
+ (void)logOut:(nullable void (^)(BOOL isSucceed,NSError * _Nullable error)) completionBlock;

@end
NS_ASSUME_NONNULL_END

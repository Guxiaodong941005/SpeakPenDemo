//
//  RBUserApi.h
//  Pods
//
//  Created by baxiang on 2017/8/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "RBUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RBUserApi : NSObject

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

#pragma mark ------------------- 宝宝信息 ------------------------

/**
 获取宝宝信息
 */
+(void)getBabyList:(void (^)(NSArray<RBBabyModel*>*babyModels,NSError *error))block;

/**
 增加宝宝信息
 @param babyModel 宝宝数据模型
 */
+(void)addBabyInfo:(RBBabyModel*)babyModel block:(void (^)(RBBabyModel *babyModel,NSError *error))block;

/**
 修改宝宝信息
 @param babyModel 宝宝数据模型
 */
+(void)editBabyInfo:(RBBabyModel*)babyModel block:(void (^)(BOOL isSuccess,NSError *error))block;

/**
 删除宝宝信息
 @param babyIds 宝宝ID数组
 */
+(void)deleteBabyInfo:(NSArray<NSString*>*)babyIds block:(void (^)(BOOL isSuccess,NSError *error))block;

/**
 增加修改宝宝标签
 @param tags 宝宝标签 以/分割标签
 */
+(void)addBabyTags:(NSString*)tags babyID:(NSString*)babyID block:(void (^)(BOOL isSuccess,NSError *error))block;

/**
 获取宝宝心理模型
 @param babyID 宝宝ID
 */
+(void)getGrowthModel:(NSString*)babyID  block:(void (^)(RBBabyGrowthModel *growthModel,NSError *error))block;

/**
 上传宝宝头像资源
 @param avatarImage 图片的数据
 */
+ (void)uploadBabyAvatar:(NSString*)babyID avatarImage:(UIImage *)avatarImage progressBlock:(void(^)(NSProgress *progress))progressBlock resultBlock:(void (^)(NSString *imgURL, NSError * _Nullable))resultBlock;

/**
 上传图片接口
 @param image 图片资源
 */
+ (void)addAvatar:(UIImage *)image progressBlock:(void(^)(NSProgress *progress))progressBlock resultBlock:(void (^)(RBAvatarModel *avatarModel, NSError * _Nullable))resultBlock;
@end
NS_ASSUME_NONNULL_END

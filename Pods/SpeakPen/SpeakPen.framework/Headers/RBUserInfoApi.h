//
//  RBUserInfoApi.h
//  Pods
//
//  Created by baxiang on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface RBUserInfoApi : NSObject

/**
   更新用户推送的token
 @param pushToken apple pushToken
 @param completionBlock result
 */
+ (void)updateUserPushToken:(NSString *_Nonnull)pushToken completionBlock:(void (^)(BOOL  isSuccess,NSError *error)) completionBlock;
/**
 修改其他人的名称 注：管理员才能修改
 @param userID 用户的ID
 @param name 用户的名称
 */
+ (void)updateOthersUserID:(NSString *_Nonnull)userID name:(NSString *_Nonnull)name completionBlock:(nullable void (^)(BOOL  isSucceed,NSError * _Nullable error)) completionBlock;

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

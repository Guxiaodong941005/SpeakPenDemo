//
//  STPPictureBookApi.h
//  SpeakPen
//
//  Created by stp on 2020/3/31.
//  Copyright © 2020 stp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPPicBookResourceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STPPictureBookApi : NSObject

/**
 获取绘本资源列表
 @param resourceID  最后一条绘本ID，0表示获取首页（必选）
 @param count 每页返回的数量，可选范围1-50，建议值20 （必选）
 */
+ (void )getAllPicbookList:(NSInteger)resourceID count:(NSInteger)count block:(nullable void (^)(STPPicBookResourceList* _Nullable list,NSError * _Nullable error))block;

/**
 搜索绘本资源列表
 @param picBookName 绘本名称
 */
+ (void )searchPicbookList:(NSString *)picBookName block:(nullable void (^)(STPPicBookResourceList* _Nullable list,NSError * _Nullable error))block;

/// 获取绘本详情
/// @param picBookId 绘本ID
+ (void )getPicbookDetail:(NSString *)picBookId block:(nullable void (^)(STPPicBookDetailModel * _Nullable detailModel,NSError * _Nullable error))block;

/// 上传绘本
/// @param picBookId 绘本ID
+ (void )uploadPicbook:(NSString *)picBookId block:(nullable void (^)(BOOL isSuss,NSError * _Nullable error))block;

/// 删除绘本
/// @param picBookId 绘本ID
+ (void )deletePicbook:(NSString *)picBookId block:(nullable void (^)(BOOL isSuss,NSError * _Nullable error))block;

/**
 获取设备端绘本列表
 @param resourceID  最后一条绘本ID，0表示获取首页（必选）
 @param count 每页返回的数量，可选范围1-50，建议值20 （必选）
 */
+ (void )getLocalPicbookList:(NSInteger)resourceID count:(NSInteger)count block:(nullable void (^)(STPPicBookDetailList* _Nullable list,NSError * _Nullable error))block;

/// 获取设备端存储卡容量信息
+ (void )getSdcardInfo:(nullable void (^)(STPSdcardInfo * _Nullable cardInfo,NSError * _Nullable error))block;

@end

NS_ASSUME_NONNULL_END

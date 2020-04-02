//
//  STPStudyReportApi.h
//  SpeakPen
//
//  Created by stp on 2020/4/2.
//  Copyright © 2020 stp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPStudyReportModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STPStudyReportApi : NSObject

/// 获取学习成就数据 （按照日期进行选择）
/// @param type候选值对应的字符串
/// 1: 点读数量(point-reading)
/// 2：绘本阅读量 (pic-book)
/// 3：学习时长(duration)
/// 4： 跟读次数 (follow-reading)

/// @param start 起始日期 2020-03-24
/// @param end 终止日期
+ (void )getStudyAchieveData:(NSString *)type
                   startDate:(NSString *)start
                     endDate:(NSString *)end
                       block:(nullable void (^)(STPStudyAchieveList* _Nullable list,NSError * _Nullable error))block;

/// 获取学习成就数据 （按照数量进行选择）
/// @param type候选值对应的字符串
/// 1: 点读数量(point-reading)
/// 2：绘本阅读量 (pic-book)
/// 3：学习时长(duration)
/// 4： 跟读次数 (follow-reading)

/// @param fromId 数据起始ID ，0表示最新的数据
/// @param count 数据个数 
+ (void )getStudyAchieveData:(NSString *)type
                      fromId:(NSInteger)fromId
                       count:(NSInteger)count
                       block:(nullable void (^)(STPStudyAchieveList* _Nullable list,NSError * _Nullable error))block;

/// 获取学习成就详情数据 （按照数量进行选择）
/// @param type候选值对应的字符串
/// 0 ：整体概况 ("")
/// 1: 点读数量(point-reading)
/// 2：绘本阅读量 (pic-book)
/// 3：学习时长(duration)
/// 4：跟读次数 (follow-reading)

/// @param fromId 数据起始ID ，0表示最新的数据
/// @param count 数据个数
+ (void )getStudyAchieveDetailData:(NSString *)type
                      fromId:(NSInteger)fromId
                       count:(NSInteger)count
                       block:(nullable void (^)(STPStudyAchieveDetail * _Nullable list,NSError * _Nullable error))block;


/// 获取跟读评测统计数据 （按照日期进行选择）
/// @param start 起始日期 2020-03-24
/// @param end 终止日期
+ (void )getFollowReadData:(NSString *)start
                   endDate:(NSString *)end
                     block:(nullable void (^)(NSArray* _Nullable list,NSError * _Nullable error))block;

/// 获取跟读评测统计数据 （按照数量进行选择）
/// @param fromId 数据起始ID ，0表示最新的数据
/// @param count 数据个数
+ (void )getFollowReadData:(NSInteger)fromId
                     count:(NSInteger)count
                     block:(nullable void (^)(NSArray* _Nullable list,NSError * _Nullable error))block;

@end

NS_ASSUME_NONNULL_END

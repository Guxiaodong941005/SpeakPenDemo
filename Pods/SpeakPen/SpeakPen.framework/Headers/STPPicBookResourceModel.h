//
//  STPPicBookResourceModel.h
//  SpeakPen
//
//  Created by stp on 2020/3/31.
//  Copyright © 2020 stp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 绘本资源
@interface STPPicBookResourceModel : NSObject

@property(nonatomic,assign) NSInteger rID;//资源ID
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *cover;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *mid;// 设备id
@property(nonatomic,assign) NSInteger size;
@property(nonatomic,assign) NSInteger status;// 添加状态 0未添加 1已添加
@property(nonatomic,assign) NSInteger createdAt;//
@property(nonatomic,assign) NSInteger updatedAt;//

@end

@interface STPPicBookResourceList : NSObject

@property(nonatomic,assign) NSInteger total;// 分类的总数量
@property(nonatomic,strong) NSArray<STPPicBookResourceModel*> *lists;// 资源分类列表

@end

/// 绘本详情
@interface STPPicBookDetailModel : NSObject

@property(nonatomic,assign) NSInteger rID; //资源ID
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *cover;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *readGuideHtml;
@property(nonatomic,strong) NSString *mid; // 设备id
@property(nonatomic,assign) NSInteger size; //书籍大小 字节
@property(nonatomic,assign) NSInteger status; //下载状态 0等待下载 1下载中 2下载完成 3下载失败
@property(nonatomic,assign) NSInteger progress; // 下载进度 0-100
@property(nonatomic,assign) NSInteger createdAt;
@property(nonatomic,assign) NSInteger updatedAt;

@end

/// 绘本详情列表
@interface STPPicBookDetailList : NSObject

@property(nonatomic,assign) NSInteger total; // 分类的总数量
@property(nonatomic,strong) NSArray<STPPicBookDetailModel*> *lists; // 绘本列表

@end

/// 绘本详情列表
@interface STPSdcardInfo : NSObject

@property(nonatomic,assign) NSInteger sdMemUsed; //单位 MB， 已用空间
@property(nonatomic,assign) NSInteger sdMemTotal; //单位 MB， 总空间


@end

NS_ASSUME_NONNULL_END

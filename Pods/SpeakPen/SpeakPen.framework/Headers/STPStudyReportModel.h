//
//  STPStudyReportModel.h
//  SpeakPen
//
//  Created by stp on 2020/4/2.
//  Copyright © 2020 stp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPStudyReportModel : NSObject

@end

/// 学习成就数据
@interface STPStudyAchieveModel : NSObject

@property(nonatomic,strong) NSString *day;
@property(nonatomic,strong) NSString *value;

@end

/// 学习成就数据列表
@interface STPStudyAchieveList : NSObject

@property(nonatomic,assign) NSInteger total; // 分类的总数量
@property(nonatomic,strong) NSArray<STPStudyAchieveModel*> *lists; // 绘本列表

@end

#pragma mark 学习成就详情数据

@interface STPStudyAchieveDetailExtraModel : NSObject

@property(nonatomic,assign) NSInteger bookCnt;
@property(nonatomic,assign) NSInteger pointReadingCnt;
@property(nonatomic,assign) NSInteger followReadingCnt;
@property(nonatomic,assign) NSInteger duration;
@property(nonatomic,copy) NSArray *bookIds;

@end

@interface STPStudyAchieveDetailBookList : NSObject

@property(nonatomic,assign) NSInteger rId; // id
@property(nonatomic,assign) NSInteger playCnt;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *artist;
@property(nonatomic,strong) NSString *lyricist;
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *image;
@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *press;
@property(nonatomic,strong) NSString *readGuideHtml;

@end

/// 学习成就数据详情
@interface STPStudyAchieveDetail : NSObject

@property(nonatomic,assign) NSInteger rId; // id
@property(nonatomic,assign) NSInteger score; // 分数
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) STPStudyAchieveDetailExtraModel *extraModel;
@property(nonatomic,strong) NSArray<STPStudyAchieveDetailBookList*> *bookLists; // 图书列表

@end

#pragma mark 跟读评测统计数据

/// 跟读图书详情
@interface STPStudyFollowReadDataBookModel : NSObject

@property(nonatomic,assign) NSInteger rId; // book_id
@property(nonatomic,assign) NSInteger oid;
@property(nonatomic,assign) NSInteger score;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *url;

@end

/// 跟读图书详情相关列表
@interface STPStudyFollowReadDataExtraModel : NSObject

@property(nonatomic,assign) NSInteger cnt;
@property(nonatomic,strong) NSArray<STPStudyFollowReadDataBookModel*> *bookLists;

@end

/// 跟读数据
@interface STPStudyFollowReadDataModel : NSObject

@property(nonatomic,assign) NSInteger rId; // id
@property(nonatomic,assign) NSInteger score; // 分数
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) STPStudyFollowReadDataExtraModel *extraModel;

@end

NS_ASSUME_NONNULL_END

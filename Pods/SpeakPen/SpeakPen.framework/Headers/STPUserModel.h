//
//  STPUserModel.h
//  Pods
//
//  Created by kris on 16/11/12.
//
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class STPDeviceModel;

//用户基本信息
@interface STPUserModel : NSObject
@property (nonatomic,strong) NSString *userid;//id
@property (nonatomic,strong) NSString *headimg;//头像
@property (nonatomic,strong) NSString *name;//昵称
@property (nonatomic,strong) NSArray <STPDeviceModel*> *devices;//用户所拥有的设备
@end

@interface STPAvatarModel: NSObject
@property(nonatomic,strong) NSString *img;// 图片名
@property(nonatomic,strong) NSString *large;//大图url
@property(nonatomic,strong) NSString *thumb;//小图url
@end
NS_ASSUME_NONNULL_END

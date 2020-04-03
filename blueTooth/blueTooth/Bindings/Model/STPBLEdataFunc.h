//
//  STPBLEdataFunc.h
//  STP
//
//  Created by Kris on 2017/10/31.
//  Copyright © 2017年 STP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPBLEdataFunc : NSObject
+(NSString *)GetSerialNumber:(NSDictionary *)advertisementData;
+(unsigned int)BLEdataTOintWithData:(NSData *)data Locatoin:(NSInteger)locate Offset:(NSInteger)offset;
+(BOOL)IsValidTempData:(unsigned int)temp;
+(unsigned int)GetMaxValueWithData1:(unsigned int)data1 WithData2:(unsigned int)data2;
+(BOOL)isAleadyExist:(NSString*)str BLEDeviceArray:(NSArray *)array;
+(signed int)SignedintBLEdataTOintWithData:(NSData *)data Locatoin:(NSInteger)locate Offset:(NSInteger)offset;
@end

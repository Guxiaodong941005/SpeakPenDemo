//
//  STPBluetoothManager.h
//  STP
//
//  Created by Kris on 2017/10/31.
//  Copyright © 2017年 STP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STPBLEDevice.h"
@class STPOpmodeObject;
typedef NS_ENUM(NSInteger,STPBleState) {
    STPBleStateUnknown = 0,
    STPBleStatePowerOn,
    STPBleStatePoweroff,
    STPBleStateIdle,
    STPBleStateScan,
    STPBleStateCancelConnect,
    STPBleStateNoDevice,// 没有发现设备
    STPBleStateWaitToConnect,
    STPBleStateConnecting,
    STPBleStateConnected,
    STPBleStateWritable,
    STPBleStateDisconnect,
    STPBleStateReConnect,
    STPBleStateConnecttimeout,
    STPBleStateReconnecttimeout,
};

typedef void(^STPBLEStateChangeBlock)(STPBleState bleState);

@interface STPBluetoothManager : NSObject
@property(nonatomic,copy) STPBLEStateChangeBlock bleStateBlock;
@property(nonatomic,assign) STPBleState blestate;
@property(nonatomic,strong) STPBLEDevice *currentdevice;
@property(nonatomic,strong) NSMutableArray *BLEDeviceArray;//扫描周围蓝牙设备集合
+ (STPBluetoothManager *)sharedInstance;
-(void)scanPeripherals;
-(void)stopScanPeripherals;
-(void)cancelAllConnect;
-(void)connectDevice;
-(void)setOpmodeObject:(STPOpmodeObject *)object;
@end

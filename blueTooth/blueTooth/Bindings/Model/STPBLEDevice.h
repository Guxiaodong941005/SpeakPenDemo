//
//  STPBLEDevice.h
//  STP
//
//  Created by Kris on 2017/10/31.
//  Copyright © 2017年 STP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface STPBLEDevice : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)CBPeripheral *Peripheral;
@end

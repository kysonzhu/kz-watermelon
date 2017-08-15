//
//  Watermelon.h
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WMBIOS.h"


static NSString  *WatermelonNotificationModeSettingFinished = @"cn.kyson.Notification.WatermelonNotificationModeSettingFinished";


@interface Watermelon : NSObject


/**
 * current boot mode
 */
@property (nonatomic, readonly) WMBootModeType currentBootModeType;

+(Watermelon *) shareInstance ;



/**
 * register service
 */
+(void) registeWatermelonService;






@end

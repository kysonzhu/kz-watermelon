//
//  WMAllMode.m
//  Watermelon
//
//  Created by kyson on 2017/8/15.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMAllMode.h"

#import "WMResourceCacheManager.h"

#import "WMPackageManager.h"

#import "Watermelon.h"

@implementation WMAllMode


+(void)start {
    
    [WMResourceCacheManager installCacheModule];
    [WMPackageManager checkCurrentVersionIsLatest];
    
    if (![WMPackageManager isPackageExists]) {
        [WMPackageManager installRemotePackageFinished:^{
            //post notification
            [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
            
        }];
    }
}



+(void)stop {
    [WMResourceCacheManager removeCacheModule];
    [WMPackageManager stopCheckCurrentVersionIsLatest];

}


@end

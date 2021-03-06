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
    //setup watermelon
    [WMResourceCacheManager installCacheModule];
    [WMPackageManager checkCurrentVersionIsLatestContinuous:YES];
    
    if ([WMPackageManager isPackageExists]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
        return;
    }
    
    [WMPackageManager downloadRemotePackageSuccess:^(NSString *zipPath) {
        
        [WMPackageManager installPackageWithDefaultDownloadPath];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
        
    } failed:^(NSError *error) {
        
    }];
}



+(void)stop {
    [WMResourceCacheManager removeCacheModule];
    [WMPackageManager checkCurrentVersionIsLatestContinuous:NO];
}


@end

//
//  WMUpdateMode.m
//  Watermelon
//
//  Created by kyson on 2017/8/15.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMUpdateMode.h"

#import "Watermelon.h"
#import "WMEnvironmentConfigure.h"
#import "WMPackageManager.h"

@implementation WMUpdateMode

+(void)start {
    [WMEnvironmentConfigure setVerJson:nil];
    [WMPackageManager installPackageWithDefaultDownloadPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];

}


+(void)stop {
    
}

@end

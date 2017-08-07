//
//  WMEnvironmentConfigure.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/7.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMEnvironmentConfigure.h"


#define K_VERSION_JSON @"K_VERSION_JSON"

@implementation WMEnvironmentConfigure




+(void)setVerJson:(NSString *)verJson {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults] ;
    [userDefaults setObject:K_VERSION_JSON forKey:verJson];
    [userDefaults synchronize];
}

+(NSString *)verJson {
    return [[NSUserDefaults standardUserDefaults]  objectForKey:K_VERSION_JSON];
}



@end

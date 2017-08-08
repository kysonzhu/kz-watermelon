//
//  WMBIOS.m
//  Watermelon
//
//  Created by kyson on 2017/8/8.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMBIOS.h"
#import <RealReachability.h>



@implementation WMBIOS


+(WMBIOS *) shareInstance{
    
    static WMBIOS *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}


- (void) startFinishBasicMode:(BootModeSuccess) success {
    [[RealReachability sharedInstance] startNotifier];
    
    [[RealReachability sharedInstance] reachabilityWithBlock:^(ReachabilityStatus status) {
        
        switch (status) {
            case RealStatusNotReachable:{
                //network can not be reachable, so basic module is ok
                success(WMBootModeBasicModule);
            }
                break;
            case RealStatusViaWWAN:
            case RealStatusViaWiFi:{
                success(WMBootModeAllModule);
            }
                break;
            default:
                break;
        }

    }];
    
}


@end

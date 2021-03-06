//
//  WMBIOS.m
//  Watermelon
//
//  Created by kyson on 2017/8/8.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "WMBIOS.h"

#import "WMModeProtocol.h"

#import "RealReachability.h"

#import "WMBasicMode.h"
#import "WMUpdateMode.h"
#import "WMAllMode.h"


@interface WMBIOS ()

@property (nonatomic, assign) id<WMModeProtocol> currentMode;

@end



@implementation WMBIOS


+(WMBIOS *) shareInstance{
    
    static WMBIOS *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}


- (void) startBasicModeFinished:(BootModeSuccess) success {
    [[RealReachability sharedInstance] reachabilityWithBlock:^(ReachabilityStatus status) {
        
        switch (status) {
            case RealStatusNotReachable:{
                //network can not be reachable, so basic module is ok
                success(WMBootModeTypeBasicModule);
            }
                break;
            case RealStatusViaWWAN:
            case RealStatusViaWiFi:{
                success(WMBootModeTypeAllModule);
            }
                break;
            default:
                break;
        }

    }];
    
}


-(void)switchToModeType:(WMBootModeType) modeType {
    
    switch (modeType) {
        case WMBootModeTypeBasicModule: {
            [WMAllMode stop];
            [WMUpdateMode stop];

            [WMBasicMode start];
        }
            break;
        case WMBootModeTypeAllModule: {
            [WMBasicMode stop];
            [WMUpdateMode stop];

            
            [WMAllMode start];
        }
            break;
        case WMBootModeTypeUpdateModule: {
            [WMAllMode stop];
            [WMBasicMode stop];
            
            [WMUpdateMode start];
        }
            break;
            
        default:
            break;
    }
}




@end

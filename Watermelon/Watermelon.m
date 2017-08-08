//
//  Watermelon.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "Watermelon.h"

#import "WMResourceCacheManager.h"
#import "WMPackageManager.h"
#import "WMEnvironmentConfigure.h"

#import "WMVer.h"



@interface Watermelon ()

/**
 * Package Manager
 */
@property (nonatomic, strong) WMPackageManager *packageManager;

@end

@implementation Watermelon


+(Watermelon *) shareInstance{
    static Watermelon *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}


+(void) registeWatermelonService{
    
    [[self shareInstance] registService];
    
    
}



-(void) registService {
    /**
     * start basic input and out put system
     */
    [[WMBIOS shareInstance] startFinishBasicMode:^(WMBootMode bootMode) {
        
        switch (bootMode) {
            case WMBootModeBasicModule:{
                if (![WMPackageManager isPackageExists]) {
                    [WMPackageManager installLocalPackage];
                }
                
            }
                break;
            case WMBootModeAllModule: {
                [WMResourceCacheManager installCacheModule];
                [WMPackageManager checkCurrentVersionIsLatest];
            }
                
            default:
                break;
        }
        
        _currentBootMode = bootMode;
        
        //post notification
        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
        
    }];

}




/**
 * Package Manager
 */
-(WMPackageManager *)packageManager {
    if (!_packageManager) {
        _packageManager = [[WMPackageManager alloc] init];
    }
    
    return _packageManager;
}





@end

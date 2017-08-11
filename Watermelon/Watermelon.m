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

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(latestVersionFound:) name:WatermelonNotificationNewVersionFinded object:nil];
    }
    return self;
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
                    //post notification
                    [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
                }
                
            }
                break;
            case WMBootModeAllModule: {
                [WMResourceCacheManager installCacheModule];
                
                if (![WMPackageManager isPackageExists]) {
                    [WMPackageManager installRemotePackageFinished:^{
                        //post notification
                        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
                    }];
                }
            }
                
            default:
                break;
        }
        
        _currentBootMode = bootMode;
        
        
        
    }];

}


- (void) latestVersionFound: (NSNotification *) notification {
    
    NSDictionary *notificationObj = notification.object;
    WMVer *verRemote = [[WMVer alloc] init];
    [verRemote loadPropertiesWithData:notificationObj];
    
    

    
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

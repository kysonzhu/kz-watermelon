//
//  Watermelon.m
//  Watermelon
//
//  Created by zhujinhui on 2017/8/5.
//  Copyright © 2017年 kyson. All rights reserved.
//

#import "Watermelon.h"
#import <UIKit/UIKit.h>

#import "WMResourceCacheManager.h"
#import "WMPackageManager.h"
#import "WMEnvironmentConfigure.h"

#import "WMVer.h"
#import <RealReachability.h>
#import "WMBIOS.h"


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
        [[RealReachability sharedInstance] startNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(latestVersionFound:) name:WatermelonNotificationNewVersionFinded object:nil];
    }
    return self;
}


+(void) registeWatermelonService{
    
    //start web thread
    UIWebView *webPool = [[UIWebView alloc]initWithFrame:CGRectZero];
    [webPool loadHTMLString:@"" baseURL:nil];
    //register
    [[self shareInstance] registService];
    
}



-(void) registService {
    /**
     * start basic input and out put system
     */
    [[WMBIOS shareInstance] startBasicModeFinished:^(WMBootModeType bootModeType) {
        [[WMBIOS shareInstance] switchToModeType:bootModeType];
        _currentBootModeType = bootModeType;
        
    }];

}


- (void) latestVersionFound: (NSNotification *) notification {
    
    NSDictionary *notificationObj = notification.object;
    WMVer *verRemote = [[WMVer alloc] init];
    [verRemote loadPropertiesWithData:notificationObj];
    

    [WMPackageManager installRemotePackageSuccess:^{
        //post notification
        [[NSNotificationCenter defaultCenter] postNotificationName:WatermelonNotificationModeSettingFinished object:nil];
        
    } failed:^{
        ;
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
